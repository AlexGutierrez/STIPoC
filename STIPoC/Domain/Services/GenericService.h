//
//  GenericService.h
//  STIPoC
//
//  Created by Administrator on 11/12/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;
@class Customer;

/**
 * A user defaults key only to know if its the first time the app has been executed or not
 */
static NSString *const kSTIPoCDefaultsIsFirstTimeKey = @"IsFirstTime";

/**
 * The dummy customer name
 */
static NSString *const kSTIPoCDummyCustomerName = @"Lego";

/**
 * The dummy customer ID
 */
static NSString *const kSTIPoCDummyCustomerID = @"AM";

/**
 * The dummy user 1 first name
 */
static NSString *const kSTIPoCDummyUser1FirstName = @"Alex";

/**
 * The dummy user 1 last name
 */
static NSString *const kSTIPoCDummyUser1LastName = @"Gutierrez";

/**
 * The dummy user 1 last name
 */
static NSString *const kSTIPoCDummyUser1UserID = @"agutierrez";

/**
 * The dummy user 2 first name
 */
static NSString *const kSTIPoCDummyUser2FirstName = @"Jorge";

/**
 * The dummy user 2 last name
 */
static NSString *const kSTIPoCDummyUser2LastName = @"Valdivia";

/**
 * The dummy user 2 last name
 */
static NSString *const kSTIPoCDummyUser2UserID = @"jvaldivia";

/**
 * The dummy user 1 password
 */
static NSString *const kSTIPoCDummyUser1Password = @"asdf";

/**
 * The dummy user 2 password
 */
static NSString *const kSTIPoCDummyUser2Password = @"1234";

@interface GenericService : NSObject

/// Gets a dummy user for testing
@property (strong, nonatomic, readonly) User *dummyUser1;

/// Gets another dummy user for testing
@property (strong, nonatomic, readonly) User *dummyUser2;

/// Gets the dummy customer for testing
@property (strong, nonatomic, readonly) Customer *dummyCustomer;

+ (instancetype)sharedInstance;

/**
 *  Cleans up any pending persistence change in memory.
 *
 *  @param forTest whether the dummy creation is for testing or not
 */
- (void)cleanUpPersistenceChangesInMemory;

/**
 *  Initialization of the core data stack. Encapsulates the core data stack setup process in one single method.
 */
- (void)setupCoreDataStack;

/**
 *  Initialization of the core data stack for testing. Instead of using the real one, it creates a core data stack in memory.
 */
- (void)setupCoreDataStackForTesting;

/**
 *  Truncates all existing data in the store.
 */
- (void)truncateAll;

/**
 *  Creates dummy data only the first time the app runs...
 *
 */
- (void)createDummyDataForProd;

/**
 *  Creates dummy data...
 *
 */
- (void)createDummyData;

@end
