//
//  UpdateOrderStatusXMLParser.m
//  STIPoC
//
//  Created by Alex Gutierrez on 11/29/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "UpdateOrderStatusXMLParser.h"
#import "UpdateOrderStatusRequest.h"
#import "UpdateOrderStatusResult.h"

static NSString *const kSTIPoCSelfServiceUpdateOrderStatusTagFormat = @"<UpdateOrderStatus %@>";
static NSString *const kSTIPoCSelfServiceUpdateOrderStatusTag = @"</UpdateOrderStatus>";

static NSString *const kSTIPoCSelfServiceUpdateOrderStatusResultOpenTag = @"<UpdateOrderStatusResult>";
static NSString *const kSTIPoCSelfServiceUpdateOrderStatusResultCloseTag = @"</UpdateOrderStatusResult>";

@implementation UpdateOrderStatusXMLParser

+ (NSString *)xmlStringFromUpdateOrderStatusRequest:(quoteOrderRequest *)quoteOrderRequest
{
    NSString *updateOrderStatusActionOpenTag = [NSString stringWithFormat:kSTIPoCSelfServiceUpdateOrderStatusTagFormat, kSTIPoCSOAPActionAttributes];
    NSString *updateOrderStatusRequestTag = [quoteOrderRequest XMLString];
    NSString *updateOrderStatusActionCloseTag = kSTIPoCSelfServiceUpdateOrderStatusTag;
    
    NSString *xmlString = [NSString stringWithFormat:kSTIPoCSOAPActionFormat, updateOrderStatusActionOpenTag, updateOrderStatusRequestTag, updateOrderStatusActionCloseTag];
    
    return xmlString;
}

+ (UpdateOrderStatusResult *)updateOrderStatusResultFromXMLString:(NSString *)xmlString
{
    NSString *updateOrderStatusResultXMLString = [self elementStringFromXMLString:xmlString
                                                                      withOpenTag:kSTIPoCSelfServiceUpdateOrderStatusResultOpenTag
                                                                      andCloseTag:kSTIPoCSelfServiceUpdateOrderStatusResultCloseTag];
    
    NSData *xmlData = [updateOrderStatusResultXMLString dataUsingEncoding:NSUTF8StringEncoding];
    UpdateOrderStatusResult *updateOrderStatusResult = [[UpdateOrderStatusResult alloc] initWithXMLData:xmlData];
    
    return updateOrderStatusResult;
}

@end