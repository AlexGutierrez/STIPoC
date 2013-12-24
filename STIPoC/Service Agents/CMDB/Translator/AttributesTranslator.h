//
//  AttributesTranslator.h
//  STIPoC
//
//  Created by Administrator on 12/23/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Attribute;

@interface AttributesTranslator : NSObject

+ (void)translateAttributeJSONDictionary:(NSDictionary *)attributeDictionary toAttribute:(Attribute*)attribute;

@end
