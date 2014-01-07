//
//  GridResultsViewController.h
//  STIPoC
//
//  Created by Arturo Gamarra on 2/01/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GenericViewController.h"

@interface GridResultsViewController : GenericViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *headerFields;

@end