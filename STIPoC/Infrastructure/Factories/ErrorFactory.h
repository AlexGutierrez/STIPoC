//
//  ErrorFactory.h
//  STIPoC
//
//  Created by Alex Gutierrez on 11/29/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "GenericFactory.h"

@class GenericSelfServiceResult;

@interface ErrorFactory : GenericFactory

- (NSError *)createErrorWithSelfServiceDomain:(NSString *)domain
                         andSelfServiceResult:(GenericSelfServiceResult *)genericSelfServiceResult;

- (NSError *)createErrorWithSelfServiceDomain:(NSString *)domain
                      andDescription:(NSString *)description;

- (NSError *)createDefaultNetworkReachabilityError;

- (NSError *)createDefaultServerError;

@end
