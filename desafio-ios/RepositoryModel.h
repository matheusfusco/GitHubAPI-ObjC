//
//  RepositoryModel.h
//  desafio-ios
//
//  Created by Matheus Fusco on 17/01/17.
//  Copyright © 2017 MatheusFusco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RepositoryModel;
@protocol RepositoryDelegate <NSObject>
@required
-(void)fetchedRepositories:(NSMutableArray *) repos;
@end

@interface RepositoryModel : NSObject
@property (nonatomic, retain) id <RepositoryDelegate> delegate;
-(void) fetchRepositories:(NSInteger) page;
@end
