//
//  PullRequestService.h
//  desafio-ios
//
//  Created by Matheus Fusco on 18/01/17.
//  Copyright © 2017 MatheusFusco. All rights reserved.
//

#import "APIManager.h"

@interface PullRequestService : APIManager
+(void)searchPullRequestsFor:(NSString *)repository response:(void(^) (id responseObject, NSError * error)) response;
@end
