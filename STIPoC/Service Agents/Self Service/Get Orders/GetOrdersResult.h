//
//  GetOrdersResult.h
//  STIPoC
//
//  Created by Administrator on 11/22/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GenericSelfServiceResult.h"

@interface GetOrdersResult : GenericSelfServiceResult

@property (strong, nonatomic) NSNumber *TotalCount;
@property (strong, nonatomic) NSArray *Orders;

@end
