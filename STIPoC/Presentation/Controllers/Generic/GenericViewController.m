//
//  GenericViewController.m
//  STIPoC
//
//  Created by Administrator on 11/12/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "GenericViewController.h"

@interface GenericViewController ()

@end

@implementation GenericViewController

#pragma mark -
#pragma mark View Lifecycle

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    DDLogWarn(@"Memory Warning Detected! - %@", [self class]);
}

#pragma mark -
#pragma mark Public Methods

- (void)showOverlayWithMessage:(NSString *)message
{
    [MRProgressOverlayView showOverlayAddedTo:self.navigationController.view
                                        title:message
                                         mode:MRProgressOverlayViewModeIndeterminateSmall
                                     animated:YES];
}

- (void)dismissOverlay
{
    [MRProgressOverlayView dismissAllOverlaysForView:self.navigationController.view animated:YES];
}

@end
