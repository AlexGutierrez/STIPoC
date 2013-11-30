//
//  ErrorFactory.m
//  STIPoC
//
//  Created by Alex Gutierrez on 11/29/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "ErrorFactory.h"
#import "GenericSelfServiceResult.h"

@implementation ErrorFactory

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

#pragma mark -
#pragma mark Public Methods

- (NSError *)createErrorWithSelfServiceDomain:(NSString *)domain
                         andSelfServiceResult:(GenericSelfServiceResult *)genericSelfServiceResult
{
    NSError *error = [NSError errorWithDomain:domain
                                         code:[genericSelfServiceResult.ResponseCode integerValue]
                                     userInfo:@{NSLocalizedDescriptionKey : genericSelfServiceResult.ResponseMessage}
                      ];
    
    return error;
}

- (NSError *)createErrorWithSelfServiceDomain:(NSString *)domain
                               andDescription:(NSString *)description
{
    NSError *error = [NSError errorWithDomain:domain code:1234567 userInfo:@{NSLocalizedDescriptionKey : description}];
    
    return error;
}

- (NSError *)createDefaultNetworkReachabilityError
{
    NSError *error = [NSError errorWithDomain:NSLocalizedString(@"Network error", nil) code:1234567 userInfo:@{NSLocalizedDescriptionKey : NSLocalizedString(@"Please verify your internet connection.", nil)}];
    
    return error;
}

- (NSError *)createDefaultServerError
{
    NSError *error = [NSError errorWithDomain:NSLocalizedString(@"Internal error", nil) code:1234567 userInfo:@{NSLocalizedDescriptionKey : NSLocalizedString(@"Woops! Something unexpected ocurred. Don't worry, we'll fix it right away! Error ID: 4242564", nil)}];
    
    return error;
}

@end
