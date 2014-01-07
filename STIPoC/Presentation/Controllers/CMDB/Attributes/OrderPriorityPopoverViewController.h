//
//  OrderPriorityPopoverViewController.h
//  STIPoC
//
//  Created by Alex Gutierrez on 1/2/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "GenericViewController.h"

@class OrderPriorityPopoverViewController;
@class Attribute;

@protocol OrderPriorityPopoverViewControllerDelegate <NSObject>

- (void)orderPriorityPopoverViewController:(OrderPriorityPopoverViewController *)orderPriorityPopoverViewController didSelectNewPriority:(NSInteger)newOrderPriority;

@end

@interface OrderPriorityPopoverViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic) NSInteger maxPriority;
@property (strong, nonatomic) Attribute *popoverAttribute;

@property (weak, nonatomic) id<OrderPriorityPopoverViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UINavigationBar *customNavigationBar;

- (IBAction)doneButtonTapped:(UIBarButtonItem *)sender;

@end
