//
//  PullRequestTableViewCell.m
//  desafio-ios
//
//  Created by Matheus Pacheco Fusco on 24/08/16.
//  Copyright © 2016 MatheusFusco. All rights reserved.
//

#import "PullRequestTableViewCell.h"

@implementation PullRequestTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setPullRequest:(PullRequest *)pullRequest
{
    _pullRequestTitle.text = pullRequest.title;
    
    _pullRequestDescription.text = pullRequest.body;
    
    _pullRequestDate.text = [self convertDate: pullRequest.date];
    
    _pullRequestOwner.text = pullRequest.ownerUsername;
    
    [_pullRequestOwnerPhoto sd_setImageWithURL:[NSURL URLWithString:pullRequest.ownerPhoto] placeholderImage:[UIImage imageNamed:@"userPhoto.png"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(NSString *) convertDate :(NSString *)dateToConvert
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd'T'HH:mm:ss'Z'"];
    NSDate *prevday = [formatter dateFromString:dateToConvert];
    
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    [formatter2 setDateFormat:@"MMM, dd/YYYY - HH:mm:ss"];
    NSString * str = [formatter2 stringFromDate:prevday];
    
    return str;
}

@end
