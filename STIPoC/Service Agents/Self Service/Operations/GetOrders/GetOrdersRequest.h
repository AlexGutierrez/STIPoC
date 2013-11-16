//
//  GetOrdersRequest.h
//  STIPoC
//
//  Created by Administrator on 11/15/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomerIdTypeEnum.h"
@interface GetOrdersRequest : NSObject
{
	
    /* elements */
	NSString * CustomerId;
	CustomerIdTypeEnum CustomerIdType;
	NSString * OrderNumber;
	NSNumber * PageSize;
	NSNumber * PageNumber;
	NSString * OrderingFieldName;
	SelfService_OrderingTypeEnum OrderingType;
	NSString * SourceSystem;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_GetOrdersRequest *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * CustomerId;
@property (assign) SelfService_CustomerIdTypeEnum CustomerIdType;
@property (retain) NSString * OrderNumber;
@property (retain) NSNumber * PageSize;
@property (retain) NSNumber * PageNumber;
@property (retain) NSString * OrderingFieldName;
@property (assign) SelfService_OrderingTypeEnum OrderingType;
@property (retain) NSString * SourceSystem;
/* attributes */
- (NSDictionary *)attributes;

@end
