//
//  SelfServiceConstants.h
//  STIPoC
//
//  Created by Administrator on 11/25/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

static NSString *const kSTIPoCSOAPActionAttributes = @"xmlns=\"http://tempuri.org/\" xmlns:i=\"http://www.w3.org/2001/XMLSchema-instance\"";
static NSString *const kSTIPoCSOAPActionFormat = @"<s:Envelope xmlns:s=\"http://schemas.xmlsoap.org/soap/envelope/\"><s:Body>%@%@%@</s:Body></s:Envelope>";

static NSString *const kSTIPoCSelfServiceEndpointURLBaseString = @"https://services-qa.oss.terremark.com/SelfService/SelfService.asmx";

static NSString *const kSTIPoCSelfServiceHTTPPOSTMethod = @"Post";

static NSString *const kSTIPoCSelfServiceContentTypeHeader = @"Content-Type";

static NSString *const kSTIPoCSelfServiceSOAPActionHeader = @"SOAPAction";

static NSString *const kSTIPoCSelfServiceContentType = @"text/xml; charset=utf-8";

static NSString *const kSTIPoCSelfServiceSOAPActionBaseURL = @"http://tempuri.org/";

static NSString *const kSTIPoCSelfServiceGetOrdersActionName = @"GetOrders";
static NSString *const kSTIPoCSelfServiceGetOrderActionName = @"GetOrder";
static NSString *const kSTIPoCSelfServiceModifyOrderDetailsActionName = @"ModifyOrderDetails";

static NSString *const kSTIPoCSelfServiceOrderIdTypeOrderId = @"OrderId";
static NSString *const kSTIPoCSelfServiceOrderIdTypeProjectId = @"ProjectId";
static NSString *const kSTIPoCSelfServiceOrderIdTypeFriendlyOrderId = @"FriendlyOrderId";

static NSString *const kSTIPoCSelfServiceOrderingTypeAsc = @"Asc";
static NSString *const kSTIPoCSelfServiceOrderingTypeDesc = @"Desc";

static NSString *const kSTIPoCSelfServiceCustomerIdTypeAccountNumber = @"AccountNumber";
static NSString *const kSTIPoCSelfServiceCustomerIdTypeBillingId = @"BillingId";
static NSString *const kSTIPoCSelfServiceCustomerIdTypeInstanceId = @"InstanceId";
static NSString *const kSTIPoCSelfServiceCustomerIdTypeNSAP = @"NSAP";

static NSString *const kSTIPoCSelfServiceResponseCodeSuccess = @"0";
static NSString *const kSTIPoCSelfServiceResponseCodeError = @"1";

static NSString *const kSTIPoCSelfServiceSourceSystemEcommerce = @"0";
static NSString *const kSTIPoCSelfServiceSourceSystemCAP = @"1";

static NSString *const kSTIPoCSelfServiceGetOrderTagFormat = @"<GetOrder %@>";
static NSString *const kSTIPoCSelfServiceGetOrderTag = @"</GetOrder>";

static NSString *const kSTIPoCSelfServiceGetOrderResultOpenTag = @"<GetOrderResult>";
static NSString *const kSTIPoCSelfServiceGetOrderResultCloseTag = @"</GetOrderResult>";

static NSString *const kSTIPoCSelfServiceGetOrdersOpenTagFormat = @"<GetOrders %@>";
static NSString *const kSTIPoCSelfServiceGetOrdersCloseTag = @"</GetOrders>";

static NSString *const kSTIPoCSelfServiceGetOrdersResultOpenTag = @"<GetOrdersResult>";
static NSString *const kSTIPoCSelfServiceGetOrdersResultCloseTag = @"</GetOrdersResult>";

static NSString *const kSTIPoCSelfServiceModifyOrderDetailsOpenTagFormat = @"<ModifyOrderDetails %@>";
static NSString *const kSTIPoCSelfServiceModifyOrderDetailsCloseTag = @"</ModifyOrderDetails>";

static NSString *const kSTIPoCSelfServiceModifyOrderDetailsResultOpenTag = @"<ModifyOrderDetailsResult>";
static NSString *const kSTIPoCSelfServiceModifyOrderDetailsResultCloseTag = @"</ModifyOrderDetailsResult>";

static NSString *const kSTIPoCSelfServiceGenericECommerceLoginId = @"SDP-Implementation Team";
static NSString *const kSTIPoCSelfServiceGenericUserName = @"Carlos Ponce";

static NSString *const kSTIPoCSelfServiceLegoCustomerInstanceId = @"12284";
