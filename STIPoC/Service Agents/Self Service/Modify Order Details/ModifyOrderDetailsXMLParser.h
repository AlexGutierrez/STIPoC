//
//  ModifyOrderDetailsXMLParser.h
//  STIPoC
//
//  Created by Administrator on 11/25/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "GenericXMLParser.h"

@class modifyOrderDetailsRequest;
@class ModifyOrderDetailsResult;

@interface ModifyOrderDetailsXMLParser : GenericXMLParser

+ (NSString *)xmlStringFromModifyOrderDetailsRequest:(modifyOrderDetailsRequest *)modifyOrderDetailsRequest;
+ (ModifyOrderDetailsResult *)modifyOrderDetailsResultFromXMLString:(NSString *)xmlString;

@end
