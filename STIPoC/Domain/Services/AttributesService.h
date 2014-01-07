//
//  AttributesService.h
//  STIPoC
//
//  Created by Administrator on 12/23/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "GenericService.h"

@class Domain;
@class Attribute;

@interface AttributesService : GenericService

- (void)getAttributesForDomain:(Domain *)domain
           withCompletionBlock:(void (^) (NSArray *attributes))completion
               andFailureBlock:(void (^) (NSError *error))failure;

- (NSInteger)currentMaxOrderPriorityWithinSelectedAttributes:(NSMutableArray *)selectedAttributes;

- (NSNumber *)orderPriorityForNewOrdererdAttributeWithinSelectedAttributes:(NSMutableArray *)selectedAttributes;

- (void)updateOrderPrioritiesForSelectedAttributes:(NSMutableArray *)selectedAttributes
                            withUnorderedAttribute:(Attribute *)unorderedAttribute;

- (void)updateOrderPrioritiesForSelectedAttributes:(NSMutableArray *)selectedAttributes
                             withAttributeToUpdate:(Attribute *)attributeToUpdate
                              withNewOrderPriority:(NSInteger)orderPriority;

@end
