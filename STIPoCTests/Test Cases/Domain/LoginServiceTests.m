//
//  LoginServiceTests.m
//  STIPoC
//
//  Created by Administrator on 11/18/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LoginService.h"
#import "SSKeychain.h"

#define EMPTY_TEXT @""

#define WRONG_USER_ID @"WrongUserID"
#define VALID_USER_ID @"ValidUserID"
#define WRONG_PASSWORD @"WrongPassword"
#define VALID_PASSWORD @"ValidPassword"
#define WRONG_DOMAIN @"WrongDomain"
#define VALID_DOMAIN @"ValidDomain"

#define DUMMY_PASSWORD @"DummyPassword"
#define DUMMY_ACCOUNT @"DummyAccount"
#define DUMMY_SERVICE @"DummyService"
#define DUMMY_DOMAIN @"DummyDomain"

@interface LoginServiceTests : XCTestCase

@property LoginService *loginService;

@end

@implementation LoginServiceTests

- (void)setUp
{
    [super setUp];
    
    self.loginService = [LoginService sharedInstance];
    
}

- (void)tearDown
{
    self.loginService = nil;
    
    NSArray *accounts = [SSKeychain accountsForService:DUMMY_SERVICE];
    for (NSDictionary *account in accounts) {
        NSString *accountName = [account objectForKey:kSSKeychainAccountKey];
        [SSKeychain deletePasswordForService:DUMMY_SERVICE account:accountName];
    }
    
    [super tearDown];
}

#pragma mark -
#pragma mark Login

- (void)testLoginServiceSharedInstanceCannotBeNil
{
    XCTAssertNotNil(self.loginService, @"Login Service shared instance cannot be nil.");
}

- (void)testLoginServiceSharedInstanceIsKindOfClassLoginService
{
    XCTAssertTrue([self.loginService isKindOfClass:[LoginService class]], @"Login Service shared instance's class is not LoginService.");
}

- (void)testLoginServiceSharedInstanceIsAlwaysTheSame
{
    LoginService *loginService2 = [LoginService sharedInstance];
    XCTAssertEqualObjects(loginService2, self.loginService, @"Login Service shared instance must be always the same.");
}

- (void)testLoginServiceValidatesNilUserIDForLogin
{
    NSString *userID = nil;
    BOOL credentialsAreValid = [self.loginService validateCredentialsWithUserID:userID domain:VALID_DOMAIN andPassword:VALID_PASSWORD];
    
    XCTAssertFalse(credentialsAreValid, @"Nil user ID validation failed.");
}


- (void)testLoginServiceValidatesEmptyUserIDForLogin
{
    NSString *userID = EMPTY_TEXT;
    BOOL credentialsAreValid = [self.loginService validateCredentialsWithUserID:userID domain:VALID_DOMAIN andPassword:VALID_PASSWORD];
    
    XCTAssertFalse(credentialsAreValid, @"Empty user ID validation failed.");
}

- (void)testLoginServiceValidatesWrongUserIDForLogin
{
    NSString *userID = WRONG_USER_ID;
    BOOL credentialsAreValid = [self.loginService validateCredentialsWithUserID:userID domain:VALID_DOMAIN andPassword:VALID_PASSWORD];
    
    XCTAssertFalse(credentialsAreValid, @"Wrong user ID validation failed.");
}

- (void)testLoginServiceValidatesNilPasswordForLogin
{
    NSString *password = nil;
    BOOL credentialsAreValid = [self.loginService validateCredentialsWithUserID:VALID_USER_ID domain:VALID_DOMAIN andPassword:password];
    
    XCTAssertFalse(credentialsAreValid, @"Nil password validation failed.");
}

- (void)testLoginServiceValidatesEmptyPasswordForLogin
{
    NSString *password = EMPTY_TEXT;
    BOOL credentialsAreValid = [self.loginService validateCredentialsWithUserID:VALID_USER_ID domain:VALID_DOMAIN andPassword:password];
    
    XCTAssertFalse(credentialsAreValid, @"Empty password validation failed.");
}

- (void)testLoginServiceValidatesWrongPasswordForLogin
{
    NSString *password = WRONG_PASSWORD;
    BOOL credentialsAreValid = [self.loginService validateCredentialsWithUserID:VALID_USER_ID domain:VALID_DOMAIN andPassword:password];
    
    XCTAssertFalse(credentialsAreValid, @"Wrong password validation failed.");
}

- (void)testLoginServiceValidatesNilDomainForLogin
{
    NSString *domain = nil;
    BOOL credentialsAreValid = [self.loginService validateCredentialsWithUserID:VALID_USER_ID domain:domain andPassword:VALID_PASSWORD];
    
    XCTAssertFalse(credentialsAreValid, @"Nil domain validation failed.");
}

- (void)testLoginServiceValidatesEmptyDomainForLogin
{
    NSString *domain = EMPTY_TEXT;
    BOOL credentialsAreValid = [self.loginService validateCredentialsWithUserID:VALID_USER_ID domain:domain andPassword:VALID_PASSWORD];
    
    XCTAssertFalse(credentialsAreValid, @"Empty domain validation failed.");
}

- (void)testLoginServiceValidatesWrongDomainForLogin
{
    NSString *domain = WRONG_DOMAIN;
    BOOL credentialsAreValid = [self.loginService validateCredentialsWithUserID:VALID_USER_ID domain:domain andPassword:VALID_PASSWORD];
    
    XCTAssertFalse(credentialsAreValid, @"Wrong domain validation failed.");
}

- (void)testLoginCredentialsAreCorrect
{
    BOOL credentialsAreValid = [self.loginService validateCredentialsWithUserID:VALID_USER_ID domain:VALID_DOMAIN andPassword:VALID_PASSWORD];
    
    XCTAssertTrue(credentialsAreValid, @"Right credentials validation failed.");
}

#pragma mark -
#pragma mark Accounts storage in keychain

- (void)testLoginServiceKeychainPasswordStorageAndRetrieval
{
    NSString *account = DUMMY_ACCOUNT;
    NSString *service = DUMMY_SERVICE;
    NSString *password = DUMMY_PASSWORD;
    NSString *domain = DUMMY_DOMAIN;
    
    [[LoginService sharedInstance] storeInKeychainPassword:password forAssociatedAccount:account domain:domain andService:service];
    NSString *retrievedPassword = [[LoginService sharedInstance] retrieveFromKeychainPasswordForAssociatedAccount:account domain:domain andService:service];
    
    XCTAssertTrue([password isEqualToString:retrievedPassword], @"Retrieved password should be the same as the one stored.");
}

- (void)testLoginServiceDeletesFromKeychainAllPasswordsForService
{
    NSString *service = DUMMY_SERVICE;
    NSString *domain = DUMMY_DOMAIN;
    
    NSString *account = DUMMY_ACCOUNT;
    NSString *password = DUMMY_PASSWORD;
    
    NSString *account2 = @"Account2";
    NSString *password2 = @"Password2";
    
    NSString *account3 = @"Account3";
    NSString *password3 = @"Password3";
    
    [[LoginService sharedInstance] storeInKeychainPassword:password forAssociatedAccount:account domain:domain andService:service];
    [[LoginService sharedInstance] storeInKeychainPassword:password2 forAssociatedAccount:account2 domain:domain andService:service];
    [[LoginService sharedInstance] storeInKeychainPassword:password3 forAssociatedAccount:account3 domain:domain andService:service];
    
    [[LoginService sharedInstance] deleteAllPasswordsForService:service];
    
    NSString *retrievedPassword = [[LoginService sharedInstance] retrieveFromKeychainPasswordForAssociatedAccount:account domain:domain andService:service];
    NSString *retrievedPassword2 = [[LoginService sharedInstance] retrieveFromKeychainPasswordForAssociatedAccount:account2 domain:domain andService:service];
    NSString *retrievedPassword3 = [[LoginService sharedInstance] retrieveFromKeychainPasswordForAssociatedAccount:account3 domain:domain andService:service];
    
    XCTAssertFalse((retrievedPassword || retrievedPassword2 || retrievedPassword3), @"All passwords retrieved for service must be nil after deletion.");
}


@end
