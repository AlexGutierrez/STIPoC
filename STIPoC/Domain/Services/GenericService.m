 //
//  GenericService.m
//  STIPoC
//
//  Created by Administrator on 11/12/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "GenericService.h"
#import "User.h"
#import "Customer.h"

@interface GenericService ()

@end

@implementation GenericService

@synthesize dummyUser1 = _dummyUser1;
@synthesize dummyUser2 = _dummyUser2;
@synthesize dummyCustomer = _dummyCustomer;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)sharedInstance
{
    static GenericService *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [GenericService new];
    });
    return _sharedInstance;
}

#pragma mark -
#pragma mark Custom Accessors

- (Customer *)dummyCustomer
{
    if (!_dummyCustomer || [_dummyCustomer isFault]) {
        _dummyCustomer = [Customer findFirstByAttribute:kSTIPoCDomainIDAttributeKey withValue:kSTIPoCDummyCustomerID];
    }
    return _dummyCustomer;
}

- (User *)dummyUser1
{
    if (!_dummyUser1 || [_dummyUser1 isFault]) {
        _dummyUser1 = [User findFirstByAttribute:kSTIPoCDomainIDAttributeKey withValue:kSTIPoCDummyUser1UserID];
    }
    return _dummyUser1;
}

- (User *)dummyUser2
{
    if (!_dummyUser2 || [_dummyUser2 isFault]) {
        _dummyUser2 = [User findFirstByAttribute:kSTIPoCDomainIDAttributeKey withValue:kSTIPoCDummyUser2UserID];
    }
    return _dummyUser2;
}

#pragma mark -
#pragma mark Public Methods

- (void)cleanUpPersistenceChangesInMemory
{
    [MagicalRecord cleanUp];
}

- (void)setupCoreDataStack
{
    [MagicalRecord cleanUp];
    [MagicalRecord setShouldDeleteStoreOnModelMismatch:NO];
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:kSTIPoCDefaultStoreName];
}

- (void)setupCoreDataStackForTesting
{
    [MagicalRecord cleanUp];
    [MagicalRecord setShouldDeleteStoreOnModelMismatch:NO];
    [MagicalRecord setupCoreDataStackWithInMemoryStore];
}

- (void)truncateAll
{
    [Domain truncateAll];
    [[NSManagedObjectContext contextForCurrentThread] saveOnlySelfAndWait];
}

- (void)createDummyDataForProd
{
    NSNumber *isFirstTime = [[NSUserDefaults standardUserDefaults] objectForKey:kSTIPoCDefaultsIsFirstTimeKey];
    
    if (!isFirstTime || isFirstTime.boolValue) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@NO forKey:kSTIPoCDefaultsIsFirstTimeKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
#if (!defined(TEST))
        [self createDummyData];
#endif
    }
}

- (void)createDummyData
{
    Customer *dummyCustomer = [Customer createEntity];
    dummyCustomer.domainID = kSTIPoCDummyCustomerID;
    dummyCustomer.name = kSTIPoCDummyCustomerName;
    
    User *dummyUser1 = [User createEntity];
    dummyUser1.domainID = kSTIPoCDummyUser1UserID;
    dummyUser1.firstName = kSTIPoCDummyUser1FirstName;
    dummyUser1.lastName = kSTIPoCDummyUser1LastName;
    dummyUser1.password = kSTIPoCDummyUser1Password;
    dummyUser1.customer = dummyCustomer;
    
    User *dummyUser2 = [User createEntity];
    dummyUser2.domainID = kSTIPoCDummyUser2UserID;
    dummyUser2.firstName = kSTIPoCDummyUser2FirstName;
    dummyUser2.lastName = kSTIPoCDummyUser2LastName;
    dummyUser2.password = kSTIPoCDummyUser2Password;
    dummyUser2.customer = dummyCustomer;
    
    [[NSManagedObjectContext contextForCurrentThread] saveOnlySelfAndWait];
}

@end
