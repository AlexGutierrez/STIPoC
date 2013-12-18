//
//  User+CustomAccessors.m
//  STIPoC
//
//  Created by Administrator on 11/20/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "User+CustomAccessors.h"
#import "Customer.h"

@implementation User (CustomAccessors)

#pragma mark -
#pragma mark Custom Accessors

- (NSString *)fullName
{
    return [NSString stringWithFormat:@"%@, %@", self.lastName, self.firstName];
}

- (NSString *)fullAccount
{
    return [NSString stringWithFormat:@"%@/%@", self.customer.entityID, self.entityID];
}

@end
