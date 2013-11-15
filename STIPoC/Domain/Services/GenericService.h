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

// Cleans up everything in memory
- (void)cleanUpPersistenceChangesInMemory;

// Initialization of the core data stack. Encapsulates the core data stack setup process
- (void)setupCoreDataStack;

// Truncates all records
- (void)truncateAll;

@end
