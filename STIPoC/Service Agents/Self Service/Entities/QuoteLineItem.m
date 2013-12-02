//
//  QuoteLineItem.m
//  STIPoC
//
//  Created by Administrator on 11/21/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "QuoteLineItem.h"

@implementation QuoteLineItem

#pragma mark -
#pragma mark Copying Protocols

- (id)copyWithZone:(NSZone *)zone
{
    QuoteLineItem *copy = [QuoteLineItem new];
    copy.Id = [self.Id copy];
    copy.LineItemId = [self.LineItemId copy];
    copy.LineItemDescription = [self.LineItemDescription copy];
    copy.UnitPriceNRC = [self.UnitPriceNRC copy];
    copy.UnitPriceMRC = [self.UnitPriceMRC copy];
    copy.Qty = [self.Qty copy];
    copy.LineItemAttributes = [[NSMutableArray alloc] initWithArray:self.LineItemAttributes copyItems:true];
    
    return copy;
}

@end
