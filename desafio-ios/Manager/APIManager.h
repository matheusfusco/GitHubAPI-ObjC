//
//  APIManager.h
//  desafio-ios
//
//  Created by Matheus Fusco on 16/01/17.
//  Copyright © 2017 MatheusFusco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface APIManager : NSObject
+(void) get:(NSString *) service withParameters:(NSDictionary *) params success:(void(^)(id responseObject)) success error:(void (^)(NSError * error)) error;
@end
