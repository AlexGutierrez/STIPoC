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

extern NSString *const kSTIPoCSelfServiceOrderIdTypeOrderId;
extern NSString *const kSTIPoCSelfServiceOrderIdTypeProjectId;
extern NSString *const kSTIPoCSelfServiceOrderIdTypeFriendlyOrderId;

extern NSString *const kSTIPoCSelfServiceOrderingTypeAsc;
extern NSString *const kSTIPoCSelfServiceOrderingTypeDesc;

extern NSString *const kSTIPoCSelfServiceCustomerIdTypeAccountNumber;
extern NSString *const kSTIPoCSelfServiceCustomerIdTypeBillingId;
extern NSString *const kSTIPoCSelfServiceCustomerIdTypeInstanceId;
extern NSString *const kSTIPoCSelfServiceCustomerIdTypeNSAP;

extern NSString *const kSTIPoCSelfServiceSourceSystemEcommerce;
extern NSString *const kSTIPoCSelfServiceSourceSystemCAP;

extern NSString *const kSTIPoCSelfServiceResponseCodeSuccess;
extern NSString *const kSTIPoCSelfServiceResponseCodeError;

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
