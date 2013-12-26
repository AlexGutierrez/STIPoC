//
//  Attribute+Copy.m
//  STIPoC
//
//  Created by Alex Gutierrez on 12/19/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "Attribute+Extra.h"
#import "Entity+Extra.h"
#import "Filter+Extra.h"
#import "AttributeTypeValue+Extra.h"

@implementation Attribute (Extra)

#pragma mark - 
#pragma mark Copying Protocols

- (id)copyWithZone:(NSZone *)zone
{
    Attribute *attributeCopy = nil;
    
    if (self.currentLocalContext) {
        attributeCopy = [Attribute createInContext:self.currentLocalContext];
        attributeCopy.entityID = [NSString stringWithString:self.entityID];
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
        
        for (AttributeTypeValue *attributeTypeValue in self.typeValues) {
            attributeTypeValue.currentLocalContext = self.currentLocalContext;
            [attributeCopy addTypeValuesObject:[attributeTypeValue copy]];
            attributeTypeValue.currentLocalContext = nil;
        }
    }
    
    return attributeCopy;
}

#pragma mark -
#pragma mark Attribute Order Type

+ (NSString *)stringFromAttributeOrderType:(AttributeOrderType)attributeOrderType
{
    switch (attributeOrderType) {
        case AttributeOrderTypeNone:
            return NSLocalizedString(@"None", nil);
            break;
        case AttributeOrderTypeAsc:
            return NSLocalizedString(@"Ascendent", nil);
            break;
        case AttributeOrderTypeDesc:
            return NSLocalizedString(@"Descendent", nil);
            break;
        default:
            break;
    }
}

@end
