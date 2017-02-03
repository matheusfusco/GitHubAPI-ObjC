//
//  RepositoryManager.m
//  desafio-ios
//
//  Created by Matheus Fusco on 16/01/17.
//  Copyright © 2017 MatheusFusco. All rights reserved.
//

#import "RepositoryService.h"

@implementation RepositoryService
+(void) searchRepositoriesFor:(NSString *) language sortingBy:(NSString *) sort orderingBy:(NSString *) order withKeyWord:(NSString *) keyWord andPage:(NSInteger) page response:(void(^) (id responseObject, NSError * error)) response {
    
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc] init];
    if (keyWord == NULL || keyWord == nil || [keyWord isEqualToString:@""]) {
        parameters[@"q"] = [NSString stringWithFormat:@"language:%@", language];
    }
    else {
        parameters[@"q"] = [NSString stringWithFormat:@"%@+language:%@", keyWord, language];
    }
    
    if (![sort isEqualToString:@""]) {
        parameters[@"sort"] = sort;
    }
    
    if (![order isEqualToString:@""]) {
        parameters[@"order"] = order;
    }
    
    parameters[@"page"] = [NSString stringWithFormat:@"%ld", (long)page];
    
    
    //q=language:Java //OU// q=language:Swift //OU// q=language:ObjectiveC
    //&sort= 'stars', 'forks' ou 'updated'
    //&page=1
    //&order= 'asc' ou 'desc'

    [self get:URL_REPOSITORIES withParameters:parameters success:^(id responseObject) {
        if (responseObject) {
            response(responseObject, nil);
        }
    } error:^(NSError *errors) {
        if (errors) {
            response(nil, errors);
        }
    }];
}
@end
