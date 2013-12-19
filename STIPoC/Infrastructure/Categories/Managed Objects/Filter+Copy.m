//
//  Filter+Copy.m
//  STIPoC
//
//  Created by Alex Gutierrez on 12/19/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "Filter+Copy.h"
#import "Entity+Copy.h"

@implementation Filter (Copy)

- (id)copyWithZone:(NSZone *)zone
{
    Filter *filterCopy = nil;
    
    if (self.currentLocalContext) {
        filterCopy = [Filter createInContext:self.currentLocalContext];
        filterCopy.type = [NSNumber numberWithInteger:self.type.integerValue];
        filterCopy.value = [NSString stringWithString:self.value];
    }
    
    return filterCopy;
}

@end
