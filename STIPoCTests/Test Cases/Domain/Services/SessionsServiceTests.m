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
    
    sessionsService = [SessionsService sharedService];
    [sessionsService setupCoreDataStackForTesting];
    [sessionsService createDummyData];
}

- (void)tearDown
{
    [sessionsService cleanUpPersistenceChangesInMemory];
    sessionsService = nil;
    
    [SSKeychain deletePasswordForService:kSTIPoCServiceName account:[NSString stringWithFormat:@"%@/%@", [sessionsService dummyUser1].customer.entityID, [sessionsService dummyUser1].entityID]];
    [SSKeychain deletePasswordForService:kSTIPoCServiceName account:[NSString stringWithFormat:@"%@/%@", [sessionsService dummyUser2].customer.entityID, [sessionsService dummyUser2].entityID]];
    
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
    SessionsService *sessionsService2 = [SessionsService sharedService];
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
    NSError *error = nil;
    
    [sessionsService loginWithUserID:[sessionsService dummyUser1].entityID customerID:[sessionsService dummyUser1].customer.entityID password:kSTIPoCDummyUser1Password remember:YES error:&error];
    
    User *currentUser = [sessionsService currentUser];
    User *currentUser2 = [User findFirstByAttribute:kSTIPoCEntityIDAttributeKey withValue:[[NSUserDefaults standardUserDefaults] objectForKey:kSTIPoCDefaultsCurrentUserKey]];
    XCTAssertEqualObjects(currentUser, currentUser2, @"User retrieved from the service must be equal to the one retrieved from the defaults");
}

- (void)testLastUserIsTheSameAsInDefaults
{
    NSError *error = nil;
    
    [sessionsService loginWithUserID:[sessionsService dummyUser1].entityID customerID:[sessionsService dummyUser1].customer.entityID password:kSTIPoCDummyUser1Password remember:YES error:&error];
    
    User *lastUser = [sessionsService lastUser];
    User *lastUser2 = [User findFirstByAttribute:kSTIPoCEntityIDAttributeKey withValue:[[NSUserDefaults standardUserDefaults] objectForKey:kSTIPoCDefaultsLastUserKey]];
    XCTAssertEqualObjects(lastUser, lastUser2, @"User retrieved from the service must be equal to the one retrieved from the defaults");
}

#pragma mark -
#pragma mark Keychain Storage

- (void)testSessionsServiceKeychainPasswordStorageAndRetrieval
{
    User *user = [sessionsService dummyUser1];
    
    [sessionsService storeInKeychainPassword:kSTIPoCDummyUser1Password forUser:user];
    NSString *retrievedPassword = [[SessionsService sharedService] retrieveFromKeychainPasswordForUser:user];
    
    XCTAssertTrue([kSTIPoCDummyUser1Password isEqualToString:retrievedPassword], @"Retrieved password should be the same as the one stored.");
    
    [SSKeychain deletePasswordForService:kSTIPoCServiceName account:[NSString stringWithFormat:@"%@/%@", user.customer.entityID, user.entityID]];
}

- (void)testSessionsServiceDeletesFromKeychainAllPasswordsForService
{
    User *user1 = [sessionsService dummyUser1];
    User *user2 = [sessionsService dummyUser2];
    
    [[SessionsService sharedService] storeInKeychainPassword:kSTIPoCDummyUser1Password forUser:user1];
    [[SessionsService sharedService] storeInKeychainPassword:kSTIPoCDummyUser2Password forUser:user2];
    
    [[SessionsService sharedService] deleteAllPasswords];
    
    NSString *retrievedPassword = [[SessionsService sharedService] retrieveFromKeychainPasswordForUser:user1];
    NSString *retrievedPassword2 = [[SessionsService sharedService] retrieveFromKeychainPasswordForUser:user2];
    
    XCTAssertFalse((retrievedPassword || retrievedPassword2), @"All passwords retrieved for service must be nil after deletion.");
}

#pragma mark -
#pragma mark Login

- (void)testSessionsServiceValidatesNilUserIDForLogin
{
    NSString *userID = nil;
    NSError *error = nil;
    
    BOOL credentialsAreValid = [sessionsService loginWithUserID:userID customerID:[sessionsService dummyUser1].customer.entityID password:kSTIPoCDummyUser1Password remember:NO error:&error];
    
    XCTAssertFalse(credentialsAreValid, @"Nil user ID validation failed.");
}


- (void)testSessionsServiceValidatesEmptyUserIDForLogin
{
    NSString *userID = kSTIPoCTestsEmptyText;
    NSError *error = nil;
    
    BOOL credentialsAreValid = [sessionsService loginWithUserID:userID customerID:[sessionsService dummyUser1].customer.entityID password:kSTIPoCDummyUser1Password remember:NO error:&error];
    
    XCTAssertFalse(credentialsAreValid, @"Empty user ID validation failed.");
}

- (void)testSessionsServiceValidatesWrongUserIDForLogin
{
    NSString *userID = kSTIPoCTestsWrongUserID;
    NSError *error = nil;
    
    BOOL credentialsAreValid = [sessionsService loginWithUserID:userID customerID:[sessionsService dummyUser1].customer.entityID password:kSTIPoCDummyUser1Password remember:NO error:&error];
    
    XCTAssertFalse(credentialsAreValid, @"Wrong user ID validation failed.");
}

- (void)testSessionsServiceValidatesNilPasswordForLogin
{
    NSString *password = nil;
    NSError *error = nil;
    
    BOOL credentialsAreValid = [sessionsService loginWithUserID:[sessionsService dummyUser1].entityID customerID:[sessionsService dummyUser1].customer.entityID password:password remember:NO error:&error];
    
    XCTAssertFalse(credentialsAreValid, @"Nil password validation failed.");
}

- (void)testSessionsServiceValidatesEmptyPasswordForLogin
{
    NSString *password = kSTIPoCTestsEmptyText;
    NSError *error = nil;
    
    BOOL credentialsAreValid = [sessionsService loginWithUserID:[sessionsService dummyUser1].entityID customerID:[sessionsService dummyUser1].customer.entityID password:password remember:NO error:&error];
    
    XCTAssertFalse(credentialsAreValid, @"Empty password validation failed.");
}

- (void)testSessionsServiceValidatesWrongPasswordForLogin
{
    NSString *password = kSTIPoCTestsWrongPassword;
    NSError *error = nil;
    
    BOOL credentialsAreValid = [sessionsService loginWithUserID:[sessionsService dummyUser1].entityID customerID:[sessionsService dummyUser1].customer.entityID password:password remember:NO error:&error];
    
    XCTAssertFalse(credentialsAreValid, @"Wrong password validation failed.");
}

- (void)testSessionsServiceValidatesNilDomainForLogin
{
    NSString *accountNumber = nil;
    NSError *error = nil;
    
    BOOL credentialsAreValid = [sessionsService loginWithUserID:[sessionsService dummyUser1].entityID customerID:accountNumber password:kSTIPoCDummyUser1Password remember:NO error:&error];
    
    XCTAssertFalse(credentialsAreValid, @"Nil domain validation failed.");
}

- (void)testSessionsServiceValidatesEmptyDomainForLogin
{
    NSString *accountNumber = kSTIPoCTestsEmptyText;
    NSError *error = nil;
    
    BOOL credentialsAreValid = [sessionsService loginWithUserID:[sessionsService dummyUser1].entityID customerID:accountNumber password:kSTIPoCDummyUser1Password remember:NO error:&error];
    
    XCTAssertFalse(credentialsAreValid, @"Empty domain validation failed.");
}

- (void)testSessionsServiceValidatesWrongAccountNumberForLogin
{
    NSString *accountNumber = kSTIPoCTestsWrongAccountNumber;
    NSError *error = nil;
    
    BOOL credentialsAreValid = [sessionsService loginWithUserID:[sessionsService dummyUser1].entityID customerID:accountNumber password:kSTIPoCDummyUser1Password remember:NO error:&error];
    
    XCTAssertFalse(credentialsAreValid, @"Wrong domain validation failed.");
}

- (void)testSessionsServiceLoginsCorrectly
{
    NSError *error = nil;
    
    BOOL credentialsAreValid = [sessionsService loginWithUserID:[sessionsService dummyUser1].entityID customerID:[sessionsService dummyUser1].customer.entityID password:kSTIPoCDummyUser1Password remember:NO error:&error];
    
    XCTAssertTrue(credentialsAreValid, @"Credentials validation failed.");
}

- (void)testSessionsServiceRemembersPassword
{
    NSError *error = nil;
    
    [sessionsService loginWithUserID:[sessionsService dummyUser1].entityID customerID:[sessionsService dummyUser1].customer.entityID password:kSTIPoCDummyUser1Password remember:YES error:&error];
    
    NSString *retrievedPassword = [sessionsService retrieveFromKeychainPasswordForUser:[sessionsService dummyUser1]];
    
    XCTAssertTrue([retrievedPassword isEqualToString:kSTIPoCDummyUser1Password], @"Password should have been remembered.");
}

- (void)testSessionsServiceRemembersLoggedUser
{
    NSError *error = nil;
    
    [sessionsService loginWithUserID:[sessionsService dummyUser1].entityID customerID:[sessionsService dummyUser1].customer.entityID password:kSTIPoCDummyUser1Password remember:YES error:&error];
    
    XCTAssertTrue([[sessionsService dummyUser1].entityID isEqualToString:[sessionsService lastUser].entityID], @"Last users' ID should match.");
}

- (void)testSessionsServiceRemembersOnlyLastLoggedUser
{
    NSError *error = nil;
    
    [sessionsService loginWithUserID:[sessionsService dummyUser1].entityID customerID:[sessionsService dummyUser1].customer.entityID password:kSTIPoCDummyUser1Password remember:YES error:&error];
    [sessionsService loginWithUserID:[sessionsService dummyUser2].entityID customerID:[sessionsService dummyUser2].customer.entityID password:kSTIPoCDummyUser2Password remember:YES error:&error];
    
    XCTAssertTrue([[sessionsService dummyUser2].entityID isEqualToString:[sessionsService lastUser].entityID], @"Only last user should have been remembered.");
}

- (void)testSessionsServiceRemembersUserOnlyWhenRememberFlagIsOn
{
    NSError *error = nil;
    
    [sessionsService setValue:[sessionsService dummyUser1] forKey:@"lastUser"];
    
    [sessionsService loginWithUserID:[sessionsService dummyUser1].entityID customerID:[sessionsService dummyUser1].customer.entityID password:kSTIPoCDummyUser1Password remember:NO error:&error];
    
    XCTAssertNil([sessionsService lastUser], @"Last user should not be remembered.");
}

- (void)testSessionsServiceRemembersCurrentUser
{
    NSError *error = nil;
    
    [sessionsService loginWithUserID:[sessionsService dummyUser1].entityID customerID:[sessionsService dummyUser1].customer.entityID password:kSTIPoCDummyUser1Password remember:NO error:&error];
    
    XCTAssertTrue([[sessionsService dummyUser1].entityID isEqualToString:[sessionsService currentUser].entityID], @"Current users'ID should match.");
}

#pragma mark -
#pragma mark Logout

- (void)testSessionsServiceLogsOutUser
{
    NSError *error = nil;
    
    [sessionsService loginWithUserID:[sessionsService dummyUser1].entityID customerID:[sessionsService dummyUser1].customer.entityID password:kSTIPoCDummyUser1Password remember:NO error:&error];
    
    [sessionsService logout];
    
    XCTAssertNil([sessionsService currentUser], @"Current user should be nil.");
}

- (void)testSessionsServiceStopsRememberingUserPasswordAfterLogout
{
    NSError *error = nil;
    
    [sessionsService loginWithUserID:[sessionsService dummyUser1].entityID customerID:[sessionsService dummyUser1].customer.entityID password:kSTIPoCDummyUser1Password remember:YES error:&error];
    
    [sessionsService logout];
    
    NSString *retrievedPassword = [sessionsService retrieveFromKeychainPasswordForUser:[sessionsService dummyUser1]];
    
    XCTAssertNil(retrievedPassword, @"Retrieved password should be nil.");
}

@end
