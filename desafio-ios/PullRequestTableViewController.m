//
//  PullRequestTableViewController.m
//  desafio-ios
//
//  Created by Matheus Pacheco Fusco on 24/08/16.
//  Copyright © 2016 MatheusFusco. All rights reserved.
//

#import "PullRequestTableViewController.h"
#import "PullRequestTableViewCell.h"
#import "PullRequest.h"

#import "AFURLRequestSerialization.h"
#import "AFURLSessionManager.h"

#import "MBProgressHUD.h"

@interface PullRequestTableViewController ()
{
    PullRequest * pullRequest;
    NSMutableArray * pulls;
}

@end

@implementation PullRequestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    pulls = [[NSMutableArray alloc] init];
    self.title = _repositoryToLoad;
    [self loadPullRequestsFrom:_repositoryToLoad];
}

#pragma mark - TableView DataSource & Delegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (pulls.count > 0) {
        return pulls.count;
    }
    else
    {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * CellIdentifier = @"pullRequestCell";
    
    PullRequestTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[PullRequestTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    pullRequest = [[PullRequest alloc] init];
    pullRequest = [pulls objectAtIndex:indexPath.row];
    [cell setPullRequest:pullRequest];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    pullRequest = [pulls objectAtIndex:indexPath.row];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:pullRequest.URL]];
}

#pragma mark - Custom Methods
-(void)loadPullRequestsFrom:(NSString*)repository
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager * manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSString * URLString = [NSString stringWithFormat:@"https://api.github.com/repos/%@/pulls", repository];
    NSURL *URL = [NSURL URLWithString:URLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            
            NSMutableArray * prArray = [[NSMutableArray alloc] initWithArray:responseObject];
            for (int i = 0; i < prArray.count; i++) {
                NSDictionary * dict = [[NSDictionary alloc] init];
                dict = [prArray objectAtIndex:i];
                
                PullRequest * pr = [MTLJSONAdapter modelOfClass:[PullRequest class] fromJSONDictionary:dict error:&error];
                [pulls addObject:pr];
            }
            [self.tableView reloadData];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    [dataTask resume];
}

#pragma mark - Memory Management
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
