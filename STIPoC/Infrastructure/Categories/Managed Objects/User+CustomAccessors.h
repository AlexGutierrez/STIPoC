//
//  User+CustomAccessors.h
//  STIPoC
//
//  Created by Administrator on 11/20/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "User.h"

@interface User (CustomAccessors)

/// The full name of the user with the format "<lastName>, <firstName>".
@property (strong, nonatomic, readonly) NSString *fullName;

/// The full account string with the format "accountNumber/userID"
@property (strong, nonatomic, readonly) NSString *fullAccount;

@end

