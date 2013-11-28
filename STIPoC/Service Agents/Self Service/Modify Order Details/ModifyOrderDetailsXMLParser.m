//
//  ModifyOrderDetailsXMLParser.m
//  STIPoC
//
//  Created by Administrator on 11/25/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "ModifyOrderDetailsXMLParser.h"
#import "ModifyOrderDetailsRequest.h"
#import "ModifyOrderDetailsResult.h"

static NSString *const kSTIPoCSelfServiceModifyOrderDetailsOpenTagFormat = @"<ModifyOrderDetails %@>";
static NSString *const kSTIPoCSelfServiceModifyOrderDetailsCloseTag = @"</ModifyOrderDetails>";

static NSString *const kSTIPoCSelfServiceModifyOrderDetailsResultOpenTag = @"<ModifyOrderDetailsResult>";
static NSString *const kSTIPoCSelfServiceModifyOrderDetailsResultCloseTag = @"</ModifyOrderDetailsResult>";

@implementation ModifyOrderDetailsXMLParser

+ (NSString *)xmlStringFromModifyOrderDetailsRequest:(modifyOrderDetailsRequest *)modifyOrderDetailsRequest
{
    NSString *modifyOrderDetailsActionOpenTag = [NSString stringWithFormat:kSTIPoCSelfServiceModifyOrderDetailsOpenTagFormat, kSTIPoCSOAPActionAttributes];
    NSString *modifyOrderDetailsRequestTag = [modifyOrderDetailsRequest XMLString];
    NSString *modifyOrderDetailsActionCloseTag = kSTIPoCSelfServiceModifyOrderDetailsCloseTag;
    
    NSString *xmlString = [NSString stringWithFormat:kSTIPoCSOAPActionFormat, modifyOrderDetailsActionOpenTag, modifyOrderDetailsRequestTag, modifyOrderDetailsActionCloseTag];
    
    return xmlString;
}

+ (ModifyOrderDetailsResult *)modifyOrderDetailsResultFromXMLString:(NSString *)xmlString
{
    NSString *modifyOrderDetailsResultXMLString = [self elementStringFromXMLString:xmlString
                                                              withOpenTag:kSTIPoCSelfServiceModifyOrderDetailsResultOpenTag
                                                              andCloseTag:kSTIPoCSelfServiceModifyOrderDetailsResultCloseTag];
    
    NSData *xmlData = [modifyOrderDetailsResultXMLString dataUsingEncoding:NSUTF8StringEncoding];
    ModifyOrderDetailsResult *modifyOrderDetailsResult = [[ModifyOrderDetailsResult alloc] initWithXMLData:xmlData];
    
    return modifyOrderDetailsResult;
}

@end
