//
//  OrdersExtensiveViewController.m
//  STIPoC
//
//  Created by Administrator on 11/26/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "OrdersExtensiveViewController.h"

@interface OrdersExtensiveViewController ()

@end

@implementation OrdersExtensiveViewController

#pragma mark -
#pragma mark ECTableView Protocols

- (UITableViewCell *)extensiveCellForRowIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = kSTIPoCOrderSummaryTableViewCellIdentifier;
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)heightForExtensiveCellAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)numberOfSections
{
    return 2;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UIView *)viewForContainerAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark -
#pragma mark Table View Protocols

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self extendCellAtIndexPath:indexPath];
}

@end
