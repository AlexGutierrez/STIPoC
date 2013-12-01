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

static NSString *const kSTIPoCSegueEmbedOrderDetailTableViewController = @"OrdersDetailTableViewControllerEmbedSegue";

@interface OrderDetailViewController ()

@property (weak, nonatomic) OrderDetailTableViewController *orderDetailTableViewController;

- (void)setLabelsText;

@end

@implementation OrderDetailViewController

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = self.selectedOrderSummary.OrderFriendlyId;
    
    [self setLabelsText];
}

#pragma mark -
#pragma mark Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kSTIPoCSegueEmbedOrderDetailTableViewController]) {
        self.orderDetailTableViewController = (OrderDetailTableViewController *)segue.destinationViewController;
        self.orderDetailTableViewController.delegate = self;
        self.orderDetailTableViewController.selectedOrderSummary = self.selectedOrderSummary;
    }
}

#pragma mark -
#pragma mark Private Methods

- (void)setLabelsText
{
    if (self.selectedOrderSummary) {
        
        // Project number attributed text
        
        NSMutableAttributedString *projectNumberString = [[NSMutableAttributedString alloc] initWithString:@""];
        
        id temp = [[NSAttributedString alloc] initWithString:@"Project: "
                                                  attributes:@{NSFontAttributeName: [UIFont fontWithName:kSTIPoCFontHelveticaNeueLight
                                                                                                    size:17.0]}];
        [projectNumberString appendAttributedString:temp];
        
        temp = [[NSAttributedString alloc] initWithString:(self.selectedOrderSummary.ProjectFriendlyId)? self.selectedOrderSummary.ProjectFriendlyId : @""
                                               attributes:@{NSFontAttributeName: [UIFont fontWithName:kSTIPoCFontHelveticaNeueMedium
                                                                                                 size:17.0]}];
        
        [projectNumberString appendAttributedString:temp];
        
        self.projectNumberLabel.attributedText = projectNumberString;
        
        // Order status text
        
        self.orderStatusLabel.text = self.selectedOrderSummary.Status;
        self.orderStatusLabel.textColor = ([self.selectedOrderSummary.Status isEqualToString:kSTIPoCSelfServiceOrderStatusApproved])? [UIColor verizonGreen] : ([self.selectedOrderSummary.Status isEqualToString:kSTIPoCSelfServiceOrderStatusRejected])? [UIColor verizonRed] : [UIColor verizonBlue];
        
        // Totals attributed text
        
        NSMutableAttributedString *totalString = [[NSMutableAttributedString alloc] initWithString:@""];
        
        PriceType priceType = (PriceType)self.priceTypeSegmentedControl.selectedSegmentIndex;
        NSString *priceTypeString = [SelfServiceEnumTranslator stringFromPriceType:priceType];
        
        temp = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ Total: ", priceTypeString]
                                               attributes:@{NSFontAttributeName: [UIFont fontWithName:kSTIPoCFontHelveticaNeueLight
                                                                                                    size:17.0]}];
        [totalString appendAttributedString:temp];
        
        
        temp = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.2lf", [self.selectedOrderSummary totalForPriceType:priceType]]
                                               attributes:@{NSFontAttributeName: [UIFont fontWithName:kSTIPoCFontHelveticaNeueMedium
                                                                                                 size:17.0]}];
        
        [totalString appendAttributedString:temp];
        
        self.totalLabel.attributedText = totalString;
    }
}

#pragma mark -
#pragma mark IBActions

- (IBAction)priceTypeFilterChanged:(UISegmentedControl *)sender
{
}

- (IBAction)dismissModal:(UIBarButtonItem *)sender
{
}

- (IBAction)saveOrder:(UIBarButtonItem *)sender
{
}

- (IBAction)rejectOrder:(UIButton *)sender
{
}

@end
