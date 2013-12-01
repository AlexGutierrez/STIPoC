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

NSString *const kSTIPoCSelfServicePriceTypeNRC = @"NRC";
NSString *const kSTIPoCSelfServicePriceTypeMRC = @"MRC";

NSString *const kSTIPoCSelfServiceResponseCodeSuccess = @"0";
NSString *const kSTIPoCSelfServiceResponseCodeError = @"1";

NSString *const kSTIPoCSelfServiceOrderStatusApproved = @"Approved";
NSString *const kSTIPoCSelfServiceOrderStatusRejected = @"Rejected";
NSString *const kSTIPoCSelfServiceOrderStatusSubmitted = @"Submitted";
NSString *const kSTIPoCSelfServiceOrderStatusAssigned = @"Assigned";
NSString *const kSTIPoCSelfServiceOrderStatusInProgress = @"In Progress";
NSString *const kSTIPoCSelfServiceOrderStatusPartiallyCompleted = @"Partially Completed";
NSString *const kSTIPoCSelfServiceOrderStatusCompleted = @"Completed";
NSString *const kSTIPoCSelfServiceOrderStatusUnderReview = @"Under Review";
NSString *const kSTIPoCSelfServiceOrderStatusEditedByTerremark = @"Edited by Terremark";
NSString *const kSTIPoCSelfServiceOrderStatusPendingApproval = @"Pending Approval";
NSString *const kSTIPoCSelfServiceOrderStatusEditedByCustomer = @"Edited by Customer";

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

#pragma mark -
#pragma mark Price Type

+ (NSString *)stringFromPriceType:(PriceType)priceType
{
    switch (priceType) {
        case PriceTypeNRC:
            return kSTIPoCSelfServicePriceTypeNRC;
            break;
        case SourceSystemCAP:
            return kSTIPoCSelfServicePriceTypeMRC;
            break;
        default:
            break;
    }
}

+ (PriceType)priceTypeFromString:(NSString *)priceTypeString
{
    if ([priceTypeString isEqualToString:kSTIPoCSelfServicePriceTypeNRC]) {
        return PriceTypeNRC;
    }
    else {
        return PriceTypeMRC;
    }
}

#pragma mark -
#pragma mark Order Status

+ (NSString *)stringFromOrderStatus:(OrderStatus)orderStatus
{
    switch (orderStatus) {
        case OrderStatusApproved:
            return kSTIPoCSelfServiceOrderStatusApproved;
            break;
        case OrderStatusSubmitted:
            return kSTIPoCSelfServiceOrderStatusSubmitted;
            break;
        case OrderStatusRejected:
            return kSTIPoCSelfServiceOrderStatusRejected;
            break;
        case OrderStatusAssigned:
            return kSTIPoCSelfServiceOrderStatusAssigned;
            break;
        case OrderStatusInProgress:
            return kSTIPoCSelfServiceOrderStatusInProgress;
            break;
        case OrderStatusCompleted:
            return kSTIPoCSelfServiceOrderStatusCompleted;
            break;
        case OrderStatusEditedByCustomer:
            return kSTIPoCSelfServiceOrderStatusEditedByCustomer;
            break;
        case OrderStatusEditedByTerremark:
            return kSTIPoCSelfServiceOrderStatusEditedByTerremark;
            break;
        case OrderStatusPartiallyCompleted:
            return kSTIPoCSelfServiceOrderStatusPartiallyCompleted;
            break;
        case OrderStatusPendingApproval:
            return kSTIPoCSelfServiceOrderStatusPendingApproval;
            break;
        case OrderStatusUnderReview:
            return kSTIPoCSelfServiceOrderStatusUnderReview;
            break;
        default:
            break;
    }
}

+ (OrderStatus)orderStatusFromString:(NSString *)orderStatusString
{
    if ([orderStatusString isEqualToString:kSTIPoCSelfServiceOrderStatusSubmitted]) {
        return OrderStatusSubmitted;
    }
    else if ([orderStatusString isEqualToString:kSTIPoCSelfServiceOrderStatusUnderReview]) {
        return OrderStatusUnderReview;
    }
    else if ([orderStatusString isEqualToString:kSTIPoCSelfServiceOrderStatusPendingApproval]) {
        return OrderStatusPendingApproval;
    }
    else if ([orderStatusString isEqualToString:kSTIPoCSelfServiceOrderStatusPartiallyCompleted]) {
        return OrderStatusPartiallyCompleted;
    }
    else if ([orderStatusString isEqualToString:kSTIPoCSelfServiceOrderStatusInProgress]) {
        return OrderStatusInProgress;
    }
    else if ([orderStatusString isEqualToString:kSTIPoCSelfServiceOrderStatusEditedByTerremark]) {
        return OrderStatusEditedByTerremark;
    }
    else if ([orderStatusString isEqualToString:kSTIPoCSelfServiceOrderStatusEditedByCustomer]) {
        return OrderStatusEditedByCustomer;
    }
    else if ([orderStatusString isEqualToString:kSTIPoCSelfServiceOrderStatusCompleted]) {
        return OrderStatusCompleted;
    }
    else if ([orderStatusString isEqualToString:kSTIPoCSelfServiceOrderStatusAssigned]) {
        return OrderStatusAssigned;
    }
    else if ([orderStatusString isEqualToString:kSTIPoCSelfServiceOrderStatusApproved]) {
        return OrderStatusApproved;
    }
    else {
        return OrderStatusRejected;
    }
}

@end
