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

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[LoggingHelper sharedInstance] setupLogger];
    [[GenericService sharedInstance] setupCoreDataStack];
    
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[GenericService sharedInstance] cleanUpPersistenceChangesInMemory];
}

@end
