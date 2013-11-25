//
//  AppDelegate.m
//  STIPoC
//
//  Created by Administrator on 11/12/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "AppDelegate.h"
#import "GenericService.h"
#import "LoggingHelper.h"

#import "SelfServiceManager.h"
#import "OrderSummary.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[LoggingHelper sharedInstance] setupLogger];
    
#if (!defined(TEST))
    [[GenericService sharedInstance] setupCoreDataStack];
    [[GenericService sharedInstance] createDummyDataForProd];
#endif
    
    OrderSummary *orderSummary = [OrderSummary new];
    orderSummary.OrderId = @"727";
    [[SelfServiceManager sharedInstance] startGetOrderRequestOperationWithOrderSummary:orderSummary];
    
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[GenericService sharedInstance] cleanUpPersistenceChangesInMemory];
}

@end
