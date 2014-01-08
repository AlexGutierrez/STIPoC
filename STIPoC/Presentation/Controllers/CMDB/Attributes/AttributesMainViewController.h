//
//  AttributesMainViewController.h
//  STIPoC
//
//  Created by Alex Gutierrez on 12/18/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "GenericViewController.h"
#import "DomainsViewController.h"
#import "AttributesTableViewController.h"

@interface AttributesMainViewController : GenericViewController<DomainsViewControllerDelegate, AttributesTableViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *filtersContainer;
@property (weak, nonatomic) IBOutlet UIView *domainsContainer;
@property (weak, nonatomic) IBOutlet UIButton *sideMenuCollapserButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *domainsContainerTogglingButton;

- (IBAction)collapseSideMenus:(UIButton *)sender;
- (IBAction)toggleDomainsContainer:(UIBarButtonItem *)sender;

@end
