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
- (void)cleanUpDatabase;

// Only for migrations that are not lightweight
- (void)setupDatabaseForMigrationPolicies;

// Initialization of the database. Encapsulates the core data stack setup process
- (void)setupDatabase;

// Truncates all records
- (void)truncateAll;

@end
