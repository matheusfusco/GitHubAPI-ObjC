//
//  APIManager.m
//  desafio-ios
//
//  Created by Matheus Fusco on 16/01/17.
//  Copyright © 2017 MatheusFusco. All rights reserved.
//

#import "APIManager.h"

@implementation APIManager
+(void) get:(NSString *) service withParameters:(NSDictionary *) params success:(void(^)(id responseObject)) success error:(void (^)(NSError * error)) error {
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:service parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull errors) {
        if (errors) {
            error(errors);
        }
    }];
}
@end
