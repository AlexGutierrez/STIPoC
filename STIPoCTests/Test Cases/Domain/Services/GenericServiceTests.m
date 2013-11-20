//
//  GenericServiceTests.m
//  STIPoC
//
//  Created by Administrator on 11/15/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GenericService.h"
#import "Domain.h"
#import "User.h"
#import "Customer.h"

static GenericService *genericService;

@interface GenericServiceTests : XCTestCase

@end

@implementation GenericServiceTests

+ (void)setUp
{
    [super setUp];
    
    genericService = [GenericService sharedInstance];
    [genericService setupTestCoreDataStack];
    [genericService createDummyData];
}

+ (void)tearDown
{
    [MagicalRecord saveUsingCurrentThreadContextWithBlockAndWait:^(NSManagedObjectContext *localContext) {
         [Domain truncateAllInContext:localContext];
     }];
    
    [genericService cleanUpPersistenceChangesInMemory];
    genericService = nil;
    
    [super tearDown];
}

#pragma mark -
#pragma mark Instantiation

- (void)testGenericServiceSharedInstanceCannotBeNil
{
    XCTAssertNotNil(genericService, @"Generic Service shared instance cannot be nil.");
}

- (void)testGenericServiceSharedInstanceIsAlwaysTheSame
{
    GenericService *genericService2 = [GenericService sharedInstance];
    XCTAssertEqualObjects(genericService2, genericService, @"Generic Service shared instance must be always the same.");
}

- (void)testLoginServiceSharedInstanceIsKindOfClassGenericService
{
    XCTAssertTrue([genericService isKindOfClass:[GenericService class]], @"Generic Service shared instance's class is not GenericService.");
}

#pragma mark -
#pragma mark Core Data Stack

- (void)testGenericServiceSetupsCoreDataStackCorrectly
{
    [genericService cleanUpPersistenceChangesInMemory];
    [genericService setupCoreDataStack];
    
    XCTAssertNotNil([NSPersistentStore defaultPersistentStore], @"Default Persistent Store should be created.");
    XCTAssertNotNil([NSPersistentStoreCoordinator defaultStoreCoordinator], @"Default Persistent Store Coordinator should be created.");
    XCTAssertNotNil([NSManagedObjectContext defaultContext], @"Default Managed Object Context should be created.");
    
    [genericService cleanUpPersistenceChangesInMemory];
    [genericService setupTestCoreDataStack];
}

- (void)testGenericServiceSetupsTestCoreDataStackCorrectly
{
    XCTAssertNotNil([NSPersistentStore defaultPersistentStore], @"Default Persistent Store should be created.");
    XCTAssertNotNil([NSPersistentStoreCoordinator defaultStoreCoordinator], @"Default Persistent Store Coordinator should be created.");
    XCTAssertNotNil([NSManagedObjectContext defaultContext], @"Default Managed Object Context should be created.");
    
    XCTAssertTrue([[NSPersistentStore defaultPersistentStore].type isEqualToString:NSInMemoryStoreType], @"Core data stack should be set in memory");
}

- (void)testGenericServiceCleansUpPersistenceChangesInMemoryCorrectly
{
    [genericService cleanUpPersistenceChangesInMemory];
    XCTAssertNil([NSPersistentStore defaultPersistentStore], @"Default Persistent Store should be cleaned up.");
    XCTAssertNil([NSPersistentStoreCoordinator defaultStoreCoordinator], @"Default Persistent Store Coordinator should be cleaned up.");
    XCTAssertNil([NSManagedObjectContext defaultContext], @"Default Managed Object Context should be cleaned up.");
    [genericService setupTestCoreDataStack];
}

- (void)testGenericServiceTruncatesAllData
{
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        [Domain createInContext:localContext];
        [Domain createInContext:localContext];
        [Domain createInContext:localContext];
    }];
    
    XCTAssert([Domain countOfEntities] > 0, @"Data before truncation test should be more than 0!");
    
    [genericService truncateAll];
    
    XCTAssert([Domain countOfEntities] == 0, @"All data should be truncated");
    
    [genericService createDummyData];
}

#pragma mark -
#pragma mark Dummy Data

- (void)testDummyDataWasCreated
{
    Customer *aDummyCustomer = [Customer findFirstByAttribute:kSTIPoCDomainIDAttributeKey withValue:kSTIPoCDummyCustomerID];
    User *aDummyUser1 = [User findFirstByAttribute:kSTIPoCDomainIDAttributeKey withValue:kSTIPoCDummyUser1UserID];
    User *aDummyUser2 = [User findFirstByAttribute:kSTIPoCDomainIDAttributeKey withValue:kSTIPoCDummyUser2UserID];
    
    XCTAssertTrue((aDummyCustomer && aDummyUser1 && aDummyUser2), @"Dummy data should have been created.");
}

- (void)testDummyUser1DataIsCorrect
{
    XCTAssertTrue([[genericService dummyUser1].firstName isEqualToString:kSTIPoCDummyUser1FirstName], @"Dummy user 1 first name is incorrect.");
    XCTAssertTrue([[genericService dummyUser1].lastName isEqualToString:kSTIPoCDummyUser1LastName], @"Dummy user 1 last name is incorrect.");
    XCTAssertTrue([[genericService dummyUser1].domainID isEqualToString:kSTIPoCDummyUser1UserID], @"Dummy user 1 userID is incorrect.");
    XCTAssertTrue([[genericService dummyUser1].password isEqualToString:kSTIPoCDummyUser1Password], @"Dummy user 1 password is incorrect.");
    XCTAssertEqualObjects([genericService dummyUser1].customer, [genericService dummyCustomer], @"Dummy user 1 customer is incorrect.");
}

- (void)testDummyUser2DataIsCorrect
{
    XCTAssertTrue([[genericService dummyUser2].firstName isEqualToString:kSTIPoCDummyUser2FirstName], @"Dummy user 2 first name is incorrect.");
    XCTAssertTrue([[genericService dummyUser2].lastName isEqualToString:kSTIPoCDummyUser2LastName], @"Dummy user 2 last name is incorrect.");
    XCTAssertTrue([[genericService dummyUser2].domainID isEqualToString:kSTIPoCDummyUser2UserID], @"Dummy user 2 userID is incorrect.");
    XCTAssertTrue([[genericService dummyUser2].password isEqualToString:kSTIPoCDummyUser2Password], @"Dummy user 2 password is incorrect.");
    XCTAssertEqualObjects([genericService dummyUser2].customer, [genericService dummyCustomer], @"Dummy user 2 customer is incorrect.");
}

- (void)testDummyCustomerIsRetrievedCorrectly
{
    Customer *dummyCustomer = [Customer findFirstByAttribute:kSTIPoCDomainIDAttributeKey withValue:kSTIPoCDummyCustomerID];
    XCTAssertNotNil([genericService dummyCustomer], @"Dummy customer should not be nil.");
    XCTAssertEqualObjects([genericService dummyCustomer].domainID, dummyCustomer.domainID, @"Dummy customer should be the same as the one in the store.");
}

- (void)testDummyUser1IsRetrievedCorrectly
{
    User *dummyUser1 = [User findFirstByAttribute:kSTIPoCDomainIDAttributeKey withValue:kSTIPoCDummyUser1UserID];
    XCTAssertNotNil([genericService dummyCustomer], @"Dummy user 2 should not be nil.");
    XCTAssertEqualObjects([genericService dummyUser1].domainID, dummyUser1.domainID, @"Dummy user 1 should be the same as the one in the store.");
}

- (void)testDummyUser2IsRetrievedCorrectly
{
    User *dummyUser2 = [User findFirstByAttribute:kSTIPoCDomainIDAttributeKey withValue:kSTIPoCDummyUser2UserID];
    XCTAssertNotNil([genericService dummyUser2], @"Dummy user 2 should not be nil.");
    XCTAssertEqualObjects([genericService dummyUser2].domainID, dummyUser2.domainID, @"Dummy user 2 should be the same as the one in the store.");
}

- (void)testDummyDataCreationSetsFirstTimeKeyValueInDefaults
{
    id firstTimeKeyValue = [[NSUserDefaults standardUserDefaults] objectForKey:kSTIPoCDefaultsIsFirstTimeKey];
    
    XCTAssertNotNil(firstTimeKeyValue,  @"First time key value not set in defaults.");
}

- (void)testDummyDataCreationsExecutedOnlyTheFirstTime
{
    [MagicalRecord saveUsingCurrentThreadContextWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        [Domain truncateAllInContext:localContext];
    }];
    [genericService createDummyData];
    
    XCTAssertFalse(([genericService dummyUser1] || [genericService dummyUser2] || [genericService dummyCustomer]), @"Dummy data should be stored only the first time.");
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kSTIPoCDefaultsIsFirstTimeKey];
    [genericService createDummyData];
}

@end
