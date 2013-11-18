//
//  LoginViewControllerTests.m
//  STIPoC
//
//  Created by Administrator on 11/18/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OCMock/OCMock.h"
#import "LoginViewController.h"



@interface LoginViewControllerTests : XCTestCase

@property (strong, nonatomic) LoginViewController *loginViewController;
@property (strong, nonatomic) id loginViewControllerMock;

@property (strong, nonatomic) UITextField *userIDField;
@property (strong, nonatomic) UITextField *passwordField;
@property (strong, nonatomic) UITextField *domainField;

@end

@implementation LoginViewControllerTests

- (void)setUp
{
    
    [super setUp];
}

- (void)tearDown
{

    [super tearDown];
}

- (void)testLoginPushesAnotherViewControllerCorrectly
{
}

@end
