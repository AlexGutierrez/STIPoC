//
//  GenericXMLParser.m
//  STIPoC
//
//  Created by Administrator on 11/22/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "GenericXMLParser.h"

@implementation GenericXMLParser

+ (NSString *)elementStringFromXMLString:(NSString *)xmlString withOpenTag:(NSString *)openTag andCloseTag:(NSString *)closeTag
{
    NSRange elementOpenTagRange = [xmlString rangeOfString:openTag];
    NSRange elementCloseTagRange = [xmlString rangeOfString:closeTag];
    
    NSUInteger location = elementOpenTagRange.location;
    NSUInteger length = elementCloseTagRange.location + elementCloseTagRange.length - location;
    
    NSRange elementRange = NSMakeRange(location, length);
    
    NSString *elementString = [xmlString substringWithRange:elementRange];
    
    return elementString;
}

@end
