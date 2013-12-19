//
//  Domain.h
//  STIPoC
//
//  Created by Alex Gutierrez on 12/19/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Entity.h"

@class Attribute;

@interface Domain : Entity

@property (nonatomic, retain) NSNumber * maxCount;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *attributes;
@end

@interface Domain (CoreDataGeneratedAccessors)

- (void)addAttributesObject:(Attribute *)value;
- (void)removeAttributesObject:(Attribute *)value;
- (void)addAttributes:(NSSet *)values;
- (void)removeAttributes:(NSSet *)values;

@end
