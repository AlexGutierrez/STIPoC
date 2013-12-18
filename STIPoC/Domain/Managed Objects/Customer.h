//
//  Customer.h
//  STIPoC
//
//  Created by Administrator on 11/20/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Entity.h"

@class User;

@interface Customer : Entity

/// The customer name
@property (strong, nonatomic) NSString *name;

/// The users associated to this customer
@property (nonatomic, retain) NSSet *users;

@end

@interface Customer (CoreDataGeneratedAccessors)

- (void)addUsersObject:(User *)value;
- (void)removeUsersObject:(User *)value;
- (void)addUsers:(NSSet *)values;
- (void)removeUsers:(NSSet *)values;

@end
