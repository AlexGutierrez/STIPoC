//
//  ModifyOrderDetailsRequest.m
//  STIPoC
//
//  Created by Administrator on 11/25/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "ModifyOrderDetailsRequest.h"

static NSString *const kSTIPoCSelfServiceGenericECommerceLoginId = @"SDP-Implementation Team";
static NSString *const kSTIPoCSelfServiceGenericUserName = @"Carlos Ponce";

@implementation modifyOrderDetailsRequest

#pragma mark -
#pragma mark Custom Accessors

- (NSString *)ModifiedBy
{
    return kSTIPoCSelfServiceGenericECommerceLoginId;
}

- (NSString *)UserName
{
    return kSTIPoCSelfServiceGenericUserName;
}

@end
