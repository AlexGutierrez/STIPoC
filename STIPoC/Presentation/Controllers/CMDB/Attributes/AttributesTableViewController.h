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

@interface AttributesTableViewController : GenericViewController<UITableViewDataSource, UITableViewDelegate, SelectedAttributeCellDelegate, OrderPriorityPopoverViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) Domain *selectedDomain;
@property (strong, nonatomic) NSMutableArray *selectedAttributes;

@end
