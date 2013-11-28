//
//  MenuTableViewController.h
//  STIPoC
//
//  Created by Administrator on 11/28/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    MenuOptionOrderStatus,
    MenuOptionProjectTracking,
    MenuOptionSettings,
    MenuOptionLogout
} MenuOption;

@protocol MenuOptionsViewControllerDelegate <NSObject>

- (void)menuOptionsViewControllerDidSelectOption:(MenuOption)menuOption;

@end

@interface MenuOptionsViewController : UITableViewController

@property (weak, nonatomic) id<MenuOptionsViewControllerDelegate> delegate;

@end
