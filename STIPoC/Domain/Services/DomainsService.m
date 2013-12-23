//
//  DomainsService.m
//  STIPoC
//
//  Created by Alex Gutierrez on 12/18/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "DomainsService.h"
#import "Domain.h"
#import "Attribute.h"
#import "AttributeTypeValue.h"
#import "CMDBRequestOperationManager.h"
#import "DomainsTranslator.h"

static NSString *const kSTIPoCNameAttributeKey = @"name";

@interface DomainsService ()

- (void)createDummyDomainsWithCompletionBlock:(void(^)(NSDictionary *domains))completion
                              andFailureBlock:(void (^) (NSError *error))failure;
- (NSDictionary *)domainsIndexedDictionary;

@end

@implementation DomainsService

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

- (void)getDomainsWithCompletionBlock:(void(^)(NSDictionary *domains))completion
                      andFailureBlock:(void (^) (NSError *error))failure
{
    // if domains exist in cache
    if ([Domain countOfEntities] > 0) {
        completion([self domainsIndexedDictionary]);
    }
    // retrieve domains from server
    else {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            [[CMDBRequestOperationManager sharedManager] startGetDomainsRequestOperationWithCompletionBlock:^(id responseObject) {
                __block NSArray *domains = (NSArray *)responseObject;
                
                [MagicalRecord saveUsingCurrentThreadContextWithBlock:^(NSManagedObjectContext *localContext) {
                    
                    for (NSDictionary *domainDictionary in domains) {
                        Domain *domain = [Domain createInContext:localContext];
                        [DomainsTranslator translateDomainJSONDictionary:domainDictionary toDomain:domain];
                    }
                    
                } completion:^(BOOL success, NSError *error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (completion) {
                            completion([self domainsIndexedDictionary]);
                        }
                    });
                }];
                
            } andFailureBlock:^(NSError *internalError) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (failure) {
                        failure(self.defaultPublicError);
                    }
                });
            }];
        });
    }
}

#pragma mark -
#pragma mark Private Methods

- (void)createDummyDomainsWithCompletionBlock:(void(^)(NSDictionary *domains))completion
                              andFailureBlock:(void (^) (NSError *error))failure
{
    [MagicalRecord saveUsingCurrentThreadContextWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        
        Domain *domain1 = [Domain createInContext:localContext];
        domain1.entityID = @"1";
        domain1.name = @"ACBreaker";
        domain1.instanceCount = @(20);
        
        Domain *domain2 = [Domain createInContext:localContext];
        domain2.entityID = @"2";
        domain2.name = @"ApplicationArchitecture";
        domain2.instanceCount = @(10);
        
        Domain *domain3 = [Domain createInContext:localContext];
        domain3.entityID = @"3";
        domain3.name = @"ACElectricalNetwork";
        domain3.instanceCount = @(24);
        
        Domain *domain4 = [Domain createInContext:localContext];
        domain4.entityID = @"4";
        domain4.name = @"Cage";
        domain4.instanceCount = @(10);
        
        Domain *domain5 = [Domain createInContext:localContext];
        domain5.entityID = @"5";
        domain5.name = @"Cabinet";
        domain5.instanceCount = @(15);
        
        Domain *domain6 = [Domain createInContext:localContext];
        domain6.entityID = @"6";
        domain6.name = @"Server";
        domain6.instanceCount = @(40);
        
        Attribute *attribute1 = [Attribute createInContext:localContext];
        attribute1.entityID = @"1";
        attribute1.name = @"AssetText";
        attribute1.type = @"String";
        attribute1.orderType = nil;
        attribute1.orderPriority = nil;
        attribute1.selected = @NO;
        attribute1.selectOrder = nil;
        attribute1.domain = domain6;
        
        Attribute *attribute2 = [Attribute createInContext:localContext];
        attribute2.entityID = @"2";
        attribute2.name = @"IP Address";
        attribute2.type = @"String";
        attribute2.orderType = nil;
        attribute2.orderPriority = nil;
        attribute2.selected = @NO;
        attribute2.selectOrder = nil;
        attribute2.domain = domain6;
        
        Attribute *attribute3 = [Attribute createInContext:localContext];
        attribute3.entityID = @"3";
        attribute3.name = @"OSSStatus";
        attribute3.type = @"String";
        attribute3.orderType = nil;
        attribute3.orderPriority = nil;
        attribute3.selected = @NO;
        attribute3.selectOrder = nil;
        attribute3.domain = domain6;
        
        Attribute *attribute4 = [Attribute createInContext:localContext];
        attribute4.entityID = @"4";
        attribute4.name = @"PublicPrivate";
        attribute4.type = @"Enum";
        attribute4.orderType = nil;
        attribute4.orderPriority = nil;
        attribute4.selected = @NO;
        attribute4.selectOrder = nil;
        attribute4.domain = domain6;
        
        AttributeTypeValue *attributeTypeValue1 = [AttributeTypeValue createInContext:localContext];
        attributeTypeValue1.entityID = @"1";
        attributeTypeValue1.name = @"Private";
        attributeTypeValue1.sequence = @1;
        attributeTypeValue1.attribute = attribute4;
        
        AttributeTypeValue *attributeTypeValue2 = [AttributeTypeValue createInContext:localContext];
        attributeTypeValue2.entityID = @"2";
        attributeTypeValue2.name = @"Public";
        attributeTypeValue2.sequence = @2;
        attributeTypeValue2.attribute = attribute4;
        
        Attribute *attribute5 = [Attribute createInContext:localContext];
        attribute5.entityID = @"5";
        attribute5.name = @"SinglePointOfFailure";
        attribute5.type = @"Bit";
        attribute5.orderType = nil;
        attribute5.orderPriority = nil;
        attribute5.selected = @NO;
        attribute5.selectOrder = nil;
        attribute5.domain = domain6;
        
        Attribute *attribute6 = [Attribute createInContext:localContext];
        attribute6.entityID = @"6";
        attribute6.name = @"Source";
        attribute6.type = @"String";
        attribute6.orderType = nil;
        attribute6.orderPriority = nil;
        attribute6.selected = @NO;
        attribute6.selectOrder = nil;
        attribute6.domain = domain6;
        
        Attribute *attribute7 = [Attribute createInContext:localContext];
        attribute7.entityID = @"7";
        attribute7.name = @"Is Gateway";
        attribute7.type = @"Bit";
        attribute7.orderType = nil;
        attribute7.orderPriority = nil;
        attribute7.selected = @NO;
        attribute7.selectOrder = nil;
        attribute7.domain = domain6;
        
        Domain *domain7 = [Domain createInContext:localContext];
        domain7.entityID = @"7";
        domain7.name = @"Domain ABC";
        domain7.instanceCount = @(20);
        
        Domain *domain8 = [Domain createInContext:localContext];
        domain8.entityID = @"8";
        domain8.name = @"Domain DEF";
        domain8.instanceCount = @(20);
        
        Domain *domain9 = [Domain createInContext:localContext];
        domain9.entityID = @"9";
        domain9.name = @"Domain GHI";
        domain9.instanceCount = @(20);
        
        Domain *domain10 = [Domain createInContext:localContext];
        domain10.entityID = @"10";
        domain10.name = @"Domain JKL";
        domain10.instanceCount = @(20);
        
        Domain *domain11 = [Domain createInContext:localContext];
        domain11.entityID = @"11";
        domain11.name = @"Domain MNO";
        domain11.instanceCount = @(20);
        
        Domain *domain12 = [Domain createInContext:localContext];
        domain12.entityID = @"12";
        domain12.name = @"Domain PQR";
        domain12.instanceCount = @(20);
        
        Domain *domain13 = [Domain createInContext:localContext];
        domain13.entityID = @"13";
        domain13.name = @"Domain STU";
        domain13.instanceCount = @(20);
        
        Domain *domain14 = [Domain createInContext:localContext];
        domain14.entityID = @"14";
        domain14.name = @"Domain VWX";
        domain14.instanceCount = @(20);
        
        Domain *domain15 = [Domain createInContext:localContext];
        domain15.entityID = @"15";
        domain15.name = @"Domain Ñ";
        domain15.instanceCount = @(20);
        
        Domain *domain16 = [Domain createInContext:localContext];
        domain16.entityID = @"16";
        domain16.name = @"Domain YZ";
        domain16.instanceCount = @(20);
        
        Domain *domain17 = [Domain createInContext:localContext];
        domain17.entityID = @"17";
        domain17.name = @"Domain 123";
        domain17.instanceCount = @(20);
        
        Domain *domain18 = [Domain createInContext:localContext];
        domain18.entityID = @"18";
        domain18.name = @"Domain 456";
        domain18.instanceCount = @(20);
        
        Domain *domain19 = [Domain createInContext:localContext];
        domain19.entityID = @"19";
        domain19.name = @"Domain 789";
        domain19.instanceCount = @(20);
    }];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([Domain countOfEntities] > 0) {
            if (completion) {
                completion([self domainsIndexedDictionary]);
            }
        }
        else {
            if (failure) {
                failure(self.defaultPublicError);
            }
        }
    });
}

- (NSDictionary *)domainsIndexedDictionary
{
    NSMutableDictionary *domainsDictionary = [NSMutableDictionary dictionary];
    NSArray *sortedDomains = [Domain findAll];
    
    for (Domain *domain in sortedDomains) {
        NSString *indexKey = [[domain.name substringToIndex:1] uppercaseString];
        NSMutableArray *indexDomains = nil;
        
        if (!(indexDomains = [domainsDictionary objectForKey:indexKey])) {
            indexDomains = [NSMutableArray new];
            [domainsDictionary setObject:indexDomains forKey:indexKey];
        }
        
        [indexDomains addObject:domain];
    }
    
    for (NSString *indexKey in domainsDictionary.allKeys) {
        NSMutableArray *indexDomains = [NSMutableArray arrayWithArray:[domainsDictionary objectForKey:indexKey]];
        [indexDomains sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:kSTIPoCNameAttributeKey ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]]];
        [domainsDictionary setObject:indexDomains forKey:indexKey];
    }
    
    return domainsDictionary;
}

@end
