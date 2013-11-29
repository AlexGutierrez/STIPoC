//
//  GenericFactory.m
//  STIPoC
//
//  Created by Alex Gutierrez on 11/29/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "GenericFactory.h"

@implementation GenericFactory

#pragma mark -
#pragma mark Class Methods

+ (instancetype)sharedFactory
{
    static id _sharedFactory = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedFactory = [[self class] new];
    });
    return _sharedFactory;
}

@end
