//
//  PullRequestModel.m
//  desafio-ios
//
//  Created by Matheus Fusco on 18/01/17.
//  Copyright © 2017 MatheusFusco. All rights reserved.
//

#import "PullRequestModel.h"
#import "PullRequestService.h"
#import <MBProgressHUD.h>
#import "PullRequest.h"

@implementation PullRequestModel
@synthesize delegate;
-(void)fetchPullRequestsFrom:(NSString *)repository {
    UIViewController * curVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:curVC.view animated:YES];
    
    NSMutableArray * pullReq = [[NSMutableArray alloc] init];
    
    [PullRequestService searchPullRequestsFor:repository response:^(id responseObject, NSError *error) {
        if (error) {
            NSLog(@"error: %@", error);
        }
        else {
            //NSLog(@"response 0: %@", [responseObject objectAtIndex:0]);
            NSMutableArray * prArray = [[NSMutableArray alloc] initWithArray:responseObject];
            for (int i = 0; i < prArray.count; i++) {
                NSDictionary * dict = [[NSDictionary alloc] init];
                dict = [prArray objectAtIndex:i];
                
                PullRequest * pr = [MTLJSONAdapter modelOfClass:[PullRequest class] fromJSONDictionary:dict error:&error];
                [pullReq addObject:pr];
                //NSLog(@"prs: %@", pullReq);
            }
            [self.delegate fetchedPullRequests:pullReq];
            [hud hideAnimated:YES];
        }
    }];
}
@end
