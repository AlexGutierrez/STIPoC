//
//  GenericFactory.h
//  STIPoC
//
//  Created by Administrator on 11/12/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "GenericFactory.h"

@interface AlertViewFactory : GenericFactory

- (UIAlertView *)createDefaultAlertView;
- (UIAlertView *)createAlertViewWithTitle:(NSString *)title andMessage:(NSString *)message;
- (UIAlertView *)createAlertViewWithError:(NSError *)error;
- (UIAlertView *)createOrderRejectionAlertViewWithDelegate:(id<UIAlertViewDelegate>)delegate;

@end
