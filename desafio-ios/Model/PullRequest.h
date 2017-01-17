//
//  PullRequest.h
//  desafio-ios
//
//  Created by Matheus Pacheco Fusco on 24/08/16.
//  Copyright © 2016 MatheusFusco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
#import "MTLJSONAdapter.h"

@interface PullRequest : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * body;
@property (nonatomic, strong) NSString * date;
@property (nonatomic, strong) NSString * ownerUsername;
@property (nonatomic, strong) NSString * ownerPhoto;
@property (nonatomic, strong) NSString * URL;
@end
