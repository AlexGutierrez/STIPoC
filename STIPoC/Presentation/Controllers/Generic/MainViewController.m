//
//  MainViewController.m
//  STIPoC
//
//  Created by Administrator on 11/28/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "MainViewController.h"
#import "ECZoomAnimationController.h"

@interface MainViewController ()

@property (strong, nonatomic) ECZoomAnimationController *zoomAnimationController;

@end

@implementation MainViewController

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    self.topViewAnchoredGesture = ECSlidingViewControllerAnchoredGestureTapping;
}

@end
