//
//  RepositoryManager.h
//  desafio-ios
//
//  Created by Matheus Fusco on 16/01/17.
//  Copyright © 2017 MatheusFusco. All rights reserved.
//

#import "APIManager.h"

@interface RepositoryService : APIManager
+(void) searchRepositoriesFor:(NSString *) language sortingBy:(NSString *) sort orderingBy:(NSString *) order andPage:(NSInteger) page response:(void(^) (id responseObject, NSError * error)) response;
@end
