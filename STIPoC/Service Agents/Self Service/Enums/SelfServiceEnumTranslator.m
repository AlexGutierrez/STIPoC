//
//  SelfServiceEnumTranslator.m
//  STIPoC
//
//  Created by Administrator on 11/25/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "SelfServiceEnumTranslator.h"

NSString *const kSTIPoCSelfServiceOrderIdTypeOrderId = @"OrderId";
NSString *const kSTIPoCSelfServiceOrderIdTypeProjectId = @"ProjectId";
NSString *const kSTIPoCSelfServiceOrderIdTypeFriendlyOrderId = @"FriendlyOrderId";

NSString *const kSTIPoCSelfServiceOrderingTypeAsc = @"Asc";
NSString *const kSTIPoCSelfServiceOrderingTypeDesc = @"Desc";

NSString *const kSTIPoCSelfServiceCustomerIdTypeAccountNumber = @"AccountNumber";
NSString *const kSTIPoCSelfServiceCustomerIdTypeBillingId = @"BillingId";
NSString *const kSTIPoCSelfServiceCustomerIdTypeInstanceId = @"InstanceId";
NSString *const kSTIPoCSelfServiceCustomerIdTypeNSAP = @"NSAP";

NSString *const kSTIPoCSelfServiceSourceSystemEcommerce = @"0";
NSString *const kSTIPoCSelfServiceSourceSystemCAP = @"1";

NSString *const kSTIPoCSelfServiceResponseCodeSuccess = @"0";
NSString *const kSTIPoCSelfServiceResponseCodeError = @"1";

@implementation SelfServiceEnumTranslator

#pragma mark -
#pragma mark Order Id Type

+ (NSString *)stringFromOrderIdType:(OrderIdType)orderIdType
{
    switch (orderIdType) {
        case OrderIdTypeOrderId:
            return kSTIPoCSelfServiceOrderIdTypeOrderId;
            break;
        case OrderIdTypeProjectId:
            return kSTIPoCSelfServiceOrderIdTypeProjectId;
            break;
        case OrderIdTypeFriendlyOrderId:
            return kSTIPoCSelfServiceOrderIdTypeFriendlyOrderId;
            break;
        default:
            break;
    }
}

+ (OrderIdType)orderIdTypeFromString:(NSString *)orderIdTypeString
{
    if ([orderIdTypeString isEqualToString:kSTIPoCSelfServiceOrderIdTypeOrderId]) {
        return OrderIdTypeOrderId;
    }
    else if ([orderIdTypeString isEqualToString:kSTIPoCSelfServiceOrderIdTypeProjectId]) {
        return OrderIdTypeProjectId;
    }
    else {
        return OrderIdTypeFriendlyOrderId;
    }
}

#pragma mark -
#pragma mark Ordering Type

+ (NSString *)stringFromOrderingType:(OrderingType)orderingType
{
    switch (orderingType) {
        case OrderingTypeAsc:
            return kSTIPoCSelfServiceOrderingTypeAsc;
            break;
        case OrderingTypeDesc:
            return kSTIPoCSelfServiceOrderingTypeDesc;
            break;
        default:
            break;
    }
}

+ (OrderingType)orderingTypeFromString:(NSString *)orderingTypeString
{
    if ([orderingTypeString isEqualToString:kSTIPoCSelfServiceOrderingTypeAsc]) {
        return OrderingTypeAsc;
    }
    else {
        return OrderingTypeDesc;
    }
}

#pragma mark -
#pragma mark Customer Id Type

+ (NSString *)stringFromCustomerIdType:(CustomerIdType)customerIdType
{
    switch (customerIdType) {
        case CustomerIdTypeAccountNumber:
            return kSTIPoCSelfServiceCustomerIdTypeAccountNumber;
            break;
        case CustomerIdTypeBillingID:
            return kSTIPoCSelfServiceCustomerIdTypeBillingId;
            break;
        case CustomerIdTypeInstanceId:
            return kSTIPoCSelfServiceCustomerIdTypeInstanceId;
            break;
        case CustomerIdTypeNSAP:
            return kSTIPoCSelfServiceCustomerIdTypeNSAP;
            break;
        default:
            break;
    }
}

+ (CustomerIdType)customerIdTypeFromString:(NSString *)customerIdString
{
    if ([customerIdString isEqualToString:kSTIPoCSelfServiceCustomerIdTypeAccountNumber]) {
        return CustomerIdTypeAccountNumber;
    }
    else if ([customerIdString isEqualToString:kSTIPoCSelfServiceCustomerIdTypeBillingId]) {
        return CustomerIdTypeBillingID;
    }
    else if ([customerIdString isEqualToString:kSTIPoCSelfServiceCustomerIdTypeInstanceId]) {
        return CustomerIdTypeInstanceId;
    }
    else {
        return CustomerIdTypeNSAP;
    }
}

#pragma mark -
#pragma mark Response Code

+ (NSString *)stringFromResponseCode:(ResponseCode)responseCode
{
    switch (responseCode) {
        case ResponseCodeSuccess:
            return kSTIPoCSelfServiceResponseCodeSuccess;
            break;
        case ResponseCodeError:
            return kSTIPoCSelfServiceResponseCodeError;
            break;
        default:
            break;
    }
}

+ (ResponseCode)responseCodeFromString:(NSString *)responseCodeString
{
    if ([responseCodeString isEqualToString:kSTIPoCSelfServiceResponseCodeSuccess]) {
        return ResponseCodeSuccess;
    }
    else {
        return ResponseCodeError;
    }
}

#pragma mark -
#pragma mark Source System

+ (NSString *)stringFromSourceSystem:(SourceSystem)sourceSystem
{
    switch (sourceSystem) {
        case SourceSystemEcommerce:
            return kSTIPoCSelfServiceSourceSystemEcommerce;
            break;
        case SourceSystemCAP:
            return kSTIPoCSelfServiceSourceSystemCAP;
            break;
        default:
            break;
    }
}

+ (SourceSystem)sourceSystemFromString:(NSString *)sourceSystemString
{
    if ([sourceSystemString isEqualToString:kSTIPoCSelfServiceSourceSystemEcommerce]) {
        return SourceSystemEcommerce;
    }
    else {
        return SourceSystemCAP;
    }
}

@end
