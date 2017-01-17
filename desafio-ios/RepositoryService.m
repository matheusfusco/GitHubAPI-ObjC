//
//  RepositoryManager.m
//  desafio-ios
//
//  Created by Matheus Fusco on 16/01/17.
//  Copyright © 2017 MatheusFusco. All rights reserved.
//

#import "RepositoryService.h"

@implementation RepositoryService
+(void) searchRepositoriesFor:(NSString *) language sortingBy:(NSString *) sort orderingBy:(NSString *) order andPage:(NSInteger) page response:(void(^) (id responseObject, NSError * error)) response {
    NSDictionary * params = @{@"q" : [NSString stringWithFormat:@"language:%@", language],
                              @"sort" : sort,
                              @"page" : [NSString stringWithFormat:@"%ld", (long)page],
                              };
    //q=language:Java //OU// q=language:Swift //OU// q=language:ObjectiveC
    //&sort= 'stars', 'forks' ou 'updated'
    //&page=1
    //&order= 'asc' ou 'desc'
    
    [self get:URL_REPOSITORIES withParameters:params success:^(id responseObject) {
        response(responseObject, nil);
    } error:^(NSError *errors) {
        response(nil, errors);
    }];
}
@end
