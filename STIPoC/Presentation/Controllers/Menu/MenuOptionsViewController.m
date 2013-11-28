//
//  MenuTableViewController.m
//  STIPoC
//
//  Created by Administrator on 11/28/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "MenuOptionsViewController.h"

@interface MenuOptionsViewController ()

@end

@implementation MenuOptionsViewController

#pragma mark -
#pragma mark Table View Protocols

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(menuOptionsViewControllerDidSelectOption:)]) {
        [self.delegate menuOptionsViewControllerDidSelectOption:(MenuOption)indexPath.row];
    }
}

@end
