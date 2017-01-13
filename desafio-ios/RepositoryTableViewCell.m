//
//  RepositoryTableViewCell.m
//  desafio-ios
//
//  Created by Matheus Pacheco Fusco on 23/08/16.
//  Copyright © 2016 MatheusFusco. All rights reserved.
//

#import "RepositoryTableViewCell.h"

@implementation RepositoryTableViewCell

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

-(void)setRepository:(Repository *)repository
{
    _repositoryName.text = repository.name;
    _repositoryDescription.text = repository.descr;
    
    _repositoryNumberOfForks.text = [NSString stringWithFormat:@"%ld", (long)repository.numberOfForks];
    _repositoryNumberOfStars.text = [NSString stringWithFormat:@"%ld", (long)repository.numberOfStars];
    
    _repositoryOwner.text = repository.ownerUsername;
    [_repositoryOwnerPhoto sd_setImageWithURL:[NSURL URLWithString:repository.ownerPhoto] placeholderImage:[UIImage imageNamed:@"userPhoto.png"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
