//
//  GenericTranslator.m
//  STIPoC
//
//  Created by Administrator on 12/23/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "DomainsTranslator.h"
#import "Domain.h"

static NSString *const kSTIPoCDomainIDAttributeKey = @"DomainID";
static NSString *const kSTIPoCInstanceAttributeKey = @"InstanceCount";
static NSString *const kSTIPoCNameAttributeKey = @"Name";

@implementation DomainsTranslator

+ (void)translateDomainJSONDictionary:(NSDictionary *)domainDictionary toDomain:(Domain *)domain
{
    NSNumber *entityIDNumber = [domainDictionary objectForKey:kSTIPoCDomainIDAttributeKey];
    domain.entityID = [NSString stringWithFormat:@"%i", entityIDNumber.integerValue];
    domain.instanceCount = [domainDictionary objectForKey:kSTIPoCInstanceAttributeKey];
    domain.name = [domainDictionary objectForKey:kSTIPoCNameAttributeKey];
}

@end
