//
//  User.h
//  STIPoC
//
//  Created by Administrator on 11/20/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Entity.h"

@class Customer;

@interface User : Entity

/// The first name of the user.
@property (retain, nonatomic) NSString *firstName;

/// The last name of the user.
@property (retain, nonatomic) NSString *lastName;

/// The password of the user.
@property (retain, nonatomic) NSString *password;

/// The customer associated to the user.
@property (retain, nonatomic) Customer *customer;


@end
