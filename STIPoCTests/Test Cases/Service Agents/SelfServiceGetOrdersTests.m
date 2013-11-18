//
//  SelfServiceGetOrdersTests.m
//  STIPoC
//
//  Created by Administrator on 11/18/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SelfService.h"
#import "OCMock/OCMock.h"
@interface SelfServiceGetOrdersTests : XCTestCase

@property (nonatomic, strong) SelfServiceSoapBinding *binding;

@end

@implementation SelfServiceGetOrdersTests

- (void)setUp
{
    [super setUp];
    self.binding = [SelfService SelfServiceSoapBinding];
}

- (void)tearDown
{
    self.binding = nil;
    [super tearDown];
}

- (void)testSelfServiceGetOrdersRequestNotNilAfterInstantiation
{
    SelfService_GetOrdersRequest *request = [SelfService_GetOrdersRequest new];
    XCTAssertNotNil(request, @"Self Service Get Orders Request cannot be nil after instantiation.");
}

- (void)testSelfServiceGetOrdersCallNotNilAfterInstantiation
{
    SelfService_GetOrders *getOrdersCall = [SelfService_GetOrders new];
    XCTAssertNotNil(getOrdersCall, @"Self Service Get Orders Call cannot be nil after instantiation.");
}

@end
