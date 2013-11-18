//
//  SelfServiceTests.m
//  STIPoC
//
//  Created by Administrator on 11/18/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SelfService.h"

@interface SelfServiceGenericTests : XCTestCase

@property (nonatomic, strong) SelfServiceSoapBinding *binding;

@end

@implementation SelfServiceGenericTests

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

- (void)testSelfServiceBindingNotNilAfterInstantiation
{
    XCTAssertNotNil(self.binding, @"Binding cannot be nil after instantiation.");
}

- (void)testSelfServiceBindingSharedInstanceIsAlwaysTheSame
{
    SelfServiceSoapBinding *binding2 = [SelfService SelfServiceSoapBinding];
    
    XCTAssertNotEqualObjects(self.binding, binding2, @"Binding shared instance must be always the same.");
}

- (void)testSelfServiceBindingOperation
{
    //self.binding
    SelfServiceSoapBinding *binding2 = [SelfService SelfServiceSoapBinding];
    
    XCTAssertNotEqualObjects(self.binding, binding2, @"Binding shared instance must be always the same.");
}

@end
