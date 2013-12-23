//
//  AttributeTypeValue+Copy.m
//  STIPoC
//
//  Created by Administrator on 12/23/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "AttributeTypeValue+Copy.h"
#import "Entity+Copy.h"

@implementation AttributeTypeValue (Copy)

- (id)copyWithZone:(NSZone *)zone
{
    AttributeTypeValue *attributeTypeValueCopy = nil;
    
    if (self.currentLocalContext) {
        attributeTypeValueCopy = [AttributeTypeValue createInContext:self.currentLocalContext];
        attributeTypeValueCopy.entityID = [NSString stringWithString:self.entityID];
        attributeTypeValueCopy.name = [NSString stringWithString:self.name];
        attributeTypeValueCopy.sequence = [NSNumber numberWithInteger:self.sequence.integerValue];
    }
    
    return attributeTypeValueCopy;
}

@end
