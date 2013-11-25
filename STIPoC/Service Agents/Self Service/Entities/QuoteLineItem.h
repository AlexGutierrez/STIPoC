//
//  QuoteLineItem.h
//  STIPoC
//
//  Created by Administrator on 11/21/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuoteLineItem : NSObject

@property (strong, nonatomic) NSNumber *Id;
@property (strong, nonatomic) NSString *LineItemId;
@property (strong, nonatomic) NSString *LineItemDescription;
@property (strong, nonatomic) NSNumber *UnitPriceNRC;
@property (strong, nonatomic) NSNumber *UnitPriceMRC;
@property (strong, nonatomic) NSNumber *Qty;
@property (strong, nonatomic) NSMutableArray *LineItemAttributes;

@end
