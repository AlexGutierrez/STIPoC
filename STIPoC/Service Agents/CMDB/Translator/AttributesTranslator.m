//
//  AttributesTranslator.m
//  STIPoC
//
//  Created by Administrator on 12/23/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "AttributesTranslator.h"
#import "Attribute.h"
#import "AttributeTypeValue.h"

static NSString *const kSTIPoCAttributeIDAttributeKey = @"AttributeID";
static NSString *const kSTIPoCAttributeTypeAttributeKey = @"AttributeType";
static NSString *const kSTIPoCNameAttributeKey = @"Name";
static NSString *const kSTIPoCTypeValuesAttributeKey = @"TypeValues";
static NSString *const kSTIPoCAttributeTypeValueIDAttributeKey = @"AttributeTypeValueID";
static NSString *const kSTIPoCAttributeTypeValueNameAttributeKey = @"AttributeTypeValueName";
static NSString *const kSTIPoCSequenceAttributeKey = @"Sequence";

@implementation AttributesTranslator

+ (void)translateAttributeJSONDictionary:(NSDictionary *)attributeDictionary toAttribute:(Attribute*)attribute
{
    NSNumber *entityIDNumber = [attributeDictionary objectForKey:kSTIPoCAttributeIDAttributeKey];
    attribute.entityID = [NSString stringWithFormat:@"%i", entityIDNumber.integerValue];
    attribute.type = [attributeDictionary objectForKey:kSTIPoCAttributeTypeAttributeKey];
    attribute.name = [attributeDictionary objectForKey:kSTIPoCNameAttributeKey];
    attribute.selectOrder = nil;
    attribute.selected = @NO;
    
    NSArray *typeValues = [attributeDictionary objectForKey:kSTIPoCTypeValuesAttributeKey];
    for (NSDictionary *typeValueDictionary in typeValues) {
        AttributeTypeValue *typeValue = [AttributeTypeValue createEntity];
        
        NSNumber *entityIDNumber = [typeValueDictionary objectForKey:kSTIPoCAttributeTypeValueIDAttributeKey];
        typeValue.entityID = [NSString stringWithFormat:@"%i", entityIDNumber.integerValue];
        typeValue.name = [typeValueDictionary objectForKey:kSTIPoCAttributeTypeValueNameAttributeKey];
        typeValue.sequence = [typeValueDictionary objectForKey:kSTIPoCSequenceAttributeKey];
        
        [attribute addTypeValuesObject:typeValue];
    }
}

@end
