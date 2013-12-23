//
//  GenericTranslator.h
//  STIPoC
//
//  Created by Administrator on 12/23/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Domain;

@interface DomainsTranslator : NSObject

+ (void)translateDomainJSONDictionary:(NSDictionary *)domainDictionary toDomain:(Domain *)domain;

@end
