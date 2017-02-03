//
//  PullRequestTableViewController.m
//  desafio-ios
//
//  Created by Matheus Pacheco Fusco on 24/08/16.
//  Copyright © 2016 MatheusFusco. All rights reserved.
//

#import "PullRequestTableViewController.h"


@interface PullRequestTableViewController ()
{
    PullRequest * pullRequest;
    NSMutableArray * pulls;
}

@end

@implementation PullRequestTableViewController

#pragma mark - Initialization & View Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    pulls = [[NSMutableArray alloc] init];
    self.title = _repositoryToLoad;
    
    PullRequestModel * model = [[PullRequestModel alloc] init];
    model.delegate = self;
    [model fetchPullRequestsFrom:_repositoryToLoad];
}

#pragma mark - TableView DataSource & Delegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (pulls.count > 0) {
        return pulls.count;
    }
    else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * CellIdentifier = @"pullRequestCell";
    
    PullRequestTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[PullRequestTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    pullRequest = [pulls objectAtIndex:indexPath.row];
    [cell setPullRequest:pullRequest];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    pullRequest = [pulls objectAtIndex:indexPath.row];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:pullRequest.URL]];
}

#pragma mark - Custom Delegate Methods
-(void)fetchedPullRequests:(NSMutableArray *)pullReqs {
    //NSLog(@"prs: %@", pullReqs);
    for (PullRequest * pr in pullReqs) {
        [pulls addObject:pr];
    }
    [self.tableView reloadData];
}

#pragma mark - Memory Management
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
