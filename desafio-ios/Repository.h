//
//  Repository.h
//  desafio-ios
//
//  Created by Matheus Pacheco Fusco on 23/08/16.
//  Copyright © 2016 MatheusFusco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
#import "MTLJSONAdapter.h"

@interface Repository : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * descr;
@property (nonatomic, assign) NSInteger  numberOfStars;
@property (nonatomic, assign) NSInteger  numberOfForks;
@property (nonatomic, assign) NSInteger  openIssues;
@property (nonatomic, strong) NSString * ownerUsername;
@property (nonatomic, strong) NSString * ownerPhoto;

@end
