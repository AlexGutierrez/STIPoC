//
//  GenericFactory.h
//  STIPoC
//
//  Created by Administrator on 11/12/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertViewFactory : NSObject

+ (instancetype)sharedInstance;

- (UIAlertView *)createLoginDefaultAlertView;
- (UIAlertView *)createAlertViewWithTitle:(NSString *)title andMessage:(NSString *)message;

@end
