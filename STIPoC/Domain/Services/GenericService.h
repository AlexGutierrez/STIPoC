//
//  GenericService.h
//  STIPoC
//
//  Created by Administrator on 11/12/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GenericService : NSObject

+ (instancetype)sharedInstance;

/**
 *  Cleans up any pending persistence change in memory.
 */
- (void)cleanUpPersistenceChangesInMemory;

/**
 *  Initialization of the core data stack. Encapsulates the core data stack setup process in one single method.
 */
- (void)setupCoreDataStack;

/**
 *  Truncates all existing data in the store.
 */
// Truncates all records
- (void)truncateAll;

/**
 *  When you don't have any real data... 
 */
- (void)dummyDataGeneration;

@end
