//
//  Attribute+Copy.m
//  STIPoC
//
//  Created by Alex Gutierrez on 12/19/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "Attribute+Copy.h"
#import "Entity+Copy.h"
#import "Filter+Copy.h"

@implementation Attribute (Copy)

- (id)copyWithZone:(NSZone *)zone
{
    Attribute *attributeCopy = nil;
    
    if (self.currentLocalContext) {
        attributeCopy = [Attribute createInContext:self.currentLocalContext];
        attributeCopy.name = [NSString stringWithString:self.name];
        attributeCopy.type = [NSString stringWithString:self.type];
        attributeCopy.orderType = [NSNumber numberWithInteger:self.orderType.integerValue];
        attributeCopy.orderPriority = [NSNumber numberWithInteger:self.orderPriority.integerValue];
        attributeCopy.selectOrder = [NSNumber numberWithInteger:self.selectOrder.integerValue];
        attributeCopy.selected = [NSNumber numberWithInteger:self.selected.integerValue];
        
        for (Filter *filter in self.filters) {
            filter.currentLocalContext = self.currentLocalContext;
            [attributeCopy addFiltersObject:[filter copy]];
            filter.currentLocalContext = nil;
        }
    }
    
    return attributeCopy;
}

@end
