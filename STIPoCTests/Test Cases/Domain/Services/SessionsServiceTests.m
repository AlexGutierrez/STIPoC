//
//  SessionsServiceTests.m
//  STIPoC
//
//  Created by Administrator on 11/18/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SessionsService.h"
#import "SSKeychain.h"

#import "User.h"
#import "Customer.h"

static NSString *const kSTIPoCTestsEmptyText = @"";

static NSString *const kSTIPoCTestsWrongUserID = @"WrongUserID";
static NSString *const kSTIPoCTestsWrongPassword = @"WrongPassword";
static NSString *const kSTIPoCTestsWrongAccountNumber = @"WrongAccountNumber";

static SessionsService *sessionsService;

@interface SessionsServiceTests : XCTestCase

@end

@implementation SessionsServiceTests

- (void)setUp
{
    [super setUp];
    
    sessionsService = [SessionsService sharedInstance];
    [sessionsService setupCoreDataStackForTesting];
    [sessionsService createDummyData];
}

- (void)tearDown
{
    [sessionsService cleanUpPersistenceChangesInMemory];
    sessionsService = nil;
    
    [SSKeychain deletePasswordForService:kSTIPoCServiceName account:[NSString stringWithFormat:@"%@/%@", [sessionsService dummyUser1].customer.domainID, [sessionsService dummyUser1].domainID]];
    [SSKeychain deletePasswordForService:kSTIPoCServiceName account:[NSString stringWithFormat:@"%@/%@", [sessionsService dummyUser2].customer.domainID, [sessionsService dummyUser2].domainID]];
    
    [super tearDown];
}

#pragma mark -
#pragma mark Instantiation

- (void)testSessionsServiceSharedInstanceCannotBeNil
{
    XCTAssertNotNil(sessionsService, @"Sessions Service shared instance cannot be nil.");
}

- (void)testSessionsServiceSharedInstanceIsKindOfClassSessionsService
{
    XCTAssertTrue([sessionsService isKindOfClass:[SessionsService class]], @"Sessions Service shared instance's class is not SessionsService.");
}

- (void)testSessionsServiceSharedInstanceIsAlwaysTheSame
{
    SessionsService *sessionsService2 = [SessionsService sharedInstance];
    XCTAssertEqualObjects(sessionsService2, sessionsService, @"Sessions Service shared instance must be always the same.");
}

#pragma mark -
#pragma mark Custom Accessors

- (void)testCurrentServiceName
{
    NSString *currentServiceName = [sessionsService currentServiceName];
    XCTAssertTrue([currentServiceName isEqualToString:kSTIPoCServiceName], @"Service name not equal to the current one");
}

- (void)testCurrentUserIsTheSameAsInDefaults
{
    [sessionsService loginWithUserID:[sessionsService dummyUser1].domainID customerID:[sessionsService dummyUser1].customer.domainID password:kSTIPoCDummyUser1Password remember:YES];
    
    User *currentUser = [sessionsService currentUser];
    User *currentUser2 = [User findFirstByAttribute:kSTIPoCDomainIDAttributeKey withValue:[[NSUserDefaults standardUserDefaults] objectForKey:kSTIPoCDefaultsCurrentUserKey]];
    XCTAssertEqualObjects(currentUser, currentUser2, @"User retrieved from the service must be equal to the one retrieved from the defaults");
}

- (void)testLastUserIsTheSameAsInDefaults
{
    [sessionsService loginWithUserID:[sessionsService dummyUser1].domainID customerID:[sessionsService dummyUser1].customer.domainID password:kSTIPoCDummyUser1Password remember:YES];
    
    User *lastUser = [sessionsService lastUser];
    User *lastUser2 = [User findFirstByAttribute:kSTIPoCDomainIDAttributeKey withValue:[[NSUserDefaults standardUserDefaults] objectForKey:kSTIPoCDefaultsLastUserKey]];
    XCTAssertEqualObjects(lastUser, lastUser2, @"User retrieved from the service must be equal to the one retrieved from the defaults");
}

#pragma mark -
#pragma mark Keychain Storage

- (void)testSessionsServiceKeychainPasswordStorageAndRetrieval
{
    User *user = [sessionsService dummyUser1];
    
    [sessionsService storeInKeychainPassword:kSTIPoCDummyUser1Password forUser:user];
    NSString *retrievedPassword = [[SessionsService sharedInstance] retrieveFromKeychainPasswordForUser:user];
    
    XCTAssertTrue([kSTIPoCDummyUser1Password isEqualToString:retrievedPassword], @"Retrieved password should be the same as the one stored.");
    
    [SSKeychain deletePasswordForService:kSTIPoCServiceName account:[NSString stringWithFormat:@"%@/%@", user.customer.domainID, user.domainID]];
}

- (void)testSessionsServiceDeletesFromKeychainAllPasswordsForService
{
    User *user1 = [sessionsService dummyUser1];
    User *user2 = [sessionsService dummyUser2];
    
    [[SessionsService sharedInstance] storeInKeychainPassword:kSTIPoCDummyUser1Password forUser:user1];
    [[SessionsService sharedInstance] storeInKeychainPassword:kSTIPoCDummyUser2Password forUser:user2];
    
    [[SessionsService sharedInstance] deleteAllPasswords];
    
    NSString *retrievedPassword = [[SessionsService sharedInstance] retrieveFromKeychainPasswordForUser:user1];
    NSString *retrievedPassword2 = [[SessionsService sharedInstance] retrieveFromKeychainPasswordForUser:user2];
    
    XCTAssertFalse((retrievedPassword || retrievedPassword2), @"All passwords retrieved for service must be nil after deletion.");
}

#pragma mark -
#pragma mark Login

- (void)testSessionsServiceValidatesNilUserIDForLogin
{
    NSString *userID = nil;
    BOOL credentialsAreValid = [sessionsService loginWithUserID:userID customerID:[sessionsService dummyUser1].customer.domainID password:kSTIPoCDummyUser1Password remember:NO];
    
    XCTAssertFalse(credentialsAreValid, @"Nil user ID validation failed.");
}


- (void)testSessionsServiceValidatesEmptyUserIDForLogin
{
    NSString *userID = kSTIPoCTestsEmptyText;
    BOOL credentialsAreValid = [sessionsService loginWithUserID:userID customerID:[sessionsService dummyUser1].customer.domainID password:kSTIPoCDummyUser1Password remember:NO];
    
    XCTAssertFalse(credentialsAreValid, @"Empty user ID validation failed.");
}

- (void)testSessionsServiceValidatesWrongUserIDForLogin
{
    NSString *userID = kSTIPoCTestsWrongUserID;
    BOOL credentialsAreValid = [sessionsService loginWithUserID:userID customerID:[sessionsService dummyUser1].customer.domainID password:kSTIPoCDummyUser1Password remember:NO];
    
    XCTAssertFalse(credentialsAreValid, @"Wrong user ID validation failed.");
}

- (void)testSessionsServiceValidatesNilPasswordForLogin
{
    NSString *password = nil;
    BOOL credentialsAreValid = [sessionsService loginWithUserID:[sessionsService dummyUser1].domainID customerID:[sessionsService dummyUser1].customer.domainID password:password remember:NO];
    
    XCTAssertFalse(credentialsAreValid, @"Nil password validation failed.");
}

- (void)testSessionsServiceValidatesEmptyPasswordForLogin
{
    NSString *password = kSTIPoCTestsEmptyText;
    BOOL credentialsAreValid = [sessionsService loginWithUserID:[sessionsService dummyUser1].domainID customerID:[sessionsService dummyUser1].customer.domainID password:password remember:NO];
    
    XCTAssertFalse(credentialsAreValid, @"Empty password validation failed.");
}

- (void)testSessionsServiceValidatesWrongPasswordForLogin
{
    NSString *password = kSTIPoCTestsWrongPassword;
    BOOL credentialsAreValid = [sessionsService loginWithUserID:[sessionsService dummyUser1].domainID customerID:[sessionsService dummyUser1].customer.domainID password:password remember:NO];
    
    XCTAssertFalse(credentialsAreValid, @"Wrong password validation failed.");
}

- (void)testSessionsServiceValidatesNilDomainForLogin
{
    NSString *accountNumber = nil;
    BOOL credentialsAreValid = [sessionsService loginWithUserID:[sessionsService dummyUser1].domainID customerID:accountNumber password:kSTIPoCDummyUser1Password remember:NO];
    
    XCTAssertFalse(credentialsAreValid, @"Nil domain validation failed.");
}

- (void)testSessionsServiceValidatesEmptyDomainForLogin
{
    NSString *accountNumber = kSTIPoCTestsEmptyText;
    BOOL credentialsAreValid = [sessionsService loginWithUserID:[sessionsService dummyUser1].domainID customerID:accountNumber password:kSTIPoCDummyUser1Password remember:NO];
    
    XCTAssertFalse(credentialsAreValid, @"Empty domain validation failed.");
}

- (void)testSessionsServiceValidatesWrongAccountNumberForLogin
{
    NSString *accountNumber = kSTIPoCTestsWrongAccountNumber;
    BOOL credentialsAreValid = [sessionsService loginWithUserID:[sessionsService dummyUser1].domainID customerID:accountNumber password:kSTIPoCDummyUser1Password remember:NO];
    
    XCTAssertFalse(credentialsAreValid, @"Wrong domain validation failed.");
}

- (void)testSessionsServiceLoginsCorrectly
{
    BOOL credentialsAreValid = [sessionsService loginWithUserID:[sessionsService dummyUser1].domainID customerID:[sessionsService dummyUser1].customer.domainID password:kSTIPoCDummyUser1Password remember:NO];
    
    XCTAssertTrue(credentialsAreValid, @"Credentials validation failed.");
}

- (void)testSessionsServiceRemembersPassword
{
    [sessionsService loginWithUserID:[sessionsService dummyUser1].domainID customerID:[sessionsService dummyUser1].customer.domainID password:kSTIPoCDummyUser1Password remember:YES];
    
    NSString *retrievedPassword = [sessionsService retrieveFromKeychainPasswordForUser:[sessionsService dummyUser1]];
    
    XCTAssertTrue([retrievedPassword isEqualToString:kSTIPoCDummyUser1Password], @"Password should have been remembered.");
}

- (void)testSessionsServiceRemembersLoggedUser
{
    [sessionsService loginWithUserID:[sessionsService dummyUser1].domainID customerID:[sessionsService dummyUser1].customer.domainID password:kSTIPoCDummyUser1Password remember:YES];
    
    XCTAssertTrue([[sessionsService dummyUser1].domainID isEqualToString:[sessionsService lastUser].domainID], @"Last users' ID should match.");
}

- (void)testSessionsServiceRemembersOnlyLastLoggedUser
{
    [sessionsService loginWithUserID:[sessionsService dummyUser1].domainID customerID:[sessionsService dummyUser1].customer.domainID password:kSTIPoCDummyUser1Password remember:YES];
    [sessionsService loginWithUserID:[sessionsService dummyUser2].domainID customerID:[sessionsService dummyUser2].customer.domainID password:kSTIPoCDummyUser2Password remember:YES];
    
    XCTAssertTrue([[sessionsService dummyUser2].domainID isEqualToString:[sessionsService lastUser].domainID], @"Only last user should have been remembered.");
}

- (void)testSessionsServiceRemembersUserOnlyWhenRememberFlagIsOn
{
    [sessionsService setValue:[sessionsService dummyUser1] forKey:@"lastUser"];
    
    [sessionsService loginWithUserID:[sessionsService dummyUser1].domainID customerID:[sessionsService dummyUser1].customer.domainID password:kSTIPoCDummyUser1Password remember:NO];
    
    XCTAssertNil([sessionsService lastUser], @"Last user should not be remembered.");
}

- (void)testSessionsServiceRemembersCurrentUser
{
    [sessionsService loginWithUserID:[sessionsService dummyUser1].domainID customerID:[sessionsService dummyUser1].customer.domainID password:kSTIPoCDummyUser1Password remember:NO];
    
    XCTAssertTrue([[sessionsService dummyUser1].domainID isEqualToString:[sessionsService currentUser].domainID], @"Current users'ID should match.");
}

#pragma mark -
#pragma mark Logout

- (void)testSessionsServiceLogsOutUser
{
    [sessionsService loginWithUserID:[sessionsService dummyUser1].domainID customerID:[sessionsService dummyUser1].customer.domainID password:kSTIPoCDummyUser1Password remember:NO];
    
    [sessionsService logout];
    
    XCTAssertNil([sessionsService currentUser], @"Current user should be nil.");
}

- (void)testSessionsServiceStopsRememberingUserPasswordAfterLogout
{
    [sessionsService loginWithUserID:[sessionsService dummyUser1].domainID customerID:[sessionsService dummyUser1].customer.domainID password:kSTIPoCDummyUser1Password remember:YES];
    
    [sessionsService logout];
    
    NSString *retrievedPassword = [sessionsService retrieveFromKeychainPasswordForUser:[sessionsService dummyUser1]];
    
    XCTAssertNil(retrievedPassword, @"Retrieved password should be nil.");
}

@end
