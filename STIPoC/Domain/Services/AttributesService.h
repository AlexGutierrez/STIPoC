//
//  AttributesService.h
//  STIPoC
//
//  Created by Administrator on 12/23/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "GenericService.h"

@class Domain;

@interface AttributesService : GenericService

- (void)getAttributesForDomain:(Domain *)domain
           withCompletionBlock:(void (^) (NSArray *attributes))completion
               andFailureBlock:(void (^) (NSError *error))failure;

@end
