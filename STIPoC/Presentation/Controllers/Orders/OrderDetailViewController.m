//
//  OrderDetailViewController.m
//  STIPoC
//
//  Created by Administrator on 11/26/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderSummary.h"
#import "SelfServiceEnumTranslator.h"

#define PURCHASE_ITEMS_VIEW_DEFAULT_HEIGHT 406
#define PURCHASE_ITEMS_VIEW_EXPANDED_HEIGHT 471

static NSString *const kSTIPoCSegueEmbedOrderDetailTableViewController = @"OrdersDetailTableViewControllerEmbedSegue";

@interface OrderDetailViewController ()

@property (weak, nonatomic) OrderDetailTableViewController *orderDetailTableViewController;
@property (strong, nonatomic) OrderSummary *backupOrderSummary;

- (void)setLabelsText;
- (void)updateTotalLabel;

@end

@implementation OrderDetailViewController

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.customNavigationItem.title = self.selectedOrderSummary.OrderFriendlyId;
    BOOL rejectableOrder = !([SelfServiceEnumTranslator orderStatusFromString:self.selectedOrderSummary.Status] == OrderStatusRejected);
    
    self.rejectOrderButton.hidden = !rejectableOrder;
    
    if (!rejectableOrder) {
        [self.view removeConstraint:self.purchaseItemsVerticalSpaceConstraint];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.purchaseItemsView
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                             multiplier:0
                                                               constant:PURCHASE_ITEMS_VIEW_EXPANDED_HEIGHT]];
    }
    
    
    [self setLabelsText];
}

#pragma mark -
#pragma mark Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kSTIPoCSegueEmbedOrderDetailTableViewController]) {
        self.orderDetailTableViewController = (OrderDetailTableViewController *)segue.destinationViewController;
        self.orderDetailTableViewController.delegate = self;
        self.orderDetailTableViewController.selectedOrderSummary = self.backupOrderSummary;
    }
}

#pragma mark -
#pragma mark Custom Accessors

- (void)setSelectedOrderSummary:(OrderSummary *)selectedOrderSummary
{
    if (_selectedOrderSummary != selectedOrderSummary) {
        _selectedOrderSummary = selectedOrderSummary;
        
        self.backupOrderSummary = [_selectedOrderSummary copy];
    }
}

#pragma mark -
#pragma mark Private Methods

- (void)setLabelsText
{
    if (self.backupOrderSummary) {
        
        // Project number attributed text
        
        NSMutableAttributedString *projectNumberString = [[NSMutableAttributedString alloc] initWithString:@""];
        
        id temp = [[NSAttributedString alloc] initWithString:@"Project: "
                                                  attributes:@{NSFontAttributeName: [UIFont fontWithName:kSTIPoCFontHelveticaNeueLight
                                                                                                    size:17.0]}];
        [projectNumberString appendAttributedString:temp];
        
        temp = [[NSAttributedString alloc] initWithString:(self.backupOrderSummary.ProjectFriendlyId)? self.backupOrderSummary.ProjectFriendlyId : @"-"
                                               attributes:@{NSFontAttributeName: [UIFont fontWithName:kSTIPoCFontHelveticaNeueMedium
                                                                                                 size:17.0]}];
        
        [projectNumberString appendAttributedString:temp];
        
        self.projectNumberLabel.attributedText = projectNumberString;
        
        // Order status text
        
        self.orderStatusLabel.text = self.backupOrderSummary.Status;
        self.orderStatusLabel.textColor = ([self.backupOrderSummary.Status isEqualToString:kSTIPoCSelfServiceOrderStatusApproved])? [UIColor verizonGreen] : ([self.backupOrderSummary.Status isEqualToString:kSTIPoCSelfServiceOrderStatusRejected])? [UIColor verizonRed] : [UIColor verizonBlue];
        
        // Totals attributed text
        
        [self updateTotalLabel];
    }
}

- (void)updateTotalLabel
{
    NSMutableAttributedString *totalString = [[NSMutableAttributedString alloc] initWithString:@""];
    
    PriceType priceType = (PriceType)self.priceTypeSegmentedControl.selectedSegmentIndex;
    NSString *priceTypeString = [SelfServiceEnumTranslator stringFromPriceType:priceType];
    
    id temp = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ Total: ", priceTypeString]
                                              attributes:@{NSFontAttributeName: [UIFont fontWithName:kSTIPoCFontHelveticaNeueLight
                                                                                                size:17.0]}];
    [totalString appendAttributedString:temp];
    
    
    temp = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.2lf", [self.backupOrderSummary totalForPriceType:priceType]]
                                           attributes:@{NSFontAttributeName: [UIFont fontWithName:kSTIPoCFontHelveticaNeueMedium
                                                                                             size:17.0]}];
    
    [totalString appendAttributedString:temp];
    
    self.totalLabel.attributedText = totalString;
}

#pragma mark -
#pragma mark Order Details Table View Controller Protocols

- (void)quoteLineItemPricesUpdated
{
    [self updateTotalLabel];
}

- (void)quoteLineItemRemoved
{
    [self updateTotalLabel];
}

#pragma mark -
#pragma mark IBActions

- (IBAction)priceTypeFilterChanged:(UISegmentedControl *)sender
{
    [self.orderDetailTableViewController changeFilterWithPriceType:(PriceType)self.priceTypeSegmentedControl.selectedSegmentIndex];
    
    [self updateTotalLabel];
}

- (IBAction)dismissModal:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        if ([self.delegate respondsToSelector:@selector(orderDetailViewControllerWasDismissed)]) {
            [self.delegate orderDetailViewControllerWasDismissed];
        }
    }];
}

- (IBAction)saveOrder:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        if ([self.delegate respondsToSelector:@selector(orderDetailViewControllerModifiedOrder:)]) {
            [self.delegate orderDetailViewControllerModifiedOrder:self.backupOrderSummary];
        }
    }];
}

- (IBAction)rejectOrder:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        if ([self.delegate respondsToSelector:@selector(orderDetailViewControllerRejectedOrder:)]) {
            [self.delegate orderDetailViewControllerRejectedOrder:self.backupOrderSummary];
        }
    }];
}

@end
