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
#import "Attribute.h"
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


@end
