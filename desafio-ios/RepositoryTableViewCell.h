//
//  RepositoryTableViewCell.h
//  desafio-ios
//
//  Created by Matheus Pacheco Fusco on 23/08/16.
//  Copyright © 2016 MatheusFusco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "Repository.h"

@interface RepositoryTableViewCell : UITableViewCell
@property (nonatomic, strong) Repository * repository;
@property (weak, nonatomic) IBOutlet UILabel *repositoryName;
@property (weak, nonatomic) IBOutlet UILabel *repositoryDescription;
@property (weak, nonatomic) IBOutlet UILabel *repositoryNumberOfForks;
@property (weak, nonatomic) IBOutlet UILabel *repositoryNumberOfStars;
@property (weak, nonatomic) IBOutlet UIImageView *repositoryOwnerPhoto;
@property (weak, nonatomic) IBOutlet UILabel *repositoryOwner;

@end
