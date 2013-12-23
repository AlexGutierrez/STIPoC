//
//  CMDBRequestOperationManager.h
//  STIPoC
//
//  Created by Administrator on 12/23/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface CMDBRequestOperationManager : AFHTTPRequestOperationManager

+ (instancetype)sharedManager;

- (void)startGetDomainsRequestOperationWithCompletionBlock:(void(^)(id responseObject))completion
                                           andFailureBlock:(void(^)(NSError *internalError))failure;

@end
