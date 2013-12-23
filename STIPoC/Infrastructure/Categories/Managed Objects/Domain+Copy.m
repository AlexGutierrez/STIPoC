//
//  Domain+Copy.m
//  STIPoC
//
//  Created by Alex Gutierrez on 12/19/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "Domain+Copy.h"
#import "Attribute+Copy.h"
#import "Entity+Copy.h"

@implementation Domain (Copy)

- (id)copyWithZone:(NSZone *)zone
{
    Domain *domainCopy = nil;
    
    if (self.currentLocalContext) {
        domainCopy = [Domain createInContext:self.currentLocalContext];
        domainCopy.name = [NSString stringWithString:self.name];
        domainCopy.instanceCount = [NSNumber numberWithInteger:self.instanceCount.integerValue];
        
        for (Attribute *attribute in self.attributes) {
            attribute.currentLocalContext = self.currentLocalContext;
            [domainCopy addAttributesObject:[attribute copy]];
            attribute.currentLocalContext = nil;
        }
    }
    
    return domainCopy;
}

@end
