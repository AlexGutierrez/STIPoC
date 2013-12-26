//
//  AttributesTableViewController.h
//  STIPoC
//
//  Created by Administrator on 12/23/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "GenericViewController.h"
#import "SelectedAttributeCell.h"

@class Domain;

@interface AttributesTableViewController : GenericViewController<UITableViewDataSource, UITableViewDelegate, SelectedAttributeCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) Domain *selectedDomain;

@end
