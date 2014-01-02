//
//  OrderPriorityPopoverViewController.m
//  STIPoC
//
//  Created by Alex Gutierrez on 1/2/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "OrderPriorityPopoverViewController.h"
#import "Attribute.h"

@interface OrderPriorityPopoverViewController ()

@end

@implementation OrderPriorityPopoverViewController

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.customNavigationBar setBarTintColor:[UIColor verizonGrey]];
    self.customNavigationBar.titleTextAttributes = @{ NSForegroundColorAttributeName : [UIColor verizonBlack] };
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.pickerView selectRow:self.popoverAttribute.orderPriority.integerValue - 1 inComponent:0 animated:YES];
}

#pragma mark -
#pragma mark Picker View Controller

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.maxPriority;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%i", row + 1];
}

#pragma mark -
#pragma mark IBOutlets

- (IBAction)doneButtonTapped:(UIBarButtonItem *)sender
{
    if ([self.delegate respondsToSelector:@selector(orderPriorityPopoverViewController:didSelectNewPriority:)]) {
        [self.delegate orderPriorityPopoverViewController:self didSelectNewPriority:[self.pickerView selectedRowInComponent:0] + 1];
    }
}

@end
