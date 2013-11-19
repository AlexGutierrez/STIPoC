//
//  LoginService.h
//  STIPoC
//
//  Created by Administrator on 11/18/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "GenericService.h"

@interface LoginService : GenericService

/**
 *  Validates whether the credentials are nil, empty or just incorrect.
 *
 *  @param  userID  the user's verizon ID i.e. V123456
 *  @param  domain the user's domain i.e. EMEA
 *  @param  password the user's password
 *
 *  @return a BOOL telling wheter the credentials are valid or not.
 *
 */
- (BOOL)validateCredentialsWithUserID:(NSString *)userID domain:(NSString *)domain andPassword:(NSString *)password;

/**
 *  Stores the users credentials in the device keychain.
 *
 *  @param  userID  the user's verizon ID i.e. V123456
 *  @param  domain the user's domain i.e. EMEA
 *  @param  password the user's password
 *  @param  service the service that the user is using currently. i.e. SDP
 *
 *  @return a BOOL telling if the credentials were stored successfully
 *
 */
- (BOOL)storeInKeychainPassword:(NSString *)password forAssociatedAccount:(NSString *)account domain:(NSString *)domain andService:(NSString *)service;

/**
 *  Retrieves a password associated to an account, domain and service.
 *
 *  @param  userID  the user's verizon ID i.e. V123456
 *  @param  domain the user's domain i.e. EMEA
 *  @param  password the user's password
 *  @param  service the service that the user is using currently. i.e. SDP
 *
 *  @return the password string or nil if it couldn't be found in the keychain
 *
 */
- (NSString *)retrieveFromKeychainPasswordForAssociatedAccount:(NSString *)account domain:(NSString *)domain andService:(NSString *)service;

/**
 *  Deletes all passwords associated to a service.
 *
 *  @param  service the service that the user is using currently. i.e. SDP
 *
 *  @return a BOOL telling if the deletion process was successful
 *
 */
- (BOOL)deleteAllPasswordsForService:(NSString *)service;

@end
