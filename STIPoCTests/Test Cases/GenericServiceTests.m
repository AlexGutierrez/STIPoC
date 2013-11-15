//
//  GenericServiceTests.m
//  STIPoC
//
//  Created by Administrator on 11/15/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GenericService.h"
#import "Entity.h"

@interface GenericServiceTests : XCTestCase

@property GenericService *genericService;

@end

@implementation GenericServiceTests

- (void)setUp
{
    [super setUp];
    
    self.genericService = [GenericService sharedInstance];
    [self.genericService setupCoreDataStack];
    
}

- (void)tearDown
{
    [self.genericService cleanUpPersistenceChangesInMemory];
    self.genericService = nil;
    
    [super tearDown];
}

- (void)testGenericServiceSharedInstanceCannotBeNil
{
    XCTAssertNotNil(self.genericService, @"Generic Service shared instance cannot be nil.");
}

- (void)testGenericServiceSharedInstanceIsAlwaysTheSame
{
    GenericService *genericService2 = [GenericService sharedInstance];
    XCTAssertEqualObjects(genericService2, self.genericService, @"Generic Service shared instance must be always the same.");
}

- (void)testGenericServiceCreatesDefaultPersistentStore
{
    XCTAssertNotNil([NSPersistentStore defaultPersistentStore], @"Default Persistent Store should be created.");
}

- (void)testGenericServiceCreatesDefaultPersistentStoreCoordinator
{
    XCTAssertNotNil([NSPersistentStoreCoordinator defaultStoreCoordinator], @"Default Persistent Store Coordinator should be created.");
}

- (void)testGenericServiceCreatesDefaultManagedObjectContext
{
    XCTAssertNotNil([NSManagedObjectContext defaultContext], @"Default Managed Object Context should be created.");
}

- (void)testGenericServiceCleansUpDefaultPersistentStore
{
    [self.genericService cleanUpPersistenceChangesInMemory];
    XCTAssertNil([NSPersistentStore defaultPersistentStore], @"Default Persistent Store should be cleaned up.");
}

- (void)testGenericServiceCleansUpDefaultPersistentStoreCoordinator
{
    [self.genericService cleanUpPersistenceChangesInMemory];
    XCTAssertNil([NSPersistentStoreCoordinator defaultStoreCoordinator], @"Default Persistent Store Coordinator should be cleaned up.");
}

- (void)testGenericServiceCleansUpDefaultManagedObjectContext
{
    [self.genericService cleanUpPersistenceChangesInMemory];
    XCTAssertNil([NSManagedObjectContext defaultContext], @"Default Managed Object Context should be cleaned up.");
}

- (void)testGenericServiceTruncatesAllData
{
    [[NSManagedObjectContext defaultContext] saveToPersistentStoreWithCompletion:^(BOOL completion, NSError *error) {
        [Entity createEntity];
    }];
    
    XCTAssert([Entity countOfEntities] == 0, @"Data before truncation test should be more than 0!");
    
    [self.genericService truncateAll];
    
    XCTAssert([Entity countOfEntities] == 0, @"All data should be truncated");
}

@end
