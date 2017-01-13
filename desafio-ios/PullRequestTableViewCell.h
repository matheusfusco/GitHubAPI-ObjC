//
//  PullRequestTableViewCell.h
//  desafio-ios
//
//  Created by Matheus Pacheco Fusco on 24/08/16.
//  Copyright © 2016 MatheusFusco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "PullRequest.h"

@interface PullRequestTableViewCell : UITableViewCell
@property (nonatomic, strong) PullRequest * pullRequest;
@property (weak, nonatomic) IBOutlet UILabel *pullRequestTitle;
@property (weak, nonatomic) IBOutlet UIImageView *pullRequestOwnerPhoto;
@property (weak, nonatomic) IBOutlet UILabel *pullRequestDate;
@property (weak, nonatomic) IBOutlet UILabel *pullRequestOwner;
@property (weak, nonatomic) IBOutlet UILabel *pullRequestDescription;

@end
