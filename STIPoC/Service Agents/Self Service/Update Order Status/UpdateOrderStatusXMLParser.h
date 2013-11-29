//
//  UpdateOrderStatusXMLParser.h
//  STIPoC
//
//  Created by Alex Gutierrez on 11/29/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "GenericXMLParser.h"

@class UpdateOrderStatusResult;
@class quoteOrderRequest;

@interface UpdateOrderStatusXMLParser : GenericXMLParser

+ (NSString *)xmlStringFromUpdateOrderStatusRequest:(quoteOrderRequest *)quoteOrderRequest;
+ (UpdateOrderStatusResult *)updateOrderStatusResultFromXMLString:(NSString *)xmlString;

@end
