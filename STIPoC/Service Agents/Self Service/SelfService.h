#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class SelfService_CreateOrder;
@class SelfService_CreateOrderRequest;
@class SelfService_Contact;
@class SelfService_ArrayOfQuoteDetail;
@class SelfService_QuoteDetail;
@class SelfService_ArrayOfLocation;
@class SelfService_Location;
@class SelfService_ArrayOfQuoteLineItem;
@class SelfService_QuoteLineItem;
@class SelfService_ArrayOfLineItemAttribute;
@class SelfService_LineItemAttribute;
@class SelfService_CreateOrderResponse;
@class SelfService_CreateOrderResult;
@class SelfService_UpdateOrder;
@class SelfService_UpdateOrderRequest;
@class SelfService_UpdateOrderResponse;
@class SelfService_UpdateOrderResult;
@class SelfService_UpdateOrderStatus;
@class SelfService_UpdateOrderStatusRequest;
@class SelfService_UpdateOrderStatusResponse;
@class SelfService_UpdateOrderStatusResult;
@class SelfService_AddOrderAttachment;
@class SelfService_AddOrderAttachmentRequest;
@class SelfService_AddOrderAttachmentResponse;
@class SelfService_AddOrderAttachmentResult;
@class SelfService_GetOrders;
@class SelfService_GetOrdersRequest;
@class SelfService_GetOrdersResponse;
@class SelfService_GetOrdersResult;
@class SelfService_ArrayOfOrderSummary;
@class SelfService_OrderSummary;
@class SelfService_GetOrder;
@class SelfService_GetOrderRequest;
@class SelfService_GetOrderResponse;
@class SelfService_GetOrderResult;
@class SelfService_ModifyOrderDetails;
@class SelfService_ModifyOrderDetailsRequest;
@class SelfService_ModifyOrderDetailsResponse;
@class SelfService_ModifyOrderDetailsResult;
@class SelfService_GetPortList;
@class SelfService_GetPortListRequest;
@class SelfService_GetPortListResponse;
@class SelfService_GetPortListResult;
@class SelfService_ArrayOfPort;
@class SelfService_Port;
@class SelfService_GetPanelTypeList;
@class SelfService_GetPanelTypeListRequest;
@class SelfService_GetPanelTypeListResponse;
@class SelfService_GetPanelTypeListResult;
@class SelfService_ArrayOfPanelType;
@class SelfService_PanelType;
@class SelfService_ArrayOfString;
@class SelfService_GetInterconnectsByCustomer;
@class SelfService_GetInterconnectsByCustomerRequest;
@class SelfService_GetInterconnectsByCustomerResponse;
@class SelfService_GetInterconnectsByCustomerResult;
@class SelfService_ArrayOfInterconnect;
@class SelfService_Interconnect;
@class SelfService_GetIFCsByCustomer;
@class SelfService_GetIFCsByCustomerRequest;
@class SelfService_GetIFCsByCustomerResponse;
@class SelfService_GetIFCsByCustomerResult;
@class SelfService_ArrayOfIFC;
@class SelfService_IFC;
@class SelfService_GetGridLocationsByCustomer;
@class SelfService_GetGridLocationsByCustomerRequest;
@class SelfService_GetGridLocationsByCustomerResponse;
@class SelfService_GetGridLocationsByCustomerResult;
@class SelfService_ArrayOfGridLocation;
@class SelfService_GridLocation;
typedef enum {
	SelfService_CustomerIdTypeEnum_none = 0,
	SelfService_CustomerIdTypeEnum_AccountNumber,
	SelfService_CustomerIdTypeEnum_InstanceId,
	SelfService_CustomerIdTypeEnum_NSAP,
	SelfService_CustomerIdTypeEnum_BillingID,
} SelfService_CustomerIdTypeEnum;
SelfService_CustomerIdTypeEnum SelfService_CustomerIdTypeEnum_enumFromString(NSString *string);
NSString * SelfService_CustomerIdTypeEnum_stringFromEnum(SelfService_CustomerIdTypeEnum enumValue);
@interface SelfService_Contact : NSObject {
	
/* elements */
	NSString * Name;
	NSString * LastName;
	NSString * Email;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_Contact *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * Name;
@property (retain) NSString * LastName;
@property (retain) NSString * Email;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_LineItemAttribute : NSObject {
	
/* elements */
	NSString * Name;
	NSString * Value;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_LineItemAttribute *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * Name;
@property (retain) NSString * Value;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_ArrayOfLineItemAttribute : NSObject {
	
/* elements */
	NSMutableArray *LineItemAttribute;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_ArrayOfLineItemAttribute *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addLineItemAttribute:(SelfService_LineItemAttribute *)toAdd;
@property (readonly) NSMutableArray * LineItemAttribute;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_QuoteLineItem : NSObject {
	
/* elements */
	NSNumber * Id_;
	NSString * LineItemId;
	NSString * LineItemDescription;
	NSNumber * UnitPriceNRC;
	NSNumber * UnitPriceMRC;
	NSNumber * Qty;
	SelfService_ArrayOfLineItemAttribute * LineItemAttributes;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_QuoteLineItem *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * Id_;
@property (retain) NSString * LineItemId;
@property (retain) NSString * LineItemDescription;
@property (retain) NSNumber * UnitPriceNRC;
@property (retain) NSNumber * UnitPriceMRC;
@property (retain) NSNumber * Qty;
@property (retain) SelfService_ArrayOfLineItemAttribute * LineItemAttributes;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_ArrayOfQuoteLineItem : NSObject {
	
/* elements */
	NSMutableArray *QuoteLineItem;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_ArrayOfQuoteLineItem *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addQuoteLineItem:(SelfService_QuoteLineItem *)toAdd;
@property (readonly) NSMutableArray * QuoteLineItem;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_Location : NSObject {
	
/* elements */
	NSString * LocationId;
	NSString * LineOfBusiness;
	SelfService_ArrayOfQuoteLineItem * QuoteLineItems;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_Location *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * LocationId;
@property (retain) NSString * LineOfBusiness;
@property (retain) SelfService_ArrayOfQuoteLineItem * QuoteLineItems;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_ArrayOfLocation : NSObject {
	
/* elements */
	NSMutableArray *Location;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_ArrayOfLocation *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addLocation:(SelfService_Location *)toAdd;
@property (readonly) NSMutableArray * Location;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_QuoteDetail : NSObject {
	
/* elements */
	SelfService_ArrayOfLocation * Locations;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_QuoteDetail *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) SelfService_ArrayOfLocation * Locations;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_ArrayOfQuoteDetail : NSObject {
	
/* elements */
	NSMutableArray *QuoteDetail;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_ArrayOfQuoteDetail *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addQuoteDetail:(SelfService_QuoteDetail *)toAdd;
@property (readonly) NSMutableArray * QuoteDetail;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_CreateOrderRequest : NSObject {
	
/* elements */
	NSString * SourceSystem;
	NSNumber * ExternalId;
	NSString * CustomerId;
	SelfService_CustomerIdTypeEnum CustomerIdType;
	NSString * QuoteNumber;
	NSString * QuoteDescription;
	NSNumber * QuoteTermInMonths;
	NSString * QuoteCurrency;
	NSString * ContractNumber;
	NSString * ContractName;
	NSString * ContractSignatureDate;
	USBoolean * Expedite;
	NSNumber * ImplementationTimelineDays;
	SelfService_Contact * SalesCSRep;
	SelfService_Contact * SalesEngineer;
	SelfService_Contact * ShipTo;
	SelfService_Contact * ImplementationContact;
	SelfService_ArrayOfQuoteDetail * QuoteDetails;
	NSString * CreatedBy;
	NSString * UserName;
	NSString * UserId;
	NSString * CustomerReference;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_CreateOrderRequest *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * SourceSystem;
@property (retain) NSNumber * ExternalId;
@property (retain) NSString * CustomerId;
@property (assign) SelfService_CustomerIdTypeEnum CustomerIdType;
@property (retain) NSString * QuoteNumber;
@property (retain) NSString * QuoteDescription;
@property (retain) NSNumber * QuoteTermInMonths;
@property (retain) NSString * QuoteCurrency;
@property (retain) NSString * ContractNumber;
@property (retain) NSString * ContractName;
@property (retain) NSString * ContractSignatureDate;
@property (retain) USBoolean * Expedite;
@property (retain) NSNumber * ImplementationTimelineDays;
@property (retain) SelfService_Contact * SalesCSRep;
@property (retain) SelfService_Contact * SalesEngineer;
@property (retain) SelfService_Contact * ShipTo;
@property (retain) SelfService_Contact * ImplementationContact;
@property (retain) SelfService_ArrayOfQuoteDetail * QuoteDetails;
@property (retain) NSString * CreatedBy;
@property (retain) NSString * UserName;
@property (retain) NSString * UserId;
@property (retain) NSString * CustomerReference;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_CreateOrder : NSObject {
	
/* elements */
	SelfService_CreateOrderRequest * quoteOrderRequest;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_CreateOrder *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) SelfService_CreateOrderRequest * quoteOrderRequest;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_CreateOrderResult : NSObject {
	
/* elements */
	NSNumber * OrderId;
	NSString * ResponseCode;
	NSString * ResponseMessage;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_CreateOrderResult *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * OrderId;
@property (retain) NSString * ResponseCode;
@property (retain) NSString * ResponseMessage;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_CreateOrderResponse : NSObject {
	
/* elements */
	SelfService_CreateOrderResult * CreateOrderResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_CreateOrderResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) SelfService_CreateOrderResult * CreateOrderResult;
/* attributes */
- (NSDictionary *)attributes;
@end
typedef enum {
	SelfService_OrderIdTypeEnum_none = 0,
	SelfService_OrderIdTypeEnum_OrderId,
	SelfService_OrderIdTypeEnum_ProjectId,
	SelfService_OrderIdTypeEnum_FriendlyOrderId,
} SelfService_OrderIdTypeEnum;
SelfService_OrderIdTypeEnum SelfService_OrderIdTypeEnum_enumFromString(NSString *string);
NSString * SelfService_OrderIdTypeEnum_stringFromEnum(SelfService_OrderIdTypeEnum enumValue);
@interface SelfService_UpdateOrderRequest : NSObject {
	
/* elements */
	NSString * SourceSystem;
	NSString * OrderId;
	SelfService_OrderIdTypeEnum OrderIdType;
	NSString * CustomerId;
	SelfService_CustomerIdTypeEnum CustomerIdType;
	NSString * QuoteNumber;
	NSString * QuoteDescription;
	NSNumber * QuoteTermInMonths;
	NSString * QuoteCurrency;
	NSString * ContractNumber;
	NSString * ContractName;
	NSString * ContractSignatureDate;
	USBoolean * Expedite;
	NSNumber * ImplementationTimelineDays;
	SelfService_Contact * SalesCSRep;
	SelfService_Contact * SalesEngineer;
	SelfService_Contact * ShipTo;
	SelfService_Contact * ImplementationContact;
	SelfService_ArrayOfQuoteDetail * QuoteDetails;
	NSString * Status;
	NSString * ModifiedBy;
	NSString * Comments;
	NSString * UserName;
	NSString * UserId;
	NSString * CustomerReference;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_UpdateOrderRequest *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * SourceSystem;
@property (retain) NSString * OrderId;
@property (assign) SelfService_OrderIdTypeEnum OrderIdType;
@property (retain) NSString * CustomerId;
@property (assign) SelfService_CustomerIdTypeEnum CustomerIdType;
@property (retain) NSString * QuoteNumber;
@property (retain) NSString * QuoteDescription;
@property (retain) NSNumber * QuoteTermInMonths;
@property (retain) NSString * QuoteCurrency;
@property (retain) NSString * ContractNumber;
@property (retain) NSString * ContractName;
@property (retain) NSString * ContractSignatureDate;
@property (retain) USBoolean * Expedite;
@property (retain) NSNumber * ImplementationTimelineDays;
@property (retain) SelfService_Contact * SalesCSRep;
@property (retain) SelfService_Contact * SalesEngineer;
@property (retain) SelfService_Contact * ShipTo;
@property (retain) SelfService_Contact * ImplementationContact;
@property (retain) SelfService_ArrayOfQuoteDetail * QuoteDetails;
@property (retain) NSString * Status;
@property (retain) NSString * ModifiedBy;
@property (retain) NSString * Comments;
@property (retain) NSString * UserName;
@property (retain) NSString * UserId;
@property (retain) NSString * CustomerReference;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_UpdateOrder : NSObject {
	
/* elements */
	SelfService_UpdateOrderRequest * quoteOrderRequest;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_UpdateOrder *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) SelfService_UpdateOrderRequest * quoteOrderRequest;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_UpdateOrderResult : NSObject {
	
/* elements */
	NSNumber * OrderId;
	NSString * ResponseCode;
	NSString * ResponseMessage;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_UpdateOrderResult *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * OrderId;
@property (retain) NSString * ResponseCode;
@property (retain) NSString * ResponseMessage;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_UpdateOrderResponse : NSObject {
	
/* elements */
	SelfService_UpdateOrderResult * UpdateOrderResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_UpdateOrderResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) SelfService_UpdateOrderResult * UpdateOrderResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_UpdateOrderStatusRequest : NSObject {
	
/* elements */
	NSString * SourceSystem;
	NSString * OrderId;
	SelfService_OrderIdTypeEnum OrderIdType;
	NSString * OrderStatus;
	NSString * Comments;
	NSString * ModifiedBy;
	NSString * UserName;
	NSString * UserId;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_UpdateOrderStatusRequest *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * SourceSystem;
@property (retain) NSString * OrderId;
@property (assign) SelfService_OrderIdTypeEnum OrderIdType;
@property (retain) NSString * OrderStatus;
@property (retain) NSString * Comments;
@property (retain) NSString * ModifiedBy;
@property (retain) NSString * UserName;
@property (retain) NSString * UserId;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_UpdateOrderStatus : NSObject {
	
/* elements */
	SelfService_UpdateOrderStatusRequest * quoteOrderRequest;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_UpdateOrderStatus *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) SelfService_UpdateOrderStatusRequest * quoteOrderRequest;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_UpdateOrderStatusResult : NSObject {
	
/* elements */
	NSString * ResponseCode;
	NSString * ResponseMessage;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_UpdateOrderStatusResult *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * ResponseCode;
@property (retain) NSString * ResponseMessage;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_UpdateOrderStatusResponse : NSObject {
	
/* elements */
	SelfService_UpdateOrderStatusResult * UpdateOrderStatusResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_UpdateOrderStatusResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) SelfService_UpdateOrderStatusResult * UpdateOrderStatusResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_AddOrderAttachmentRequest : NSObject {
	
/* elements */
	NSString * OrderId;
	SelfService_OrderIdTypeEnum OrderIdType;
	NSData * FileContent;
	NSString * ModifiedBy;
	NSString * UserName;
	NSString * UserId;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_AddOrderAttachmentRequest *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * OrderId;
@property (assign) SelfService_OrderIdTypeEnum OrderIdType;
@property (retain) NSData * FileContent;
@property (retain) NSString * ModifiedBy;
@property (retain) NSString * UserName;
@property (retain) NSString * UserId;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_AddOrderAttachment : NSObject {
	
/* elements */
	SelfService_AddOrderAttachmentRequest * addOrderAttachmentRequest;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_AddOrderAttachment *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) SelfService_AddOrderAttachmentRequest * addOrderAttachmentRequest;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_AddOrderAttachmentResult : NSObject {
	
/* elements */
	NSString * ResponseCode;
	NSString * ResponseMessage;
	NSString * AttachmentId;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_AddOrderAttachmentResult *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * ResponseCode;
@property (retain) NSString * ResponseMessage;
@property (retain) NSString * AttachmentId;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_AddOrderAttachmentResponse : NSObject {
	
/* elements */
	SelfService_AddOrderAttachmentResult * AddOrderAttachmentResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_AddOrderAttachmentResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) SelfService_AddOrderAttachmentResult * AddOrderAttachmentResult;
/* attributes */
- (NSDictionary *)attributes;
@end
typedef enum {
	SelfService_OrderingTypeEnum_none = 0,
	SelfService_OrderingTypeEnum_Asc,
	SelfService_OrderingTypeEnum_Desc,
} SelfService_OrderingTypeEnum;
SelfService_OrderingTypeEnum SelfService_OrderingTypeEnum_enumFromString(NSString *string);
NSString * SelfService_OrderingTypeEnum_stringFromEnum(SelfService_OrderingTypeEnum enumValue);
@interface SelfService_GetOrdersRequest : NSObject {
	
/* elements */
	NSString * CustomerId;
	SelfService_CustomerIdTypeEnum CustomerIdType;
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
@interface SelfService_GetOrders : NSObject {
	
/* elements */
	SelfService_GetOrdersRequest * getOrdersRequest;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_GetOrders *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) SelfService_GetOrdersRequest * getOrdersRequest;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_OrderSummary : NSObject {
	
/* elements */
	NSString * OrderId;
	NSString * OrderNumber;
	NSString * OrderFriendlyId;
	NSString * ProjectID;
	NSString * ProjectStatus;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_OrderSummary *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * OrderId;
@property (retain) NSString * OrderNumber;
@property (retain) NSString * OrderFriendlyId;
@property (retain) NSString * ProjectID;
@property (retain) NSString * ProjectStatus;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_ArrayOfOrderSummary : NSObject {
	
/* elements */
	NSMutableArray *OrderSummary;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_ArrayOfOrderSummary *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addOrderSummary:(SelfService_OrderSummary *)toAdd;
@property (readonly) NSMutableArray * OrderSummary;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_GetOrdersResult : NSObject {
	
/* elements */
	NSNumber * TotalCount;
	SelfService_ArrayOfOrderSummary * Orders;
	NSString * ResponseCode;
	NSString * ResponseMessage;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_GetOrdersResult *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * TotalCount;
@property (retain) SelfService_ArrayOfOrderSummary * Orders;
@property (retain) NSString * ResponseCode;
@property (retain) NSString * ResponseMessage;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_GetOrdersResponse : NSObject {
	
/* elements */
	SelfService_GetOrdersResult * GetOrdersResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_GetOrdersResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) SelfService_GetOrdersResult * GetOrdersResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_GetOrderRequest : NSObject {
	
/* elements */
	NSString * OrderId;
	SelfService_OrderIdTypeEnum OrderIdType;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_GetOrderRequest *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * OrderId;
@property (assign) SelfService_OrderIdTypeEnum OrderIdType;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_GetOrder : NSObject {
	
/* elements */
	SelfService_GetOrderRequest * getOrderRequest;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_GetOrder *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) SelfService_GetOrderRequest * getOrderRequest;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_GetOrderResult : NSObject {
	
/* elements */
	NSString * OrderId;
	NSString * OrderNumber;
	NSString * OrderFriendlyId;
	NSString * ProjectId;
	NSString * ProjectStatus;
	SelfService_ArrayOfQuoteLineItem * QuoteLineItems;
	NSString * ResponseCode;
	NSString * ResponseMessage;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_GetOrderResult *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * OrderId;
@property (retain) NSString * OrderNumber;
@property (retain) NSString * OrderFriendlyId;
@property (retain) NSString * ProjectId;
@property (retain) NSString * ProjectStatus;
@property (retain) SelfService_ArrayOfQuoteLineItem * QuoteLineItems;
@property (retain) NSString * ResponseCode;
@property (retain) NSString * ResponseMessage;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_GetOrderResponse : NSObject {
	
/* elements */
	SelfService_GetOrderResult * GetOrderResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_GetOrderResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) SelfService_GetOrderResult * GetOrderResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_ModifyOrderDetailsRequest : NSObject {
	
/* elements */
	NSString * OrderId;
	SelfService_OrderIdTypeEnum OrderIdType;
	NSString * SourceSystem;
	SelfService_ArrayOfQuoteLineItem * QuoteLineItems;
	NSString * ModifiedBy;
	NSString * UserName;
	NSString * UserId;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_ModifyOrderDetailsRequest *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * OrderId;
@property (assign) SelfService_OrderIdTypeEnum OrderIdType;
@property (retain) NSString * SourceSystem;
@property (retain) SelfService_ArrayOfQuoteLineItem * QuoteLineItems;
@property (retain) NSString * ModifiedBy;
@property (retain) NSString * UserName;
@property (retain) NSString * UserId;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_ModifyOrderDetails : NSObject {
	
/* elements */
	SelfService_ModifyOrderDetailsRequest * modifyOrderDetailsRequest;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_ModifyOrderDetails *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) SelfService_ModifyOrderDetailsRequest * modifyOrderDetailsRequest;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_ModifyOrderDetailsResult : NSObject {
	
/* elements */
	NSNumber * OrderId;
	NSString * ResponseCode;
	NSString * ResponseMessage;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_ModifyOrderDetailsResult *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * OrderId;
@property (retain) NSString * ResponseCode;
@property (retain) NSString * ResponseMessage;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_ModifyOrderDetailsResponse : NSObject {
	
/* elements */
	SelfService_ModifyOrderDetailsResult * ModifyOrderDetailsResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_ModifyOrderDetailsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) SelfService_ModifyOrderDetailsResult * ModifyOrderDetailsResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_GetPortListRequest : NSObject {
	
/* elements */
	NSString * CustomerId;
	SelfService_CustomerIdTypeEnum CustomerIdType;
	NSString * Datacenter;
	NSString * PanelType;
	NSString * PanelName;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_GetPortListRequest *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * CustomerId;
@property (assign) SelfService_CustomerIdTypeEnum CustomerIdType;
@property (retain) NSString * Datacenter;
@property (retain) NSString * PanelType;
@property (retain) NSString * PanelName;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_GetPortList : NSObject {
	
/* elements */
	SelfService_GetPortListRequest * getPortListRequest;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_GetPortList *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) SelfService_GetPortListRequest * getPortListRequest;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_Port : NSObject {
	
/* elements */
	NSString * PanelSite;
	NSString * NetworkPanelId;
	NSString * NetworkPanelName;
	NSString * NetworkPanelType;
	NSString * NetworkPanelPortId;
	NSString * Tx;
	NSString * Rx;
	NSString * PortLabel;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_Port *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * PanelSite;
@property (retain) NSString * NetworkPanelId;
@property (retain) NSString * NetworkPanelName;
@property (retain) NSString * NetworkPanelType;
@property (retain) NSString * NetworkPanelPortId;
@property (retain) NSString * Tx;
@property (retain) NSString * Rx;
@property (retain) NSString * PortLabel;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_ArrayOfPort : NSObject {
	
/* elements */
	NSMutableArray *Port;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_ArrayOfPort *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addPort:(SelfService_Port *)toAdd;
@property (readonly) NSMutableArray * Port;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_GetPortListResult : NSObject {
	
/* elements */
	SelfService_ArrayOfPort * PortList;
	NSString * ResponseCode;
	NSString * ResponseMessage;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_GetPortListResult *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) SelfService_ArrayOfPort * PortList;
@property (retain) NSString * ResponseCode;
@property (retain) NSString * ResponseMessage;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_GetPortListResponse : NSObject {
	
/* elements */
	SelfService_GetPortListResult * GetPortListResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_GetPortListResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) SelfService_GetPortListResult * GetPortListResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_GetPanelTypeListRequest : NSObject {
	
/* elements */
	NSString * CustomerId;
	SelfService_CustomerIdTypeEnum CustomerIdType;
	NSString * Datacenter;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_GetPanelTypeListRequest *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * CustomerId;
@property (assign) SelfService_CustomerIdTypeEnum CustomerIdType;
@property (retain) NSString * Datacenter;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_GetPanelTypeList : NSObject {
	
/* elements */
	SelfService_GetPanelTypeListRequest * getPanelTypeListRequest;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_GetPanelTypeList *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) SelfService_GetPanelTypeListRequest * getPanelTypeListRequest;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_ArrayOfString : NSObject {
	
/* elements */
	NSMutableArray *string;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_ArrayOfString *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addString:(NSString *)toAdd;
@property (readonly) NSMutableArray * string;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_PanelType : NSObject {
	
/* elements */
	NSString * PanelTypeName;
	SelfService_ArrayOfString * PanelNames;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_PanelType *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * PanelTypeName;
@property (retain) SelfService_ArrayOfString * PanelNames;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_ArrayOfPanelType : NSObject {
	
/* elements */
	NSMutableArray *PanelType;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_ArrayOfPanelType *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addPanelType:(SelfService_PanelType *)toAdd;
@property (readonly) NSMutableArray * PanelType;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_GetPanelTypeListResult : NSObject {
	
/* elements */
	SelfService_ArrayOfPanelType * PanelTypeList;
	NSString * ResponseCode;
	NSString * ResponseMessage;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_GetPanelTypeListResult *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) SelfService_ArrayOfPanelType * PanelTypeList;
@property (retain) NSString * ResponseCode;
@property (retain) NSString * ResponseMessage;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_GetPanelTypeListResponse : NSObject {
	
/* elements */
	SelfService_GetPanelTypeListResult * GetPanelTypeListResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_GetPanelTypeListResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) SelfService_GetPanelTypeListResult * GetPanelTypeListResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_GetInterconnectsByCustomerRequest : NSObject {
	
/* elements */
	NSString * CustomerId;
	SelfService_CustomerIdTypeEnum CustomerIdType;
	NSString * Datacenter;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_GetInterconnectsByCustomerRequest *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * CustomerId;
@property (assign) SelfService_CustomerIdTypeEnum CustomerIdType;
@property (retain) NSString * Datacenter;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_GetInterconnectsByCustomer : NSObject {
	
/* elements */
	SelfService_GetInterconnectsByCustomerRequest * getInterconnectsByCustomerRequest;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_GetInterconnectsByCustomer *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) SelfService_GetInterconnectsByCustomerRequest * getInterconnectsByCustomerRequest;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_Interconnect : NSObject {
	
/* elements */
	NSString * InstanceId;
	NSString * InstanceName;
	NSString * ConfigurationWO;
	NSString * CircuitType;
	NSString * Details;
	NSString * NetworkPanelId;
	NSString * NetworkPanelName;
	NSString * NetworkPanelPortId;
	NSString * NetworkPanelPortTx;
	NSString * NetworkPanelPortRx;
	NSString * NetworkPanelType;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_Interconnect *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * InstanceId;
@property (retain) NSString * InstanceName;
@property (retain) NSString * ConfigurationWO;
@property (retain) NSString * CircuitType;
@property (retain) NSString * Details;
@property (retain) NSString * NetworkPanelId;
@property (retain) NSString * NetworkPanelName;
@property (retain) NSString * NetworkPanelPortId;
@property (retain) NSString * NetworkPanelPortTx;
@property (retain) NSString * NetworkPanelPortRx;
@property (retain) NSString * NetworkPanelType;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_ArrayOfInterconnect : NSObject {
	
/* elements */
	NSMutableArray *Interconnect;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_ArrayOfInterconnect *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addInterconnect:(SelfService_Interconnect *)toAdd;
@property (readonly) NSMutableArray * Interconnect;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_GetInterconnectsByCustomerResult : NSObject {
	
/* elements */
	SelfService_ArrayOfInterconnect * InterconnectList;
	NSString * ResponseCode;
	NSString * ResponseMessage;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_GetInterconnectsByCustomerResult *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) SelfService_ArrayOfInterconnect * InterconnectList;
@property (retain) NSString * ResponseCode;
@property (retain) NSString * ResponseMessage;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_GetInterconnectsByCustomerResponse : NSObject {
	
/* elements */
	SelfService_GetInterconnectsByCustomerResult * GetInterconnectsByCustomerResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_GetInterconnectsByCustomerResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) SelfService_GetInterconnectsByCustomerResult * GetInterconnectsByCustomerResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_GetIFCsByCustomerRequest : NSObject {
	
/* elements */
	NSString * CustomerId;
	SelfService_CustomerIdTypeEnum CustomerIdType;
	NSString * Datacenter;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_GetIFCsByCustomerRequest *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * CustomerId;
@property (assign) SelfService_CustomerIdTypeEnum CustomerIdType;
@property (retain) NSString * Datacenter;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_GetIFCsByCustomer : NSObject {
	
/* elements */
	SelfService_GetIFCsByCustomerRequest * getIFCsByCustomerRequest;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_GetIFCsByCustomer *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) SelfService_GetIFCsByCustomerRequest * getIFCsByCustomerRequest;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_IFC : NSObject {
	
/* elements */
	NSString * InstanceId;
	NSString * InstanceName;
	NSString * PanelName;
	NSString * MediaType;
	NSNumber * PortCount;
	NSNumber * UsedPorts;
	NSString * PanelPortTx;
	NSString * PanelPortRx;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_IFC *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * InstanceId;
@property (retain) NSString * InstanceName;
@property (retain) NSString * PanelName;
@property (retain) NSString * MediaType;
@property (retain) NSNumber * PortCount;
@property (retain) NSNumber * UsedPorts;
@property (retain) NSString * PanelPortTx;
@property (retain) NSString * PanelPortRx;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_ArrayOfIFC : NSObject {
	
/* elements */
	NSMutableArray *IFC;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_ArrayOfIFC *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addIFC:(SelfService_IFC *)toAdd;
@property (readonly) NSMutableArray * IFC;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_GetIFCsByCustomerResult : NSObject {
	
/* elements */
	SelfService_ArrayOfIFC * IFCList;
	NSString * ResponseCode;
	NSString * ResponseMessage;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_GetIFCsByCustomerResult *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) SelfService_ArrayOfIFC * IFCList;
@property (retain) NSString * ResponseCode;
@property (retain) NSString * ResponseMessage;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_GetIFCsByCustomerResponse : NSObject {
	
/* elements */
	SelfService_GetIFCsByCustomerResult * GetIFCsByCustomerResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_GetIFCsByCustomerResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) SelfService_GetIFCsByCustomerResult * GetIFCsByCustomerResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_GetGridLocationsByCustomerRequest : NSObject {
	
/* elements */
	NSString * CustomerId;
	SelfService_CustomerIdTypeEnum CustomerIdType;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_GetGridLocationsByCustomerRequest *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * CustomerId;
@property (assign) SelfService_CustomerIdTypeEnum CustomerIdType;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_GetGridLocationsByCustomer : NSObject {
	
/* elements */
	SelfService_GetGridLocationsByCustomerRequest * getGridLocationsByCustomerRequest;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_GetGridLocationsByCustomer *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) SelfService_GetGridLocationsByCustomerRequest * getGridLocationsByCustomerRequest;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_GridLocation : NSObject {
	
/* elements */
	NSString * InstanceId;
	NSString * InstanceName;
	NSString * LocationDomainName;
	NSString * GridLocationName;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_GridLocation *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * InstanceId;
@property (retain) NSString * InstanceName;
@property (retain) NSString * LocationDomainName;
@property (retain) NSString * GridLocationName;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_ArrayOfGridLocation : NSObject {
	
/* elements */
	NSMutableArray *GridLocation;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_ArrayOfGridLocation *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addGridLocation:(SelfService_GridLocation *)toAdd;
@property (readonly) NSMutableArray * GridLocation;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_GetGridLocationsByCustomerResult : NSObject {
	
/* elements */
	SelfService_ArrayOfGridLocation * GridLocationList;
	NSString * ResponseCode;
	NSString * ResponseMessage;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_GetGridLocationsByCustomerResult *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) SelfService_ArrayOfGridLocation * GridLocationList;
@property (retain) NSString * ResponseCode;
@property (retain) NSString * ResponseMessage;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SelfService_GetGridLocationsByCustomerResponse : NSObject {
	
/* elements */
	SelfService_GetGridLocationsByCustomerResult * GetGridLocationsByCustomerResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SelfService_GetGridLocationsByCustomerResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) SelfService_GetGridLocationsByCustomerResult * GetGridLocationsByCustomerResult;
/* attributes */
- (NSDictionary *)attributes;
@end
/* Cookies handling provided by http://en.wikibooks.org/wiki/Programming:WebObjects/Web_Services/Web_Service_Provider */
#import <libxml/parser.h>
#import "xsd.h"
#import "SelfService.h"
@class SelfServiceSoapBinding;
@class SelfServiceSoap12Binding;
@interface SelfService : NSObject {
	
}
+ (SelfServiceSoapBinding *)SelfServiceSoapBinding;
+ (SelfServiceSoap12Binding *)SelfServiceSoap12Binding;
@end
@class SelfServiceSoapBindingResponse;
@class SelfServiceSoapBindingOperation;
@protocol SelfServiceSoapBindingResponseDelegate <NSObject>
- (void) operation:(SelfServiceSoapBindingOperation *)operation completedWithResponse:(SelfServiceSoapBindingResponse *)response;
@end
@interface SelfServiceSoapBinding : NSObject <SelfServiceSoapBindingResponseDelegate> {
	NSURL *address;
	NSTimeInterval defaultTimeout;
	NSMutableArray *cookies;
	BOOL logXMLInOut;
	BOOL synchronousOperationComplete;
	NSString *authUsername;
	NSString *authPassword;
}
@property (copy) NSURL *address;
@property (assign) BOOL logXMLInOut;
@property (assign) NSTimeInterval defaultTimeout;
@property (nonatomic, retain) NSMutableArray *cookies;
@property (nonatomic, retain) NSString *authUsername;
@property (nonatomic, retain) NSString *authPassword;
- (id)initWithAddress:(NSString *)anAddress;
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(SelfServiceSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (SelfServiceSoapBindingResponse *)CreateOrderUsingParameters:(SelfService_CreateOrder *)aParameters ;
- (void)CreateOrderAsyncUsingParameters:(SelfService_CreateOrder *)aParameters  delegate:(id<SelfServiceSoapBindingResponseDelegate>)responseDelegate;
- (SelfServiceSoapBindingResponse *)UpdateOrderUsingParameters:(SelfService_UpdateOrder *)aParameters ;
- (void)UpdateOrderAsyncUsingParameters:(SelfService_UpdateOrder *)aParameters  delegate:(id<SelfServiceSoapBindingResponseDelegate>)responseDelegate;
- (SelfServiceSoapBindingResponse *)UpdateOrderStatusUsingParameters:(SelfService_UpdateOrderStatus *)aParameters ;
- (void)UpdateOrderStatusAsyncUsingParameters:(SelfService_UpdateOrderStatus *)aParameters  delegate:(id<SelfServiceSoapBindingResponseDelegate>)responseDelegate;
- (SelfServiceSoapBindingResponse *)AddOrderAttachmentUsingParameters:(SelfService_AddOrderAttachment *)aParameters ;
- (void)AddOrderAttachmentAsyncUsingParameters:(SelfService_AddOrderAttachment *)aParameters  delegate:(id<SelfServiceSoapBindingResponseDelegate>)responseDelegate;
- (SelfServiceSoapBindingResponse *)GetOrdersUsingParameters:(SelfService_GetOrders *)aParameters ;
- (void)GetOrdersAsyncUsingParameters:(SelfService_GetOrders *)aParameters  delegate:(id<SelfServiceSoapBindingResponseDelegate>)responseDelegate;
- (SelfServiceSoapBindingResponse *)GetOrderUsingParameters:(SelfService_GetOrder *)aParameters ;
- (void)GetOrderAsyncUsingParameters:(SelfService_GetOrder *)aParameters  delegate:(id<SelfServiceSoapBindingResponseDelegate>)responseDelegate;
- (SelfServiceSoapBindingResponse *)ModifyOrderDetailsUsingParameters:(SelfService_ModifyOrderDetails *)aParameters ;
- (void)ModifyOrderDetailsAsyncUsingParameters:(SelfService_ModifyOrderDetails *)aParameters  delegate:(id<SelfServiceSoapBindingResponseDelegate>)responseDelegate;
- (SelfServiceSoapBindingResponse *)GetPortListUsingParameters:(SelfService_GetPortList *)aParameters ;
- (void)GetPortListAsyncUsingParameters:(SelfService_GetPortList *)aParameters  delegate:(id<SelfServiceSoapBindingResponseDelegate>)responseDelegate;
- (SelfServiceSoapBindingResponse *)GetPanelTypeListUsingParameters:(SelfService_GetPanelTypeList *)aParameters ;
- (void)GetPanelTypeListAsyncUsingParameters:(SelfService_GetPanelTypeList *)aParameters  delegate:(id<SelfServiceSoapBindingResponseDelegate>)responseDelegate;
- (SelfServiceSoapBindingResponse *)GetInterconnectsByCustomerUsingParameters:(SelfService_GetInterconnectsByCustomer *)aParameters ;
- (void)GetInterconnectsByCustomerAsyncUsingParameters:(SelfService_GetInterconnectsByCustomer *)aParameters  delegate:(id<SelfServiceSoapBindingResponseDelegate>)responseDelegate;
- (SelfServiceSoapBindingResponse *)GetIFCsByCustomerUsingParameters:(SelfService_GetIFCsByCustomer *)aParameters ;
- (void)GetIFCsByCustomerAsyncUsingParameters:(SelfService_GetIFCsByCustomer *)aParameters  delegate:(id<SelfServiceSoapBindingResponseDelegate>)responseDelegate;
- (SelfServiceSoapBindingResponse *)GetGridLocationsByCustomerUsingParameters:(SelfService_GetGridLocationsByCustomer *)aParameters ;
- (void)GetGridLocationsByCustomerAsyncUsingParameters:(SelfService_GetGridLocationsByCustomer *)aParameters  delegate:(id<SelfServiceSoapBindingResponseDelegate>)responseDelegate;
@end
@interface SelfServiceSoapBindingOperation : NSOperation {
	SelfServiceSoapBinding *binding;
	SelfServiceSoapBindingResponse *response;
	id<SelfServiceSoapBindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) SelfServiceSoapBinding *binding;
@property (readonly) SelfServiceSoapBindingResponse *response;
@property (nonatomic, assign) id<SelfServiceSoapBindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(SelfServiceSoapBinding *)aBinding delegate:(id<SelfServiceSoapBindingResponseDelegate>)aDelegate;
@end
@interface SelfServiceSoapBinding_CreateOrder : SelfServiceSoapBindingOperation {
	SelfService_CreateOrder * parameters;
}
@property (retain) SelfService_CreateOrder * parameters;
- (id)initWithBinding:(SelfServiceSoapBinding *)aBinding delegate:(id<SelfServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(SelfService_CreateOrder *)aParameters
;
@end
@interface SelfServiceSoapBinding_UpdateOrder : SelfServiceSoapBindingOperation {
	SelfService_UpdateOrder * parameters;
}
@property (retain) SelfService_UpdateOrder * parameters;
- (id)initWithBinding:(SelfServiceSoapBinding *)aBinding delegate:(id<SelfServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(SelfService_UpdateOrder *)aParameters
;
@end
@interface SelfServiceSoapBinding_UpdateOrderStatus : SelfServiceSoapBindingOperation {
	SelfService_UpdateOrderStatus * parameters;
}
@property (retain) SelfService_UpdateOrderStatus * parameters;
- (id)initWithBinding:(SelfServiceSoapBinding *)aBinding delegate:(id<SelfServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(SelfService_UpdateOrderStatus *)aParameters
;
@end
@interface SelfServiceSoapBinding_AddOrderAttachment : SelfServiceSoapBindingOperation {
	SelfService_AddOrderAttachment * parameters;
}
@property (retain) SelfService_AddOrderAttachment * parameters;
- (id)initWithBinding:(SelfServiceSoapBinding *)aBinding delegate:(id<SelfServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(SelfService_AddOrderAttachment *)aParameters
;
@end
@interface SelfServiceSoapBinding_GetOrders : SelfServiceSoapBindingOperation {
	SelfService_GetOrders * parameters;
}
@property (retain) SelfService_GetOrders * parameters;
- (id)initWithBinding:(SelfServiceSoapBinding *)aBinding delegate:(id<SelfServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(SelfService_GetOrders *)aParameters
;
@end
@interface SelfServiceSoapBinding_GetOrder : SelfServiceSoapBindingOperation {
	SelfService_GetOrder * parameters;
}
@property (retain) SelfService_GetOrder * parameters;
- (id)initWithBinding:(SelfServiceSoapBinding *)aBinding delegate:(id<SelfServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(SelfService_GetOrder *)aParameters
;
@end
@interface SelfServiceSoapBinding_ModifyOrderDetails : SelfServiceSoapBindingOperation {
	SelfService_ModifyOrderDetails * parameters;
}
@property (retain) SelfService_ModifyOrderDetails * parameters;
- (id)initWithBinding:(SelfServiceSoapBinding *)aBinding delegate:(id<SelfServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(SelfService_ModifyOrderDetails *)aParameters
;
@end
@interface SelfServiceSoapBinding_GetPortList : SelfServiceSoapBindingOperation {
	SelfService_GetPortList * parameters;
}
@property (retain) SelfService_GetPortList * parameters;
- (id)initWithBinding:(SelfServiceSoapBinding *)aBinding delegate:(id<SelfServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(SelfService_GetPortList *)aParameters
;
@end
@interface SelfServiceSoapBinding_GetPanelTypeList : SelfServiceSoapBindingOperation {
	SelfService_GetPanelTypeList * parameters;
}
@property (retain) SelfService_GetPanelTypeList * parameters;
- (id)initWithBinding:(SelfServiceSoapBinding *)aBinding delegate:(id<SelfServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(SelfService_GetPanelTypeList *)aParameters
;
@end
@interface SelfServiceSoapBinding_GetInterconnectsByCustomer : SelfServiceSoapBindingOperation {
	SelfService_GetInterconnectsByCustomer * parameters;
}
@property (retain) SelfService_GetInterconnectsByCustomer * parameters;
- (id)initWithBinding:(SelfServiceSoapBinding *)aBinding delegate:(id<SelfServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(SelfService_GetInterconnectsByCustomer *)aParameters
;
@end
@interface SelfServiceSoapBinding_GetIFCsByCustomer : SelfServiceSoapBindingOperation {
	SelfService_GetIFCsByCustomer * parameters;
}
@property (retain) SelfService_GetIFCsByCustomer * parameters;
- (id)initWithBinding:(SelfServiceSoapBinding *)aBinding delegate:(id<SelfServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(SelfService_GetIFCsByCustomer *)aParameters
;
@end
@interface SelfServiceSoapBinding_GetGridLocationsByCustomer : SelfServiceSoapBindingOperation {
	SelfService_GetGridLocationsByCustomer * parameters;
}
@property (retain) SelfService_GetGridLocationsByCustomer * parameters;
- (id)initWithBinding:(SelfServiceSoapBinding *)aBinding delegate:(id<SelfServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(SelfService_GetGridLocationsByCustomer *)aParameters
;
@end
@interface SelfServiceSoapBinding_envelope : NSObject {
}
+ (SelfServiceSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface SelfServiceSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
@class SelfServiceSoap12BindingResponse;
@class SelfServiceSoap12BindingOperation;
@protocol SelfServiceSoap12BindingResponseDelegate <NSObject>
- (void) operation:(SelfServiceSoap12BindingOperation *)operation completedWithResponse:(SelfServiceSoap12BindingResponse *)response;
@end
@interface SelfServiceSoap12Binding : NSObject <SelfServiceSoap12BindingResponseDelegate> {
	NSURL *address;
	NSTimeInterval defaultTimeout;
	NSMutableArray *cookies;
	BOOL logXMLInOut;
	BOOL synchronousOperationComplete;
	NSString *authUsername;
	NSString *authPassword;
}
@property (copy) NSURL *address;
@property (assign) BOOL logXMLInOut;
@property (assign) NSTimeInterval defaultTimeout;
@property (nonatomic, retain) NSMutableArray *cookies;
@property (nonatomic, retain) NSString *authUsername;
@property (nonatomic, retain) NSString *authPassword;
- (id)initWithAddress:(NSString *)anAddress;
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(SelfServiceSoap12BindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (SelfServiceSoap12BindingResponse *)CreateOrderUsingParameters:(SelfService_CreateOrder *)aParameters ;
- (void)CreateOrderAsyncUsingParameters:(SelfService_CreateOrder *)aParameters  delegate:(id<SelfServiceSoap12BindingResponseDelegate>)responseDelegate;
- (SelfServiceSoap12BindingResponse *)UpdateOrderUsingParameters:(SelfService_UpdateOrder *)aParameters ;
- (void)UpdateOrderAsyncUsingParameters:(SelfService_UpdateOrder *)aParameters  delegate:(id<SelfServiceSoap12BindingResponseDelegate>)responseDelegate;
- (SelfServiceSoap12BindingResponse *)UpdateOrderStatusUsingParameters:(SelfService_UpdateOrderStatus *)aParameters ;
- (void)UpdateOrderStatusAsyncUsingParameters:(SelfService_UpdateOrderStatus *)aParameters  delegate:(id<SelfServiceSoap12BindingResponseDelegate>)responseDelegate;
- (SelfServiceSoap12BindingResponse *)AddOrderAttachmentUsingParameters:(SelfService_AddOrderAttachment *)aParameters ;
- (void)AddOrderAttachmentAsyncUsingParameters:(SelfService_AddOrderAttachment *)aParameters  delegate:(id<SelfServiceSoap12BindingResponseDelegate>)responseDelegate;
- (SelfServiceSoap12BindingResponse *)GetOrdersUsingParameters:(SelfService_GetOrders *)aParameters ;
- (void)GetOrdersAsyncUsingParameters:(SelfService_GetOrders *)aParameters  delegate:(id<SelfServiceSoap12BindingResponseDelegate>)responseDelegate;
- (SelfServiceSoap12BindingResponse *)GetOrderUsingParameters:(SelfService_GetOrder *)aParameters ;
- (void)GetOrderAsyncUsingParameters:(SelfService_GetOrder *)aParameters  delegate:(id<SelfServiceSoap12BindingResponseDelegate>)responseDelegate;
- (SelfServiceSoap12BindingResponse *)ModifyOrderDetailsUsingParameters:(SelfService_ModifyOrderDetails *)aParameters ;
- (void)ModifyOrderDetailsAsyncUsingParameters:(SelfService_ModifyOrderDetails *)aParameters  delegate:(id<SelfServiceSoap12BindingResponseDelegate>)responseDelegate;
- (SelfServiceSoap12BindingResponse *)GetPortListUsingParameters:(SelfService_GetPortList *)aParameters ;
- (void)GetPortListAsyncUsingParameters:(SelfService_GetPortList *)aParameters  delegate:(id<SelfServiceSoap12BindingResponseDelegate>)responseDelegate;
- (SelfServiceSoap12BindingResponse *)GetPanelTypeListUsingParameters:(SelfService_GetPanelTypeList *)aParameters ;
- (void)GetPanelTypeListAsyncUsingParameters:(SelfService_GetPanelTypeList *)aParameters  delegate:(id<SelfServiceSoap12BindingResponseDelegate>)responseDelegate;
- (SelfServiceSoap12BindingResponse *)GetInterconnectsByCustomerUsingParameters:(SelfService_GetInterconnectsByCustomer *)aParameters ;
- (void)GetInterconnectsByCustomerAsyncUsingParameters:(SelfService_GetInterconnectsByCustomer *)aParameters  delegate:(id<SelfServiceSoap12BindingResponseDelegate>)responseDelegate;
- (SelfServiceSoap12BindingResponse *)GetIFCsByCustomerUsingParameters:(SelfService_GetIFCsByCustomer *)aParameters ;
- (void)GetIFCsByCustomerAsyncUsingParameters:(SelfService_GetIFCsByCustomer *)aParameters  delegate:(id<SelfServiceSoap12BindingResponseDelegate>)responseDelegate;
- (SelfServiceSoap12BindingResponse *)GetGridLocationsByCustomerUsingParameters:(SelfService_GetGridLocationsByCustomer *)aParameters ;
- (void)GetGridLocationsByCustomerAsyncUsingParameters:(SelfService_GetGridLocationsByCustomer *)aParameters  delegate:(id<SelfServiceSoap12BindingResponseDelegate>)responseDelegate;
@end
@interface SelfServiceSoap12BindingOperation : NSOperation {
	SelfServiceSoap12Binding *binding;
	SelfServiceSoap12BindingResponse *response;
	id<SelfServiceSoap12BindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) SelfServiceSoap12Binding *binding;
@property (readonly) SelfServiceSoap12BindingResponse *response;
@property (nonatomic, assign) id<SelfServiceSoap12BindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(SelfServiceSoap12Binding *)aBinding delegate:(id<SelfServiceSoap12BindingResponseDelegate>)aDelegate;
@end
@interface SelfServiceSoap12Binding_CreateOrder : SelfServiceSoap12BindingOperation {
	SelfService_CreateOrder * parameters;
}
@property (retain) SelfService_CreateOrder * parameters;
- (id)initWithBinding:(SelfServiceSoap12Binding *)aBinding delegate:(id<SelfServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(SelfService_CreateOrder *)aParameters
;
@end
@interface SelfServiceSoap12Binding_UpdateOrder : SelfServiceSoap12BindingOperation {
	SelfService_UpdateOrder * parameters;
}
@property (retain) SelfService_UpdateOrder * parameters;
- (id)initWithBinding:(SelfServiceSoap12Binding *)aBinding delegate:(id<SelfServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(SelfService_UpdateOrder *)aParameters
;
@end
@interface SelfServiceSoap12Binding_UpdateOrderStatus : SelfServiceSoap12BindingOperation {
	SelfService_UpdateOrderStatus * parameters;
}
@property (retain) SelfService_UpdateOrderStatus * parameters;
- (id)initWithBinding:(SelfServiceSoap12Binding *)aBinding delegate:(id<SelfServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(SelfService_UpdateOrderStatus *)aParameters
;
@end
@interface SelfServiceSoap12Binding_AddOrderAttachment : SelfServiceSoap12BindingOperation {
	SelfService_AddOrderAttachment * parameters;
}
@property (retain) SelfService_AddOrderAttachment * parameters;
- (id)initWithBinding:(SelfServiceSoap12Binding *)aBinding delegate:(id<SelfServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(SelfService_AddOrderAttachment *)aParameters
;
@end
@interface SelfServiceSoap12Binding_GetOrders : SelfServiceSoap12BindingOperation {
	SelfService_GetOrders * parameters;
}
@property (retain) SelfService_GetOrders * parameters;
- (id)initWithBinding:(SelfServiceSoap12Binding *)aBinding delegate:(id<SelfServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(SelfService_GetOrders *)aParameters
;
@end
@interface SelfServiceSoap12Binding_GetOrder : SelfServiceSoap12BindingOperation {
	SelfService_GetOrder * parameters;
}
@property (retain) SelfService_GetOrder * parameters;
- (id)initWithBinding:(SelfServiceSoap12Binding *)aBinding delegate:(id<SelfServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(SelfService_GetOrder *)aParameters
;
@end
@interface SelfServiceSoap12Binding_ModifyOrderDetails : SelfServiceSoap12BindingOperation {
	SelfService_ModifyOrderDetails * parameters;
}
@property (retain) SelfService_ModifyOrderDetails * parameters;
- (id)initWithBinding:(SelfServiceSoap12Binding *)aBinding delegate:(id<SelfServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(SelfService_ModifyOrderDetails *)aParameters
;
@end
@interface SelfServiceSoap12Binding_GetPortList : SelfServiceSoap12BindingOperation {
	SelfService_GetPortList * parameters;
}
@property (retain) SelfService_GetPortList * parameters;
- (id)initWithBinding:(SelfServiceSoap12Binding *)aBinding delegate:(id<SelfServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(SelfService_GetPortList *)aParameters
;
@end
@interface SelfServiceSoap12Binding_GetPanelTypeList : SelfServiceSoap12BindingOperation {
	SelfService_GetPanelTypeList * parameters;
}
@property (retain) SelfService_GetPanelTypeList * parameters;
- (id)initWithBinding:(SelfServiceSoap12Binding *)aBinding delegate:(id<SelfServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(SelfService_GetPanelTypeList *)aParameters
;
@end
@interface SelfServiceSoap12Binding_GetInterconnectsByCustomer : SelfServiceSoap12BindingOperation {
	SelfService_GetInterconnectsByCustomer * parameters;
}
@property (retain) SelfService_GetInterconnectsByCustomer * parameters;
- (id)initWithBinding:(SelfServiceSoap12Binding *)aBinding delegate:(id<SelfServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(SelfService_GetInterconnectsByCustomer *)aParameters
;
@end
@interface SelfServiceSoap12Binding_GetIFCsByCustomer : SelfServiceSoap12BindingOperation {
	SelfService_GetIFCsByCustomer * parameters;
}
@property (retain) SelfService_GetIFCsByCustomer * parameters;
- (id)initWithBinding:(SelfServiceSoap12Binding *)aBinding delegate:(id<SelfServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(SelfService_GetIFCsByCustomer *)aParameters
;
@end
@interface SelfServiceSoap12Binding_GetGridLocationsByCustomer : SelfServiceSoap12BindingOperation {
	SelfService_GetGridLocationsByCustomer * parameters;
}
@property (retain) SelfService_GetGridLocationsByCustomer * parameters;
- (id)initWithBinding:(SelfServiceSoap12Binding *)aBinding delegate:(id<SelfServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(SelfService_GetGridLocationsByCustomer *)aParameters
;
@end
@interface SelfServiceSoap12Binding_envelope : NSObject {
}
+ (SelfServiceSoap12Binding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface SelfServiceSoap12BindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
