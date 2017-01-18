//
//  PullRequestService.m
//  desafio-ios
//
//  Created by Matheus Fusco on 18/01/17.
//  Copyright © 2017 MatheusFusco. All rights reserved.
//

#import "PullRequestService.h"

@implementation PullRequestService
+(void)searchPullRequestsFor:(NSString *)repository response:(void(^) (id responseObject, NSError * error)) response {
    NSString * URLString = [NSString stringWithFormat:@"%@/%@/pulls", URL_PULL_REQUESTS, repository];
    
    [self get:URLString withParameters:nil success:^(id responseObject) {
        if (responseObject) {
            //NSLog(@"response: %@", responseObject);
            response(responseObject, nil);
        }
    } error:^(NSError *errors) {
        if (errors) {
            response(nil, errors);
        }
    }];
}
@end
