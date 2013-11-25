//
//  GetOrdersXMLParser.m
//  STIPoC
//
//  Created by Administrator on 11/22/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "GetOrdersXMLParser.h"
#import "getOrdersRequest.h"
#import "GetOrdersResult.h"

@implementation GetOrdersXMLParser

+ (NSString *)xmlStringFromGetOrdersRequest:(getOrdersRequest *)getOrdersRequest
{
    NSString *getOrdersActionOpenTag = [NSString stringWithFormat:kSTIPoCSelfServiceGetOrdersOpenTagFormat, kSTIPoCSOAPActionAttributes];
    NSString *getOrdersRequestTag = [getOrdersRequest XMLString];
    NSString *getOrdersActionCloseTag = kSTIPoCSelfServiceGetOrdersCloseTag;
    
    NSString *xmlString = [NSString stringWithFormat:kSTIPoCSOAPActionFormat, getOrdersActionOpenTag, getOrdersRequestTag, getOrdersActionCloseTag];
    
    return xmlString;
}


+ (GetOrdersResult *)getOrdersResultFromXMLString:(NSString *)xmlString
{
    NSString *getOrdersResultXMLString = [self elementStringFromXMLString:xmlString
                                                              withOpenTag:kSTIPoCSelfServiceGetOrdersResultOpenTag
                                                              andCloseTag:kSTIPoCSelfServiceGetOrdersResultCloseTag];
    
    NSData *xmlData = [getOrdersResultXMLString dataUsingEncoding:NSUTF8StringEncoding];
    GetOrdersResult *getOrdersResult = [[GetOrdersResult alloc] initWithXMLData:xmlData];
    
    return getOrdersResult;
}

@end
