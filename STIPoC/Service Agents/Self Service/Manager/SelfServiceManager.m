//
//  GetOrdersManager.m
//  STIPoC
//
//  Created by Administrator on 11/22/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "SelfServiceManager.h"
#import "GetOrdersXMLParser.h"
#import "GetOrdersRequest.h"
#import "GetOrdersResult.h"

#import "OrderSummary.h"
#import "GetOrderXMLParser.h"
#import "GetOrderRequest.h"
#import "GetOrderResult.h"

#import "ModifyOrderDetailsRequest.h"
#import "ModifyOrderDetailsXMLParser.h"

static NSString *const kSTIPoCSelfServiceEndpointURLBaseString = @"https://services-qa.oss.terremark.com/SelfService/SelfService.asmx";
static NSString *const kSTIPoCSelfServiceHTTPPOSTMethod = @"Post";
static NSString *const kSTIPoCSelfServiceContentTypeHeader = @"Content-Type";
static NSString *const kSTIPoCSelfServiceSOAPActionHeader = @"SOAPAction";
static NSString *const kSTIPoCSelfServiceContentType = @"text/xml; charset=utf-8";
static NSString *const kSTIPoCSelfServiceSOAPActionBaseURL = @"http://tempuri.org/";

static NSString *const kSTIPoCSelfServiceGetOrdersActionName = @"GetOrders";
static NSString *const kSTIPoCSelfServiceGetOrderActionName = @"GetOrder";
static NSString *const kSTIPoCSelfServiceModifyOrderDetailsActionName = @"ModifyOrderDetails";

static NSString *const kSTIPoCSelfServiceLegoCustomerInstanceId = @"12284";

static NSString *const kSTIPoCSelfServiceErrorGetOrdersDomain = @"GetOrders";
static NSString *const kSTIPoCSelfServiceErrorGetOrderDomain = @"GetOrder";
static NSString *const kSTIPoCSelfServiceErrorModifyOrderDetailDomain = @"ModifyOrderDetails";
static NSString *const kSTIPoCSelfServiceErrorUpdateOrderStatusDomain = @"UpdateOrderStatus";

@interface SelfServiceManager ()

- (NSMutableURLRequest *)newSelfServiceURLRequestWithActionName:(NSString *)actionName;

@end

@implementation SelfServiceManager

#pragma mark -
#pragma mark Class Methods

+ (instancetype)sharedInstance
{
    static SelfServiceManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [SelfServiceManager new];
        _sharedInstance.responseSerializer =  [AFXMLParserResponseSerializer serializer];
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        securityPolicy.SSLPinningMode = AFSSLPinningModeNone;
        _sharedInstance.securityPolicy = securityPolicy;
    });
    return _sharedInstance;
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
                                          andFailureBlock:(void(^)(NSError *error))failure
{
    getOrdersRequest *request = [getOrdersRequest newRequestWithCustomerId:kSTIPoCSelfServiceLegoCustomerInstanceId customerIdType:CustomerIdTypeInstanceId pageSize:10 pageNumber:1];
    
    NSString * getOrdersBodyXMLString = [GetOrdersXMLParser xmlStringFromGetOrdersRequest:request];
    
    NSMutableURLRequest *getOrdersURLRequest = [self newSelfServiceURLRequestWithActionName:kSTIPoCSelfServiceGetOrdersActionName];
    getOrdersURLRequest.HTTPBody = [getOrdersBodyXMLString dataUsingEncoding:NSUTF8StringEncoding];
                        
    AFHTTPRequestOperation *getOrdersHTTPRequestOperation = [self HTTPRequestOperationWithRequest:getOrdersURLRequest success:^(AFHTTPRequestOperation *operation, id responseObject) {
        GetOrdersResult *result = [GetOrdersXMLParser getOrdersResultFromXMLString:[[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding]];
        if ([result.ResponseCode isEqualToString:kSTIPoCSelfServiceResponseCodeError]) {
            DDLogWarn(@"Get Orders Succeeded with Error\n Response Code:%@\nResponse Message:%@", result.ResponseCode, result.ResponseMessage);
            NSError *error = [NSError errorWithDomain:kSTIPoCSelfServiceErrorGetOrdersDomain code:[result.ResponseCode integerValue] userInfo:nil];
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
                                      andFailureBlock:(void(^)(NSError *error))failure
{
    getOrderRequest *request = [getOrderRequest newRequestWithOrderId:orderSummary.OrderId andOrderIdType:OrderIdTypeOrderId];
    
    NSString * getOrderBodyXMLString = [GetOrderXMLParser xmlStringFromGetOrderRequest:request];
    
    NSMutableURLRequest *getOrderURLRequest = [self newSelfServiceURLRequestWithActionName:kSTIPoCSelfServiceGetOrderActionName];
    getOrderURLRequest.HTTPBody = [getOrderBodyXMLString dataUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperation *getOrdersHTTPRequestOperation = [self HTTPRequestOperationWithRequest:getOrderURLRequest success:^(AFHTTPRequestOperation *operation, id responseObject) {
        GetOrderResult *result = [GetOrderXMLParser getOrderResultFromXMLString:[[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding]];
        if ([result.ResponseCode isEqualToString:kSTIPoCSelfServiceResponseCodeError]) {
            DDLogWarn(@"Get Order Succeeded with Error\n Response Code:%@\nResponse Message:%@", result.ResponseCode, result.ResponseMessage);
            NSError *error = [NSError errorWithDomain:kSTIPoCSelfServiceErrorGetOrderDomain code:[result.ResponseCode integerValue] userInfo:nil];
            failure(error);
            return;
        }

        [orderSummary setAttributesWithGetOrderResult:result];
        
        DDLogInfo(@"Get Order SUCCEEDED");
        completion(orderSummary);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DDLogWarn(@"URL: %@", getOrderURLRequest.URL.absoluteString);
        DDLogError(@"HTTP METHOD: %@", operation.request.HTTPMethod);
        DDLogVerbose(@"ALL HTTP HEADER KEYS: %@", operation.request.allHTTPHeaderFields.allKeys);
        DDLogVerbose(@"ALL HTTP HEADER VALUES: %@", operation.request.allHTTPHeaderFields.allValues);
        DDLogVerbose(@"ALL HTTP HEADER ALL: %@", operation.request.allHTTPHeaderFields);
        DDLogInfo(@"BODY: %@", [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
        
        DDLogError(@"STATUS CODE: %i", operation.response.statusCode);
    }];
    
    
    [getOrdersHTTPRequestOperation start];
}

- (void)startUpdateOrderStatusOperationWithOrderSummary:(OrderSummary *)orderSummary
                                        completionBlock:(void(^)())completion
                                        andFailureBlock:(void(^)(NSError *error))failure
{
    
}

- (void)startModifyOrderDetailsOperationWithOrders:(NSArray *)orders
                                   completionBlock:(void(^)())completion
                                   andFailureBlock:(void(^)(NSError *error))failure
{
    
}

@end
