//
//  LineItemAttribute.m
//  STIPoC
//
//  Created by Administrator on 11/21/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "LineItemAttribute.h"

@implementation LineItemAttribute

#pragma mark -
#pragma mark Copying Protocols 

- (id)copyWithZone:(NSZone *)zone
{
    LineItemAttribute *copy = [LineItemAttribute new];
    
    copy.Name = [self.Name copy];
    copy.Value = [self.Value copy];
    
    return copy;
}

@end
