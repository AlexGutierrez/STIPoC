//
//  GetOrdersManager.m
//  STIPoC
//
//  Created by Administrator on 11/22/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "SelfServiceRequestOperationManager.h"

#import "ErrorFactory.h"

#import "GetOrdersXMLParser.h"
#import "GetOrdersRequest.h"
#import "GetOrdersResult.h"

#import "GetOrderXMLParser.h"
#import "GetOrderRequest.h"
#import "GetOrderResult.h"

#import "UpdateOrderStatusXMLParser.h"
#import "UpdateOrderStatusRequest.h"
#import "UpdateOrderStatusResult.h"

#import "ModifyOrderDetailsRequest.h"
#import "ModifyOrderDetailsResult.h"
#import "ModifyOrderDetailsXMLParser.h"

#import "OrderSummary.h"

static NSString *const kSTIPoCSelfServiceEndpointURLBaseString = @"https://services-qa.oss.terremark.com/SelfService/SelfService.asmx";
static NSString *const kSTIPoCSelfServiceHTTPPOSTMethod = @"Post";
static NSString *const kSTIPoCSelfServiceContentTypeHeader = @"Content-Type";
static NSString *const kSTIPoCSelfServiceSOAPActionHeader = @"SOAPAction";
static NSString *const kSTIPoCSelfServiceContentType = @"text/xml; charset=utf-8";
static NSString *const kSTIPoCSelfServiceSOAPActionBaseURL = @"http://tempuri.org/";

static NSString *const kSTIPoCSelfServiceGetOrdersActionName = @"GetOrders";
static NSString *const kSTIPoCSelfServiceGetOrderActionName = @"GetOrder";
static NSString *const kSTIPoCSelfServiceUpdateOrderStatusActionName = @"UpdateOrderStatus";
static NSString *const kSTIPoCSelfServiceModifyOrderDetailsActionName = @"ModifyOrderDetails";

static NSString *const kSTIPoCSelfServiceLegoCustomerInstanceId = @"12284";

static NSString *const kSTIPoCSelfServiceErrorGetOrdersDomain = @"GetOrders";
static NSString *const kSTIPoCSelfServiceErrorGetOrderDomain = @"GetOrder";
static NSString *const kSTIPoCSelfServiceErrorModifyOrderDetailsDomain = @"ModifyOrderDetails";
static NSString *const kSTIPoCSelfServiceErrorUpdateOrderStatusDomain = @"UpdateOrderStatus";

@interface SelfServiceRequestOperationManager ()

- (NSMutableURLRequest *)newSelfServiceURLRequestWithActionName:(NSString *)actionName;

@end

@implementation SelfServiceRequestOperationManager

#pragma mark -
#pragma mark Class Methods

+ (instancetype)sharedManager
{
    static SelfServiceRequestOperationManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [SelfServiceRequestOperationManager new];
        _sharedManager.responseSerializer =  [AFXMLParserResponseSerializer serializer];
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        securityPolicy.SSLPinningMode = AFSSLPinningModeNone;
        _sharedManager.securityPolicy = securityPolicy;
    });
    return _sharedManager;
}

#pragma mark -
#pragma Custom Accessors

- (NSMutableURLRequest *)newSelfServiceURLRequestWithActionName:(NSString *)actionName
{
    NSString *endpointURLString = [NSString stringWithFormat:@"%@?op=%@", kSTIPoCSelfServiceEndpointURLBaseString, actionName];
    NSURL *endpointURL = [NSURL URLWithString:endpointURLString];
    
    NSMutableURLRequest *newSelfServiceURLRequest = [[NSMutableURLRequest alloc] initWithURL:endpointURL];
    newSelfServiceURLRequest.HTTPMethod = kSTIPoCSelfServiceHTTPPOSTMethod;
    [newSelfServiceURLRequest addValue:kSTIPoCSelfServiceContentType forHTTPHeaderField:kSTIPoCSelfServiceContentTypeHeader];
    [newSelfServiceURLRequest addValue:[NSString stringWithFormat:@"%@%@", kSTIPoCSelfServiceSOAPActionBaseURL, actionName] forHTTPHeaderField:kSTIPoCSelfServiceSOAPActionHeader];
    return newSelfServiceURLRequest;
}

#pragma mark -
#pragma Self Service Operations

- (void)startGetOrdersRequestOperationWithCompletionBlock:(void(^)(NSArray *orders))completion
                                          andFailureBlock:(void(^)(NSError *internalError))failure
{
    getOrdersRequest *request = [getOrdersRequest newRequestWithCustomerId:kSTIPoCSelfServiceLegoCustomerInstanceId customerIdType:CustomerIdTypeInstanceId pageSize:30 pageNumber:1];
    
    NSString * getOrdersBodyXMLString = [GetOrdersXMLParser xmlStringFromGetOrdersRequest:request];
    
    NSMutableURLRequest *getOrdersURLRequest = [self newSelfServiceURLRequestWithActionName:kSTIPoCSelfServiceGetOrdersActionName];
    getOrdersURLRequest.HTTPBody = [getOrdersBodyXMLString dataUsingEncoding:NSUTF8StringEncoding];
                        
    AFHTTPRequestOperation *getOrdersHTTPRequestOperation = [self HTTPRequestOperationWithRequest:getOrdersURLRequest success:^(AFHTTPRequestOperation *operation, id responseObject) {
        GetOrdersResult *result = [GetOrdersXMLParser getOrdersResultFromXMLString:[[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding]];
        if ([result.ResponseCode isEqualToString:kSTIPoCSelfServiceResponseCodeError]) {
            DDLogWarn(@"Get Orders Succeeded with Error\n Response Code:%@\nResponse Message:%@", result.ResponseCode, result.ResponseMessage);
            NSError *error = [[ErrorFactory sharedFactory] createErrorWithSelfServiceDomain:kSTIPoCSelfServiceErrorGetOrdersDomain andSelfServiceResult:result];
            failure(error);
            return;
        }
        
        DDLogInfo(@"Get Orders SUCCEEDED");
        completion(result.Orders);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DDLogError(@"Get Orders FAILED:\n%@", error);
        failure(error);
    }];
    
    
    [getOrdersHTTPRequestOperation start];
}

- (void)startGetOrderRequestOperationWithOrderSummary:(OrderSummary *)orderSummary
                                      completionBlock:(void(^)(OrderSummary *detailedOrderSummary))completion
                                      andFailureBlock:(void(^)(NSError *internalError))failure
{
    getOrderRequest *request = [getOrderRequest newRequestWithOrderId:orderSummary.OrderId andOrderIdType:OrderIdTypeOrderId];
    
    NSString * getOrderBodyXMLString = [GetOrderXMLParser xmlStringFromGetOrderRequest:request];
    
    NSMutableURLRequest *getOrderURLRequest = [self newSelfServiceURLRequestWithActionName:kSTIPoCSelfServiceGetOrderActionName];
    getOrderURLRequest.HTTPBody = [getOrderBodyXMLString dataUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperation *getOrdersHTTPRequestOperation = [self HTTPRequestOperationWithRequest:getOrderURLRequest success:^(AFHTTPRequestOperation *operation, id responseObject) {
        GetOrderResult *result = [GetOrderXMLParser getOrderResultFromXMLString:[[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding]];
        if ([result.ResponseCode isEqualToString:kSTIPoCSelfServiceResponseCodeError]) {
            DDLogWarn(@"Get Order Succeeded with Error\n Response Code:%@\nResponse Message:%@", result.ResponseCode, result.ResponseMessage);
            NSError *error = [[ErrorFactory sharedFactory] createErrorWithSelfServiceDomain:kSTIPoCSelfServiceErrorGetOrderDomain andSelfServiceResult:result];
            failure(error);
            return;
        }

        [orderSummary setAttributesWithGetOrderResult:result];
        
        DDLogInfo(@"Get Order SUCCEEDED");
        completion(orderSummary);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DDLogError(@"Get Order FAILED:\n%@", error);
        failure(error);
    }];
    
    
    [getOrdersHTTPRequestOperation start];
}

- (void)startUpdateOrderStatusRequestOperationWithOrderSummary:(OrderSummary *)orderSummary
                                                newOrderStatus:(OrderStatus)orderStatus
                                                      comments:(NSString *)comments
                                               completionBlock:(void(^)())completion
                                               andFailureBlock:(void(^)(NSError *internalError))failure
{
    quoteOrderRequest *request = [quoteOrderRequest newRequestWithOrderSummary:orderSummary newOrderStatus:orderStatus comments:comments];
    
    NSString * updateOrderStatusBodyXMLString = [UpdateOrderStatusXMLParser xmlStringFromUpdateOrderStatusRequest:request];
    
    NSMutableURLRequest *updateOrderStatusURLRequest = [self newSelfServiceURLRequestWithActionName:kSTIPoCSelfServiceUpdateOrderStatusActionName];
    updateOrderStatusURLRequest.HTTPBody = [updateOrderStatusBodyXMLString dataUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperation *updateOrderStatusHTTPRequestOperation = [self HTTPRequestOperationWithRequest:updateOrderStatusURLRequest success:^(AFHTTPRequestOperation *operation, id responseObject) {
        UpdateOrderStatusResult *result = [UpdateOrderStatusXMLParser updateOrderStatusResultFromXMLString:[[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding]];
        if ([result.ResponseCode isEqualToString:kSTIPoCSelfServiceResponseCodeError]) {
            DDLogWarn(@"Update Order Status Succeeded with Error\n Response Code:%@\nResponse Message:%@", result.ResponseCode, result.ResponseMessage);
            NSError *error = [[ErrorFactory sharedFactory] createErrorWithSelfServiceDomain:kSTIPoCSelfServiceErrorUpdateOrderStatusDomain andSelfServiceResult:result];
            failure(error);
            return;
        }
        
        DDLogInfo(@"Update Order Status SUCCEEDED");
        completion();
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DDLogError(@"Update Order Status FAILED:\n%@", error);
        failure(error);
    }];
    
    
    [updateOrderStatusHTTPRequestOperation start];
}

- (void)startModifyOrderDetailsRequestOperationWithOrder:(OrderSummary *)orderSummary
                                         completionBlock:(void(^)())completion
                                         andFailureBlock:(void(^)(NSError *internalError))failure
{
    modifyOrderDetailsRequest *request = [modifyOrderDetailsRequest newRequestWithOrderSummary:orderSummary];
    
    NSString * modifyOrderDetailsBodyXMLString = [ModifyOrderDetailsXMLParser xmlStringFromModifyOrderDetailsRequest:request];
    
    NSMutableURLRequest *modifyOrderDetailsURLRequest = [self newSelfServiceURLRequestWithActionName:kSTIPoCSelfServiceModifyOrderDetailsActionName];
    modifyOrderDetailsURLRequest.HTTPBody = [modifyOrderDetailsBodyXMLString dataUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperation *modifyOrderDetailsHTTPRequestOperation = [self HTTPRequestOperationWithRequest:modifyOrderDetailsURLRequest success:^(AFHTTPRequestOperation *operation, id responseObject) {
        ModifyOrderDetailsResult *result = [ModifyOrderDetailsXMLParser modifyOrderDetailsResultFromXMLString:[[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding]];
        if ([result.ResponseCode isEqualToString:kSTIPoCSelfServiceResponseCodeError]) {
            DDLogWarn(@"Modify Order Details Succeeded with Error\n Response Code:%@\nResponse Message:%@", result.ResponseCode, result.ResponseMessage);
            NSError *error = [[ErrorFactory sharedFactory] createErrorWithSelfServiceDomain:kSTIPoCSelfServiceErrorModifyOrderDetailsDomain andSelfServiceResult:result];
            failure(error);
            return;
        }
        
        DDLogInfo(@"Modify Order Details SUCCEEDED");
        completion();
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DDLogError(@"Modify Order Details FAILED:\n%@", error);
        failure(error);
    }];
    
    
    [modifyOrderDetailsHTTPRequestOperation start];
}

@end
