//
//  OrderDetailTableViewController.m
//  STIPoC
//
//  Created by Alex Gutierrez on 12/1/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "OrderDetailTableViewController.h"

#import "OrderSummary.h"
#import "QuoteLineItem.h"

@interface OrderDetailTableViewController ()

@property (nonatomic) PriceType priceType;

@end

static NSString *const kSTIPoCQuoteLineItemCellIdentifier = @"QuoteLineItemCell";
static NSString *const kSTIPoCOrderSummaryCellRejectText = @"Remove";

@implementation OrderDetailTableViewController

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.editing = YES;
}

#pragma mark - 
#pragma mak Table View Protocols

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuoteLineItem *quoteLineItem = self.selectedOrderSummary.QuoteLineItems[indexPath.row];
    
    NSString *string = quoteLineItem.LineItemDescription;
    
    CGSize descriptionSize = [string boundingRectWithSize:CGSizeMake(454.0f, 120.0f)
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{ NSFontAttributeName : [UIFont fontWithName:kSTIPoCFontHelveticaNeueLight size:17.0f]}
                                                  context:nil].size;
    
    NSLog(@"SIZE: %.2lf, %.2lf", descriptionSize.width, descriptionSize.height);
    
    return 105;
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.selectedOrderSummary.QuoteLineItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSTIPoCQuoteLineItemCellIdentifier forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuoteLineItem *quoteLineItem = self.selectedOrderSummary.QuoteLineItems[indexPath.row];
    QuoteLineItemCell *quoteLineItemCell = (QuoteLineItemCell *)cell;
    quoteLineItemCell.delegate = self;
    
    [quoteLineItemCell setupWithQuoteLineItem:quoteLineItem withPriceType:self.priceType];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NSLocalizedString(kSTIPoCOrderSummaryCellRejectText, nil);
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.selectedOrderSummary.QuoteLineItems removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        if ([self.delegate respondsToSelector:@selector(quoteLineItemRemoved)]) {
            [self.delegate quoteLineItemRemoved];
        }
    }
}

#pragma mark -
#pragma mark Quote Line Item Cell Protocols

- (void)quoteLineItemQuantityChanged
{
    if ([self.delegate respondsToSelector:@selector(quoteLineItemPricesUpdated)]) {
        [self.delegate quoteLineItemPricesUpdated];
    }
}

#pragma mark -
#pragma mark Public Methods

- (void)changeFilterWithPriceType:(PriceType)priceType
{
    self.priceType = priceType;
    [self.tableView reloadData];
}

@end
