//
//  RepositoryTableViewController.m
//  desafio-ios
//
//  Created by Matheus Pacheco Fusco on 23/08/16.
//  Copyright © 2016 MatheusFusco. All rights reserved.
//

#import "RepositoryTableViewController.h"
#import "RepositoryTableViewCell.h"
#import "Repository.h"

#import "AFURLRequestSerialization.h"
#import "AFURLSessionManager.h"

#import "MBProgressHUD.h"

#import "PullRequestTableViewController.h"

@interface RepositoryTableViewController ()
{
    Repository * repository;
    NSMutableArray * repositories;
    NSInteger page;
}

@end

@implementation RepositoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    page = 1;
    repositories = [[NSMutableArray alloc] init];
    [self downloadRepositories];
}

#pragma mark - TableView Data Source & Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (repositories.count > 0) {
        return repositories.count;
    }
    else
    {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * CellIdentifier = @"repositoryCell";
    
    RepositoryTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[RepositoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    repository = [[Repository alloc] init];
    repository = [repositories objectAtIndex:indexPath.row];
    [cell setRepository:repository];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    repository = [repositories objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"loadRepositoryPRs" sender:self];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath isEqual:[NSIndexPath indexPathForRow:[self tableView:self.tableView numberOfRowsInSection:0]-1 inSection:0]])
    {
        page += 1;
        [self downloadRepositories];
    }
}

#pragma mark - Connection Methods

-(void)downloadRepositories
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager * manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSString * URLString = [NSString stringWithFormat:@"https://api.github.com/search/repositories?q=language:Java&sort=stars&page=%ld", (long)page];
    NSURL *URL = [NSURL URLWithString:URLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            
            NSMutableArray * repoArray = [[NSMutableArray alloc] initWithArray:[responseObject objectForKey:@"items"]];
            
            for (int i = 0; i < repoArray.count; i++) {
                NSDictionary * dict = [[NSDictionary alloc] init];
                dict = [repoArray objectAtIndex:i];
                
                Repository * rp = [MTLJSONAdapter modelOfClass:[Repository class] fromJSONDictionary:dict error:&error];
                [repositories addObject:rp];
            }
            [self.tableView reloadData];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    [dataTask resume];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.destinationViewController isKindOfClass:[PullRequestTableViewController class]]) {
        // Configure Books View Controller
        [(PullRequestTableViewController *)segue.destinationViewController setRepositoryToLoad:repository.name];
    }
}

#pragma mark - Memory Management
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
