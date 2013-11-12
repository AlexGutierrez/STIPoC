//
//  LogHelper.h
//  STIPoC
//
//  Created by Administrator on 11/12/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoggingHelper : NSObject

+ (instancetype)sharedInstance;

- (void)setupLogger;

@end
