//
//  QuoteLineItemCell.h
//  STIPoC
//
//  Created by Alex Gutierrez on 12/1/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PriceType.h"

@class QuoteLineItem;

@protocol QuoteLineItemCellDelegate <NSObject>

- (void)quoteLineItemQuantityChanged;

@end

@interface QuoteLineItemCell : UITableViewCell

@property (weak, nonatomic) id<QuoteLineItemCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIStepper *quantityStepper;

@property (strong, nonatomic) QuoteLineItem *quoteLineItem;

- (void)setupWithQuoteLineItem:(QuoteLineItem *)quoteLineItem withPriceType:(PriceType)priceType;

- (IBAction)quoteLineQuantityChanged:(UIStepper *)sender;

@end
