//
//  AttributesMainViewController.h
//  STIPoC
//
//  Created by Alex Gutierrez on 12/18/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "GenericViewController.h"

@interface AttributesMainViewController : GenericViewController

@property (weak, nonatomic) IBOutlet UIView *domainsContainer;
@property (weak, nonatomic) IBOutlet UIButton *sideMenuCollapserButton;

- (IBAction)collapseSideMenus:(UIButton *)sender;
- (IBAction)toggleDomainsContainer:(UIBarButtonItem *)sender;

@end
