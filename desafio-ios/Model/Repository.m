//
//  Repository.m
//  desafio-ios
//
//  Created by Matheus Pacheco Fusco on 23/08/16.
//  Copyright © 2016 MatheusFusco. All rights reserved.
//

#import "Repository.h"

@implementation Repository

+(NSDictionary *) JSONKeyPathsByPropertyKey
{
    return @{
             @"name"            : @"full_name",
             @"descr"           : @"description",
             @"numberOfStars"   : @"watchers_count",
             @"numberOfForks"   : @"forks_count",
             @"openIssues"      : @"open_issues_count",
             @"ownerUsername"   : @"owner.login",
             @"ownerPhoto"      : @"owner.avatar_url"
             };
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError *__autoreleasing *)error
{
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    return self;
}

@end
