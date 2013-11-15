//
//  GenericService.m
//  STIPoC
//
//  Created by Administrator on 11/12/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "GenericService.h"
#import "Entity.h"

@interface GenericService ()

@end

@implementation GenericService

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
#pragma mark Public Methods

- (void)cleanUpPersistenceChangesInMemory
{
    [MagicalRecord cleanUp];
}

- (void)setupCoreDataStack
{
    [MagicalRecord setShouldDeleteStoreOnModelMismatch:NO];
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:DEFAULT_STORE_NAME];
}

- (void)truncateAll
{
    [MagicalRecord saveUsingCurrentThreadContextWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        [Entity truncateAllInContext:localContext];
    }];
}

@end
