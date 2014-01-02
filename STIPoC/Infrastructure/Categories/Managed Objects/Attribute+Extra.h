//
//  Attribute+Copy.h
//  STIPoC
//
//  Created by Alex Gutierrez on 12/19/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "Attribute.h"

typedef enum {
    AttributeOrderTypeAsc,
    AttributeOrderTypeDesc,
    AttributeOrderTypeNone
} AttributeOrderType;

@interface Attribute (Extra) <NSCopying>

+ (NSString *)stringFromAttributeOrderType:(AttributeOrderType)attributeOrderType;

@end
