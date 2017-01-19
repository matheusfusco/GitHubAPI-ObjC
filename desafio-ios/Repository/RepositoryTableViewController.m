//
//  RepositoryTableViewController.m
//  desafio-ios
//
//  Created by Matheus Pacheco Fusco on 23/08/16.
//  Copyright © 2016 MatheusFusco. All rights reserved.
//

#import "RepositoryTableViewController.h"


@interface RepositoryTableViewController ()
{
    Repository * repository;
    NSMutableArray * repositories;
    NSInteger page;
    RepositoryModel * model;
}

@end

@implementation RepositoryTableViewController

#pragma mark - Initialization & View Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    page = 1;
    repositories = [[NSMutableArray alloc] init];
    model = [[RepositoryModel alloc] init];
    model.delegate = self;
    [model fetchRepositories:page];
}

#pragma mark - TableView Data Source & Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (repositories.count > 0) {
        return repositories.count;
    }
    else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * CellIdentifier = @"repositoryCell";
    
    RepositoryTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[RepositoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    repository = [repositories objectAtIndex:indexPath.row];
    [cell setRepository:repository];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    repository = [repositories objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"loadRepositoryPRs" sender:self];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath isEqual:[NSIndexPath indexPathForRow:[self tableView:self.tableView numberOfRowsInSection:0] -1 inSection: 0]])
    {
        page += 1;
        [model fetchRepositories: page];
    }
}

#pragma mark - Custom Delegate Methods
-(void)fetchedRepositories:(NSMutableArray *)repos {
    for (Repository * repo in repos) {
        [repositories addObject:repo];
    }
    [self.tableView reloadData];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[PullRequestTableViewController class]]) {
        [(PullRequestTableViewController *)segue.destinationViewController setRepositoryToLoad:repository.name];
    }
}

#pragma mark - Memory Management
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
