//
//  DomainsViewController.h
//  STIPoC
//
//  Created by Alex Gutierrez on 12/18/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "GenericViewController.h"

@class Domain;

@protocol DomainsViewControllerDelegate <NSObject>

- (void)domainsViewControllerDidSelectDomain:(Domain *)selectedDomain;

@end

@interface DomainsViewController : GenericViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) id<DomainsViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
