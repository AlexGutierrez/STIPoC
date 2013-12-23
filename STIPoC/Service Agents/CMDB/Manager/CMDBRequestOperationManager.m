//
//  CMDBRequestOperationManager.m
//  STIPoC
//
//  Created by Administrator on 12/23/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "CMDBRequestOperationManager.h"

static NSString *const kSTIPoCCMDBEndpointURLBaseString = @"https://services-qa.oss.terremark.com/MobilePoC/api/";

@implementation CMDBRequestOperationManager

#pragma mark -
#pragma mark Class Methods

+ (instancetype)sharedManager
{
    static CMDBRequestOperationManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[CMDBRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kSTIPoCCMDBEndpointURLBaseString]];
        _sharedManager.responseSerializer =  [AFJSONResponseSerializer serializer];
        _sharedManager.requestSerializer =  [AFJSONRequestSerializer serializer];
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        securityPolicy.SSLPinningMode = AFSSLPinningModeNone;
        _sharedManager.securityPolicy = securityPolicy;
    });
    return _sharedManager;
}

#pragma mark -
#pragma mark CMDB Operations

- (void)startGetDomainsRequestOperationWithCompletionBlock:(void(^)(id responseObject))completion
                                           andFailureBlock:(void(^)(NSError *internalError))failure
{
    AFHTTPRequestOperation *getDomainsRequestOperation = [self GET:@"Domains"
                                                        parameters:nil
                                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                               DDLogInfo(@"Get Domains SUCCEEDED");
                                                               if (completion) {
                                                                   completion(responseObject);
                                                               }
                                                           }
                                                           failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                               DDLogError(@"Get Domains FAILED:\n%@", error);
                                                               if (failure) {
                                                                   failure(error);
                                                               }
                                                           }];
    
    [getDomainsRequestOperation start];
}

@end
