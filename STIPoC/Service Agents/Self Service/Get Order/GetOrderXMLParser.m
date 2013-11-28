//
//  GetOrderXMLParser.m
//  STIPoC
//
//  Created by Administrator on 11/25/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "GetOrderXMLParser.h"
#import "getOrderRequest.h"
#import "GetOrderResult.h"

static NSString *const kSTIPoCSelfServiceGetOrderTagFormat = @"<GetOrder %@>";
static NSString *const kSTIPoCSelfServiceGetOrderTag = @"</GetOrder>";

static NSString *const kSTIPoCSelfServiceGetOrderResultOpenTag = @"<GetOrderResult>";
static NSString *const kSTIPoCSelfServiceGetOrderResultCloseTag = @"</GetOrderResult>";

@implementation GetOrderXMLParser

+ (NSString *)xmlStringFromGetOrderRequest:(getOrderRequest *)getOrderRequest
{
    NSString *getOrderActionOpenTag = [NSString stringWithFormat:kSTIPoCSelfServiceGetOrderTagFormat, kSTIPoCSOAPActionAttributes];
    NSString *getOrderRequestTag = [getOrderRequest XMLString];
    NSString *getOrderActionCloseTag = kSTIPoCSelfServiceGetOrderTag;
    
    NSString *xmlString = [NSString stringWithFormat:kSTIPoCSOAPActionFormat, getOrderActionOpenTag, getOrderRequestTag, getOrderActionCloseTag];
    
    return xmlString;
}

+ (GetOrderResult *)getOrderResultFromXMLString:(NSString *)xmlString
{
    NSString *getOrderResultXMLString = [self elementStringFromXMLString:xmlString
                                                             withOpenTag:kSTIPoCSelfServiceGetOrderResultOpenTag
                                                             andCloseTag:kSTIPoCSelfServiceGetOrderResultCloseTag];
    
    NSData *xmlData = [getOrderResultXMLString dataUsingEncoding:NSUTF8StringEncoding];
    GetOrderResult *getOrderResult = [[GetOrderResult alloc] initWithXMLData:xmlData];
    
    return getOrderResult;
}

@end
