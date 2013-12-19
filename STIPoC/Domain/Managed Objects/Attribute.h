//
//  Attribute.h
//  STIPoC
//
//  Created by Alex Gutierrez on 12/19/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Entity.h"

@class Domain, Filter;

@interface Attribute : Entity

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSNumber * orderType;
@property (nonatomic, retain) NSNumber * orderPriority;
@property (nonatomic, retain) NSNumber * selectOrder;
@property (nonatomic, retain) NSNumber * selected;
@property (nonatomic, retain) Domain *domain;
@property (nonatomic, retain) NSSet *filters;
@end

@interface Attribute (CoreDataGeneratedAccessors)

- (void)addFiltersObject:(Filter *)value;
- (void)removeFiltersObject:(Filter *)value;
- (void)addFilters:(NSSet *)values;
- (void)removeFilters:(NSSet *)values;

@end
