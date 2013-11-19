//
//  LoginService.m
//  STIPoC
//
//  Created by Administrator on 11/18/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "LoginService.h"
#import "SSKeychain.h"

@interface LoginService ()

/**
 *  Returns a string with the format "Domain/Account"
 *
 *  @param  userID  the user's verizon ID i.e. V123456
 *  @param  domain the user's domain i.e. EMEA
 *
 *  @return a string with the format "Domain/Account"
 *
 */
- (NSString *) fullAccountWithAccount:(NSString *)account andDomain:(NSString *)domain;

@end

@implementation LoginService

#pragma mark -
#pragma mark Class Methods

+ (instancetype)sharedInstance
{
    static LoginService *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [LoginService new];
    });
    return _sharedInstance;
}

#pragma mark -
#pragma mark Public Methods

- (BOOL)validateCredentialsWithUserID:(NSString *)userID domain:(NSString *)domain andPassword:(NSString *)password
{
    // Validating empty fields
    BOOL emptyFieldExists = (!userID || [userID isEqualToString:@""] || !password || [password isEqualToString:@""] || !domain || [domain isEqualToString:@""]);
    
    // Validating credentials against DB
    BOOL wrongCredentialsFound = !([userID isEqualToString:@"ValidUserID"] && [password isEqualToString:@"ValidPassword"] && [domain isEqualToString:@"ValidDomain"]);
    
    return !(emptyFieldExists || wrongCredentialsFound);
}

- (BOOL)storeInKeychainPassword:(NSString *)password forAssociatedAccount:(NSString *)account domain:(NSString *)domain andService:(NSString *)service
{
    NSString *fullAccount = [self fullAccountWithAccount:account andDomain:domain];
    
    NSError *error = nil;
    [SSKeychain setPassword:password forService:service account:fullAccount error:&error];
    
    if (error) {
        DDLogWarn(@"Error found while storing password in keychain. Details:\n\n%@", error.localizedDescription);
    }
    
    
    return !error;
}

- (NSString *)retrieveFromKeychainPasswordForAssociatedAccount:(NSString *)account domain:(NSString *)domain  andService:(NSString *)service
{
    NSString *fullAccount = [self fullAccountWithAccount:account andDomain:domain];
    
    NSError *error = nil;
    NSString *password = [SSKeychain passwordForService:service account:fullAccount error:&error];
    
    DDLogWarn(@"Error found while storing password in keychain. Details:\n\n%@", error.localizedDescription);
    
    return password;
}

- (BOOL)deleteAllPasswordsForService:(NSString *)service
{
    NSError *error = nil;
    NSArray *accounts = [SSKeychain accountsForService:service];
    for (NSDictionary *account in accounts) {
        NSString *accountName = [account objectForKey:kSSKeychainAccountKey];
        [SSKeychain deletePasswordForService:service account:accountName error:&error];
        if (error) {
            DDLogWarn(@"Error found while storing password in keychain. Details:\n\n%@", error.localizedDescription);
            break;
        }
    }
    
    return !error;
}

#pragma mark -
#pragma mark Private Methods

- (NSString *)fullAccountWithAccount:(NSString *)account andDomain:(NSString *)domain
{
    id asd = domain;
    
    return [NSString stringWithFormat:@"%@/%@", domain, account];
}

@end
