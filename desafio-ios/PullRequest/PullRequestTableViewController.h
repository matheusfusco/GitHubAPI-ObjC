//
//  PullRequestTableViewController.h
//  desafio-ios
//
//  Created by Matheus Pacheco Fusco on 24/08/16.
//  Copyright © 2016 MatheusFusco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullRequestTableViewCell.h"
#import "PullRequest.h"
#import "PullRequestModel.h"

@interface PullRequestTableViewController : UITableViewController <PullRequestDelegate>
@property (nonatomic, strong) NSString * repositoryToLoad;
@end
