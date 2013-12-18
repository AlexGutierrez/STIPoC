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
#import "ErrorFactory.h"

static NSString *const kSTIPoCDefaultStoreName = @"com.STIPoC.DefaultStoreName";

@interface GenericService ()

@end

@implementation GenericService

@synthesize dummyUser1 = _dummyUser1;
@synthesize dummyUser2 = _dummyUser2;
@synthesize dummyCustomer = _dummyCustomer;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)sharedService
{
    static id _sharedService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedService = [[self class] new];
    });
    return _sharedService;
}

#pragma mark -
#pragma mark Custom Accessors

- (Customer *)dummyCustomer
{
    if (!_dummyCustomer || [_dummyCustomer isFault]) {
        _dummyCustomer = [Customer findFirstByAttribute:kSTIPoCEntityIDAttributeKey withValue:kSTIPoCDummyCustomerID];
    }
    return _dummyCustomer;
}

- (User *)dummyUser1
{
    if (!_dummyUser1 || [_dummyUser1 isFault]) {
        _dummyUser1 = [User findFirstByAttribute:kSTIPoCEntityIDAttributeKey withValue:kSTIPoCDummyUser1UserID];
    }
    return _dummyUser1;
}

- (User *)dummyUser2
{
    if (!_dummyUser2 || [_dummyUser2 isFault]) {
        _dummyUser2 = [User findFirstByAttribute:kSTIPoCEntityIDAttributeKey withValue:kSTIPoCDummyUser2UserID];
    }
    return _dummyUser2;
}

- (NSError *)defaultPublicError
{
    return ([AFNetworkReachabilityManager sharedManager].reachable) ? [[ErrorFactory sharedFactory] createDefaultServerError] : [[ErrorFactory sharedFactory] createDefaultNetworkReachabilityError];
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
    [Entity truncateAll];
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
    dummyCustomer.entityID = kSTIPoCDummyCustomerID;
    dummyCustomer.name = kSTIPoCDummyCustomerName;
    
    User *dummyUser1 = [User createEntity];
    dummyUser1.entityID = kSTIPoCDummyUser1UserID;
    dummyUser1.firstName = kSTIPoCDummyUser1FirstName;
    dummyUser1.lastName = kSTIPoCDummyUser1LastName;
    dummyUser1.password = kSTIPoCDummyUser1Password;
    dummyUser1.customer = dummyCustomer;
    
    User *dummyUser2 = [User createEntity];
    dummyUser2.entityID = kSTIPoCDummyUser2UserID;
    dummyUser2.firstName = kSTIPoCDummyUser2FirstName;
    dummyUser2.lastName = kSTIPoCDummyUser2LastName;
    dummyUser2.password = kSTIPoCDummyUser2Password;
    dummyUser2.customer = dummyCustomer;
    
    [[NSManagedObjectContext contextForCurrentThread] saveOnlySelfAndWait];
}

@end
