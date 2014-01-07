//
//  AttributesTableViewController.h
//  STIPoC
//
//  Created by Administrator on 12/23/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "GenericViewController.h"
#import "SelectedAttributeCell.h"
#import "OrderPriorityPopoverViewController.h"

@class Domain;

@protocol AttributesTableViewControllerDelegate <NSObject>

- (void)attributesTableViewControllerDidRequestFilterChangeForAttribute:(Attribute *)attribute;

@end

@interface AttributesTableViewController : GenericViewController<UITableViewDataSource, UITableViewDelegate, SelectedAttributeCellDelegate, OrderPriorityPopoverViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) id<AttributesTableViewControllerDelegate> delegate;

@property (strong, nonatomic) Domain *selectedDomain;

@end
