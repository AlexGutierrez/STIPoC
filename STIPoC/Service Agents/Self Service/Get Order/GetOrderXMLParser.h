//
//  GetOrderXMLParser.h
//  STIPoC
//
//  Created by Administrator on 11/25/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GenericXMLParser.h"

@class getOrderRequest;
@class GetOrderResult;

@interface GetOrderXMLParser : GenericXMLParser

+ (NSString *)xmlStringFromGetOrderRequest:(getOrderRequest *)getOrderRequest;
+ (GetOrderResult *)getOrderResultFromXMLString:(NSString *)xmlString;

@end
