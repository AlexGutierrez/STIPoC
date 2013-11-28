//
//  GenericXMLParser.m
//  STIPoC
//
//  Created by Administrator on 11/22/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "GenericXMLParser.h"

NSString *const kSTIPoCSOAPActionAttributes = @"xmlns=\"http://tempuri.org/\" xmlns:i=\"http://www.w3.org/2001/XMLSchema-instance\"";
NSString *const kSTIPoCSOAPActionFormat = @"<s:Envelope xmlns:s=\"http://schemas.xmlsoap.org/soap/envelope/\"><s:Body>%@%@%@</s:Body></s:Envelope>";

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
