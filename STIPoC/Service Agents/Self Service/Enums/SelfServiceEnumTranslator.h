//
//  SelfServiceEnumTranslator.h
//  STIPoC
//
//  Created by Administrator on 11/25/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderIdType.h"
#import "OrderingType.h"
#import "CustomerIdType.h"
#import "ResponseCode.h"
#import "SourceSystem.h"

@interface SelfServiceEnumTranslator : NSObject

+ (NSString *)stringFromOrderIdType:(OrderIdType)orderIdType;
+ (OrderIdType)orderIdTypeFromString:(NSString *)orderIdTypeString;

+ (NSString *)stringFromOrderingType:(OrderingType)orderingType;
+ (OrderingType)orderingTypeFromString:(NSString *)orderingTypeString;

+ (NSString *)stringFromCustomerIdType:(CustomerIdType)customerIdType;
+ (CustomerIdType)customerIdTypeFromString:(NSString *)customerIdString;

+ (NSString *)stringFromResponseCode:(ResponseCode)responseCode;
+ (ResponseCode)responseCodeFromString:(NSString *)responseCodeString;

+ (NSString *)stringFromSourceSystem:(SourceSystem)sourceSystem;
+ (SourceSystem)sourceSystemFromString:(NSString *)sourceSystemString;

@end
