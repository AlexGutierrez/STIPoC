//
//  QuoteLineItemCell.m
//  STIPoC
//
//  Created by Alex Gutierrez on 12/1/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "QuoteLineItemCell.h"
#import "QuoteLineItem.h"
#import "SelfServiceEnumTranslator.h"

@interface QuoteLineItemCell ()

@property (nonatomic) PriceType priceType;

- (void)updateQuantityAndPriceLabels;

@end

@implementation QuoteLineItemCell

#pragma mark -
#pragma mark Public Methods

- (void)setupWithQuoteLineItem:(QuoteLineItem *)quoteLineItem withPriceType:(PriceType)priceType
{
    self.priceType = priceType;
    self.quoteLineItem = quoteLineItem;
        
    self.descriptionLabel.text = quoteLineItem.LineItemDescription;
    self.quantityStepper.value = quoteLineItem.Qty.integerValue;
    
    [self updateQuantityAndPriceLabels];
}

#pragma mark -
#pragma mark IBActions

- (IBAction)quoteLineQuantityChanged:(UIStepper *)sender
{
    self.quoteLineItem.Qty = @(sender.value);
    
    [self updateQuantityAndPriceLabels];
    
    if ([self.delegate respondsToSelector:@selector(quoteLineItemQuantityChanged)]) {
        [self.delegate quoteLineItemQuantityChanged];
    }
}

#pragma mark -
#pragma mark Private Methods

- (void)updateQuantityAndPriceLabels
{
    // Price attributed text
    
    NSMutableAttributedString *priceString = [[NSMutableAttributedString alloc] initWithString:@""];
    
    NSString *priceTypeString = [SelfServiceEnumTranslator stringFromPriceType:self.priceType];
    
    id temp = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@: ", priceTypeString]
                                              attributes:@{NSFontAttributeName: [UIFont fontWithName:kSTIPoCFontHelveticaNeueLight
                                                                                                size:16.0]}];
    [priceString appendAttributedString:temp];
    
    double quoteLineItemPrice = self.quoteLineItem.Qty.doubleValue * ((self.priceType == PriceTypeNRC)? self.quoteLineItem.UnitPriceNRC.doubleValue : self.quoteLineItem.UnitPriceMRC.doubleValue);
    
    temp = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.2lf", quoteLineItemPrice]
                                           attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16.0]}];
    
    [priceString appendAttributedString:temp];
    
    self.priceLabel.attributedText = priceString;
    
    // Quantity attributed text
    
    NSMutableAttributedString *qtyString = [[NSMutableAttributedString alloc] initWithString:@""];
    
    temp = [[NSAttributedString alloc] initWithString:@"Qty: "
                                           attributes:@{NSFontAttributeName: [UIFont fontWithName:kSTIPoCFontHelveticaNeueLight
                                                                                             size:16.0]}];
    [qtyString appendAttributedString:temp];
    
    temp = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.2lf", self.quoteLineItem.Qty.doubleValue]
                                           attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16.0]}];
    
    [qtyString appendAttributedString:temp];
    
    self.quantityLabel.attributedText = qtyString;
}

@end
