//
//  GenericXMLParser.h
//  STIPoC
//
//  Created by Administrator on 11/22/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+ObjectMap.h"

extern NSString *const kSTIPoCSOAPActionAttributes;
extern NSString *const kSTIPoCSOAPActionFormat;

@interface GenericXMLParser : NSObject

+ (NSString *)elementStringFromXMLString:(NSString *)xmlString withOpenTag:(NSString *)openTag andCloseTag:(NSString *)closeTag;

@end
