//
//  LoginServiceTests.m
//  STIPoC
//
//  Created by Administrator on 11/18/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LoginService.h"

#define WRONG_USER_ID @"WrongUserID"
#define VALID_USER_ID @"ValidUserID"
#define WRONG_PASSWORD @"WrongPassword"
#define VALID_PASSWORD @"ValidPassword"
#define WRONG_DOMAIN @"WrongDomain"
#define VALID_DOMAIN @"ValidDomain"
#define EMPTY_TEXT @""

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
    
    [super tearDown];
}

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

@end
