//
//  AttributesService.m
//  STIPoC
//
//  Created by Administrator on 12/23/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "AttributesService.h"
#import "CMDBRequestOperationManager.h"
#import "Domain.h"
#import "Attribute+Extra.h"
#import "AttributesTranslator.h"

@implementation AttributesService

#pragma mark -
#pragma mark Class Methods

+ (instancetype)sharedService
{
    static id _sharedService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedService = [[self class] new];
    });
    return _sharedService;
}

#pragma mark -
#pragma mark Public Methods

- (void)getAttributesForDomain:(Domain *)domain
           withCompletionBlock:(void (^) (NSArray *attributes))completion
               andFailureBlock:(void (^) (NSError *error))failure
{
    [[NSManagedObjectContext contextForCurrentThread] rollback];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [[CMDBRequestOperationManager sharedManager] startGetAttributesRequestOperationWithDomainId:domain.entityID
                                                                                    completionBlock:^(id responseObject) {
                                                                                        
                                                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                                                            if (completion) {
                                                                                                
                                                                                                NSArray *attributes = (NSArray *)responseObject;
                                                                                                
                                                                                                for (NSDictionary *attributeDictionary in attributes) {
                                                                                                    
                                                                                                    Attribute *attribute = [Attribute createEntity];
                                                                                                    attribute.domain = domain;
                                                                                                    [AttributesTranslator translateAttributeJSONDictionary:attributeDictionary toAttribute:attribute];
                                                                                                }

                                                                                                completion([domain.attributes allObjects]);
                                                                                            }
                                                                                        });
                                                                                    } andFailureBlock:^(NSError *internalError) {
                                                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                                                            if (failure) {
                                                                                                failure(self.defaultPublicError);
                                                                                            }
                                                                                        });
                                                                                    }];
         
    });

    
}

- (NSInteger)currentMaxOrderPriorityWithinSelectedAttributes:(NSMutableArray *)selectedAttributes
{
    NSInteger orderPriority = 0;
    for (Attribute *selectedAttribute in selectedAttributes) {
        if (selectedAttribute.orderPriority) {
            if (selectedAttribute.orderPriority.integerValue > orderPriority) {
                orderPriority = selectedAttribute.orderPriority.integerValue;
            }
        }
    }
    
    return orderPriority;
}

- (NSNumber *)orderPriorityForNewOrdererdAttributeWithinSelectedAttributes:(NSMutableArray *)selectedAttributes
{
    NSInteger orderPriority = [self currentMaxOrderPriorityWithinSelectedAttributes:selectedAttributes];
    return @(orderPriority + 1);
}

- (void)updateOrderPrioritiesForSelectedAttributes:(NSMutableArray *)selectedAttributes withUnorderedAttribute:(Attribute *)unorderedAttribute
{
    if (unorderedAttribute.orderType.integerValue == AttributeOrderTypeNone) {
        return;
    }
    
    for (Attribute *selectedAttribute in selectedAttributes) {
        
        // verify that the attribute is different to the one which order type we are going to set to None
        if (![selectedAttribute isEqual:unorderedAttribute]) {
            
            // verify that the attribute is ordered
            if (selectedAttribute.orderType && selectedAttribute.orderType.integerValue != AttributeOrderTypeNone) {
                
                // verify that the attribute order priority is greater than the one which order type we are going to set to None
                if (selectedAttribute.orderPriority.integerValue > unorderedAttribute.orderPriority.integerValue) {
                    selectedAttribute.orderPriority = @(selectedAttribute.orderPriority.integerValue - 1);
                }
            }
        }
    }
    
    unorderedAttribute.orderPriority = nil;
    unorderedAttribute.orderType = @(AttributeOrderTypeNone);
}

- (void)updateOrderPrioritiesForSelectedAttributes:(NSMutableArray *)selectedAttributes withAttributeToUpdate:(Attribute *)attributeToUpdate withNewOrderPriority:(NSInteger)orderPriority
{
    if (attributeToUpdate.orderType.integerValue == AttributeOrderTypeNone || !attributeToUpdate.orderPriority ||  attributeToUpdate.orderPriority.integerValue == orderPriority) {
        return;
    }
    
    for (Attribute *selectedAttribute in selectedAttributes) {
        
        // verify that the attribute is different to the one which order type we are going to set to None
        if (![selectedAttribute isEqual:attributeToUpdate]) {
            
            // verify that the attribute is ordered
            if (selectedAttribute.orderType && selectedAttribute.orderType.integerValue != AttributeOrderTypeNone) {
                
                if (attributeToUpdate.orderPriority.integerValue < orderPriority) {
                    if (selectedAttribute.orderPriority.integerValue <= orderPriority && selectedAttribute.orderPriority.integerValue > attributeToUpdate.orderPriority.integerValue) {
                        selectedAttribute.orderPriority = @(selectedAttribute.orderPriority.integerValue - 1);
                    }
                }
                else {
                    if (selectedAttribute.orderPriority.integerValue >= orderPriority && selectedAttribute.orderPriority.integerValue < attributeToUpdate.orderPriority.integerValue) {
                        selectedAttribute.orderPriority = @(selectedAttribute.orderPriority.integerValue + 1);
                    }
                }
                
            }
        }
    }
    
    attributeToUpdate.orderPriority = @(orderPriority);
}


@end
