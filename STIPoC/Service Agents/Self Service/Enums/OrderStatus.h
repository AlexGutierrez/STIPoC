//
//  StatusType.h
//  STIPoC
//
//  Created by Alex Gutierrez on 11/29/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

typedef enum {
    OrderStatusApproved,
    OrderStatusRejected,
    OrderStatusSubmitted,
    OrderStatusAssigned,
    OrderStatusInProgress,
    OrderStatusPartiallyCompleted,
    OrderStatusCompleted,
    OrderStatusUnderReview,
    OrderStatusEditedByTerremark,
    OrderStatusPendingApproval,
    OrderStatusEditedByCustomer
} OrderStatus;
