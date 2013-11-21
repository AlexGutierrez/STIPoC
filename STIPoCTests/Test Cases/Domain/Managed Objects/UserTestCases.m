//
//  ATestCase.m
//  STIPoC
//
//  Created by Administrator on 11/20/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "User+CustomAccessors.h"
#import "Customer.h"
#import "GenericService.h"

static NSString *const kSTIPoCTestsUserID = @"agutierrez";
static NSString *const kSTIPoCTestsUserFirstName = @"Alex";
static NSString *const kSTIPoCTestsUserLastName = @"Gutierrez";

static NSString *const kSTIPoCTestsCustomerID = @"40257";
static NSString *const kSTIPoCTestsCustomerName = @"NASDAQ";

@interface UserTestCases : XCTestCase

@end

@implementation UserTestCases

- (void)setUp
{
    [[GenericService sharedInstance] setupTestCoreDataStack];
    [super setUp];
}

- (void)tearDown
{
    [[GenericService sharedInstance] cleanUpPersistenceChangesInMemory];
    
    [super tearDown];
}

#pragma mark -
#pragma mark Custom Accessors

- (void)testUserFullNameIsCorrect
{
    Customer *customer = [Customer createEntity];
    customer.domainID = kSTIPoCTestsCustomerID;
    customer.name = kSTIPoCTestsCustomerName;
    
    User *user = [User createEntity];
    user.domainID = kSTIPoCTestsUserID;
    user.firstName = kSTIPoCTestsUserFirstName;
    user.lastName = kSTIPoCTestsUserLastName;
    user.customer = customer;
    
    NSString *fullName = user.fullName;
    
    XCTAssertTrue(([fullName isEqualToString:[NSString stringWithFormat:@"%@, %@", user.lastName, user.firstName]]), @"Full name must have the format '<lastName>, <firstName>'.");
}

- (void)testUserFullAccountIsCorrect
{
    Customer *customer = [Customer createEntity];
    customer.domainID = kSTIPoCTestsCustomerID;
    customer.name = kSTIPoCTestsCustomerName;
    
    User *user = [User createEntity];
    user.domainID = kSTIPoCTestsUserID;
    user.firstName = kSTIPoCTestsUserFirstName;
    user.lastName = kSTIPoCTestsUserLastName;
    user.customer = customer;
    
    NSString *fullAccount = user.fullAccount;
    
    XCTAssertTrue(([fullAccount isEqualToString:[NSString stringWithFormat:@"%@/%@", user.customer.domainID, user.domainID]]), @"Full name must have the format '<customerID>, <userID>'.");
}

@end