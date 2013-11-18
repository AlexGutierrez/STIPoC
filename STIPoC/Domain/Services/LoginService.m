//
//  LoginService.m
//  STIPoC
//
//  Created by Administrator on 11/18/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "LoginService.h"

@implementation LoginService

#pragma mark -
#pragma mark Class Methods

+ (instancetype)sharedInstance
{
    static LoginService *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [LoginService new];
    });
    return _sharedInstance;
}

#pragma mark -
#pragma mark Public methods

- (BOOL)validateCredentialsWithUserID:(NSString *)userID domain:(NSString *)domain andPassword:(NSString *)password
{
    // Validating empty fields
    BOOL emptyFieldExists = (!userID || [userID isEqualToString:@""] || !password || [password isEqualToString:@""] || !domain || [domain isEqualToString:@""]);
    
    // Validating credentials against DB
    BOOL wrongCredentialsFound = !([userID isEqualToString:@"ValidUserID"] && [password isEqualToString:@"ValidPassword"] && [domain isEqualToString:@"ValidDomain"]);
    
    return !(emptyFieldExists || wrongCredentialsFound);
}

@end
