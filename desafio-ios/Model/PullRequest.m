//
//  PullRequest.m
//  desafio-ios
//
//  Created by Matheus Pacheco Fusco on 24/08/16.
//  Copyright © 2016 MatheusFusco. All rights reserved.
//

#import "PullRequest.h"

@implementation PullRequest
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"title" : @"title",
             @"date" : @"created_at",
             @"body" : @"body",
             @"ownerUsername" : @"user.login",
             @"ownerPhoto" : @"user.avatar_url",
             @"URL" : @"html_url"
             };
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError *__autoreleasing *)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    return self;
}
@end
