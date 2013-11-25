//
//  GetOrdersXMLParser.h
//  STIPoC
//
//  Created by Administrator on 11/22/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GenericXMLParser.h"

@class getOrdersRequest;
@class GetOrdersResult;

@interface GetOrdersXMLParser : GenericXMLParser

+ (NSString *)xmlStringFromGetOrdersRequest:(getOrdersRequest *)getOrdersRequest;
+ (GetOrdersResult *)getOrdersResultFromXMLString:(NSString *)xmlString;

@end
