//
//  DomainsService.h
//  STIPoC
//
//  Created by Alex Gutierrez on 12/18/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "GenericService.h"

@interface DomainsService : GenericService

- (void)getDomainsWithCompletionBlock:(void(^)(NSDictionary *domains))completion
                      andFailureBlock:(void (^) (NSError *error))failure;

@end
