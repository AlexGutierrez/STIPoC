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

#import "SelfServiceRequestOperationManager.h"
#import "OrderSummary.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window.tintColor = [UIColor redColor];
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0xAC0404)];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : UIColorFromRGB(0xFFFFFF)}];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [[LoggingHelper sharedInstance] setupLogger];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        DDLogInfo(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
    }];
    
#if (!defined(TEST))
    [[GenericService sharedInstance] setupCoreDataStack];
    [[GenericService sharedInstance] createDummyDataForProd];
    
    return YES;
#else
    return NO;
#endif
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
    [[GenericService sharedInstance] cleanUpPersistenceChangesInMemory];
}

@end
