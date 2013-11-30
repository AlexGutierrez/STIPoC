//
//  LoginService.m
//  STIPoC
//
//  Created by Administrator on 11/18/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "SessionsService.h"
#import "SSKeychain.h"
#import "User+CustomAccessors.h"
#import "Customer.h"
#import "ErrorFactory.h"

NSString *const kSTIPoCServiceName = @"com.STIPoC.SelfService";

@interface SessionsService ()

/// The current logged in user.
@property (strong, nonatomic, readwrite) User *currentUser;

/// The last user that logged in the app.
@property (strong, nonatomic, readwrite) User *lastUser;

@end

@implementation SessionsService

@synthesize currentUser = _currentUser;
@synthesize lastUser = _lastUser;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)sharedInstance
{
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self class] new];
    });
    return _sharedInstance;
}

#pragma mark -
#pragma mark Custom Accessors

- (NSString *)currentServiceName
{
    return kSTIPoCServiceName;
}

- (User *)currentUser
{
    return [User findFirstByAttribute:kSTIPoCDomainIDAttributeKey withValue:[[NSUserDefaults standardUserDefaults] objectForKey:kSTIPoCDefaultsCurrentUserKey]];
}

- (User *)lastUser
{
    return [User findFirstByAttribute:kSTIPoCDomainIDAttributeKey withValue:[[NSUserDefaults standardUserDefaults] objectForKey:kSTIPoCDefaultsLastUserKey]];
}

- (void)setCurrentUser:(User *)currentUser
{
    [[NSUserDefaults standardUserDefaults] setObject:currentUser.domainID forKey:kSTIPoCDefaultsCurrentUserKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setLastUser:(User *)lastUser
{
    [[NSUserDefaults standardUserDefaults] setObject:lastUser.domainID forKey:kSTIPoCDefaultsLastUserKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark -
#pragma mark Login/Logout

- (BOOL)loginWithUserID:(NSString *)userID
             customerID:(NSString *)customerID
               password:(NSString *)password
               remember:(BOOL)remember
                  error:(NSError **)error
{
    User *user = nil;
    
    // Validating empty and nil fields
    BOOL emptyFieldExists = (!userID || [userID isEqualToString:@""] || !password || [password isEqualToString:@""] || !customerID || [customerID isEqualToString:@""]);
    
    if (emptyFieldExists) {
        (*error) = [[ErrorFactory sharedFactory] createErrorWithSelfServiceDomain:NSLocalizedString(@"Empty fields", nil) andDescription:NSLocalizedString(@"Please fill all the required fields.", nil)];
        return NO;
    }
    else {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"domainID = %@ AND password = %@ AND customer.domainID = %@", userID, password, customerID];
        user = [User findFirstWithPredicate:predicate];
    }
    
    if (user != nil) {
        self.currentUser = user;
        
        if (remember) {
            self.lastUser = user;
            [self storeInKeychainPassword:password forUser:user];
        }
        else {
            self.lastUser = nil;
            [self deleteAllPasswords];
        }
        return YES;
    }
    else {
        (*error) = [[ErrorFactory sharedFactory] createErrorWithSelfServiceDomain:NSLocalizedString(@"Wrong credentials", nil) andDescription:NSLocalizedString(@"Please verify your user ID, customer ID and password are correct.", nil)];
        return NO;
    }
}

- (void)logout
{
    self.currentUser = nil;
    
    [self deleteAllPasswords];
}

#pragma mark -
#pragma mark Keychain Storage

- (BOOL)storeInKeychainPassword:(NSString *)password forUser:(User *)user
{
    NSError *error = nil;
    [SSKeychain setPassword:password forService:self.currentServiceName account:user.fullAccount error:&error];
    
    return !error;
}

- (NSString *)retrieveFromKeychainPasswordForUser:(User *)user
{
    NSError *error = nil;
    NSString *password = [SSKeychain passwordForService:self.currentServiceName account:user.fullAccount error:&error];
    
    return password;
}


- (BOOL)deleteAllPasswords
{
    NSError *error = nil;
    NSArray *accounts = [SSKeychain accountsForService:self.currentServiceName];
    for (NSDictionary *account in accounts) {
        NSString *accountName = [account objectForKey:kSSKeychainAccountKey];
        [SSKeychain deletePasswordForService:self.currentServiceName account:accountName error:&error];
    }
    
    return !error;
}

@end
