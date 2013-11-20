//
//  LoginService.h
//  STIPoC
//
//  Created by Administrator on 11/18/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "GenericService.h"

@class User;

/**
 * The user defaults key for the current user
 */
static NSString *const kSTIPoCDefaultsCurrentUserKey = @"com.STIPoC.DefaultsCurrentUserKey";

/**
 * The user defaults key for the last user
 */
static NSString *const kSTIPoCDefaultsLastUserKey = @"com.STIPoC.DefaultsLastUserKey";

@interface SessionsService : GenericService

/// The current service name.
@property (strong, nonatomic, readonly) NSString *currentServiceName;

/// The current logged in user.
@property (strong, nonatomic, readonly) User *currentUser;

/// The last user that logged in the app.
@property (strong, nonatomic, readonly) User *lastUser;

/**
 *  Logs to the app with the specified user ID, account number and password.
 *
 *  @param  userID  the user's ID i.e. agutierrez
 *  @param  accountNumber the customers account number i.e. 30246
 *  @param  password the user's password
 *  @param  remember whether the app should remember the user or not (password not included)
 *
 *  @return a BOOL telling wheter the login was successful or not.
 *
 */
- (BOOL)loginWithUserID:(NSString *)userID customerID:(NSString *)customerID password:(NSString *)password remember:(BOOL)remember;

/**
 *  Logs out from the app and removes password from keychain if stored.
 *
 */
- (void)logout;

/**
 *  Stores the users credentials in the device keychain.
 *
 *  @param  user the user which password is going to be stored
 *
 *  @return a BOOL telling if the credentials were stored successfully or not
 *
 */
- (BOOL)storeInKeychainPassword:(NSString *)password forUser:(User *)user;

/**
 *  Retrieves a password associated to an account, domain, and the current application service.
 *
 *  @param  user the user currently logged in the app
 *
 *  @return the password string or nil if it couldn't be found in the keychain
 *
 */
- (NSString *)retrieveFromKeychainPasswordForUser:(User *)user;

/**
 *  Deletes all passwords for the current service.
 *
 *  @return a BOOL telling if the deletion process was successful
 *
 */
- (BOOL)deleteAllPasswords;

@end
