//
//  STIPoCTests.m
//  STIPoCTests
//
//  Created by Administrator on 11/12/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OCMock/OCMock.h"

@interface STIPoCTests : XCTestCase

@end

@implementation STIPoCTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    id stringMock = [OCMockObject niceMockForClass:[NSString class]];
    [[[stringMock expect] andReturn:@"aString"] stringByAppendingString:[OCMArg any]];
    
    XCTAssertTrue([[stringMock stringByAppendingString:@"asd"] isEqualToString:@"aString"], @"FAIL!");
    [stringMock verify];
    //XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

@end
