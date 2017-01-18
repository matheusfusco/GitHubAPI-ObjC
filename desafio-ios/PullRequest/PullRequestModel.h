//
//  PullRequestModel.h
//  desafio-ios
//
//  Created by Matheus Fusco on 18/01/17.
//  Copyright © 2017 MatheusFusco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PullRequestModel;
@protocol PullRequestDelegate <NSObject>
@required
-(void)fetchedPullRequests:(NSMutableArray *) pullReqs;
@end

@interface PullRequestModel : NSObject
@property (nonatomic, retain) id <PullRequestDelegate> delegate;
-(void) fetchPullRequestsFrom:(NSString *)repository;
@end
