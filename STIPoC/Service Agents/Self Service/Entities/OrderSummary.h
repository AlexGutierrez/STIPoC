//
//  Order.h
//  STIPoC
//
//  Created by Administrator on 11/21/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PriceType.h"

@class GetOrderResult;

extern NSString *const kSTIPoCSelfServiceGenericUserId;
extern NSString *const kSTIPoCSelfServiceGenericUserName;
extern NSString *const kSTIPoCSelfServiceGenericModifiedBy;

@interface OrderSummary : NSObject <NSCopying>

@property (strong, nonatomic) NSString *OrderId;
@property (strong, nonatomic) NSString *OrderNumber;
@property (strong, nonatomic) NSString *Status;
@property (strong, nonatomic) NSString *OrderFriendlyId;
@property (strong, nonatomic) NSString *ProjectId;
@property (strong, nonatomic) NSString *ProjectStatus;
@property (strong, nonatomic) NSString *ProjectFriendlyId;
@property (strong, nonatomic) NSString *CreatedBy;
@property (strong, nonatomic) NSString *OrderExternalId;
@property (strong, nonatomic) NSMutableArray *QuoteLineItems;

- (double)totalForPriceType:(PriceType)priceType;

- (void)setAttributesWithGetOrderResult:(GetOrderResult *)result;
- (void)setAttributesWithOrderSummary:(OrderSummary *)orderSummary;


@end
