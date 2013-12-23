//
//  Attribute.h
//  STIPoC
//
//  Created by Administrator on 12/23/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Entity.h"

@class AttributeTypeValue, Domain, Filter;

@interface Attribute : Entity

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * orderPriority;
@property (nonatomic, retain) NSNumber * orderType;
@property (nonatomic, retain) NSNumber * selected;
@property (nonatomic, retain) NSNumber * selectOrder;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) Domain *domain;
@property (nonatomic, retain) NSSet *filters;
@property (nonatomic, retain) NSSet *typeValues;
@end

@interface Attribute (CoreDataGeneratedAccessors)

- (void)addFiltersObject:(Filter *)value;
- (void)removeFiltersObject:(Filter *)value;
- (void)addFilters:(NSSet *)values;
- (void)removeFilters:(NSSet *)values;

- (void)addTypeValuesObject:(AttributeTypeValue *)value;
- (void)removeTypeValuesObject:(AttributeTypeValue *)value;
- (void)addTypeValues:(NSSet *)values;
- (void)removeTypeValues:(NSSet *)values;

@end
