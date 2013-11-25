//
//  Order.h
//  STIPoC
//
//  Created by Administrator on 11/21/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderSummary : NSObject

@property (strong, nonatomic) NSString *OrderId;
@property (strong, nonatomic) NSString *OrderNumber;
@property (strong, nonatomic) NSString *Status;
@property (strong, nonatomic) NSString *OrderFriendlyId;
@property (strong, nonatomic) NSString *ProjectId;
@property (strong, nonatomic) NSString *ProjectStatus;
@property (strong, nonatomic) NSString *ProjectFriendlyId;
@property (strong, nonatomic) NSString *CreatedBy;

@end
