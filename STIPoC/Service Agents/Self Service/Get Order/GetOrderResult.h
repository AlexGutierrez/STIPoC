//
//  GetOrderResult.h
//  STIPoC
//
//  Created by Administrator on 11/22/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GenericSelfServiceResult.h"

@interface GetOrderResult : GenericSelfServiceResult

@property (strong, nonatomic) NSString *OrderId;
@property (strong, nonatomic) NSString *OrderNumber;
@property (strong, nonatomic) NSString *OrderFriendlyId;
@property (strong, nonatomic) NSString *ProjectId;
@property (strong, nonatomic) NSString *ProjectStatus;
@property (strong, nonatomic) NSString *QuoteLineItems;

@end
