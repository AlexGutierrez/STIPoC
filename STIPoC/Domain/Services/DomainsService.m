//
//  DomainsService.m
//  STIPoC
//
//  Created by Alex Gutierrez on 12/18/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "DomainsService.h"
#import "Domain.h"

static NSString *const kSTIPoCNameAttributeKey = @"name";

@interface DomainsService ()

- (void)createDummyDomains;
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
            [self createDummyDomains];
            
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
        });
    }
}

#pragma mark -
#pragma mark Private Methods

- (void)createDummyDomains
{
    [MagicalRecord saveUsingCurrentThreadContextWithBlockAndWait:^(NSManagedObjectContext *localContext) {
       
        Domain *domain1 = [Domain createInContext:localContext];
        domain1.entityID = @"1";
        domain1.name = @"ACBreaker";
        domain1.maxCount = @(20);
        
        Domain *domain2 = [Domain createInContext:localContext];
        domain2.entityID = @"2";
        domain2.name = @"ApplicationArchitecture";
        domain2.maxCount = @(10);
        
        Domain *domain3 = [Domain createInContext:localContext];
        domain3.entityID = @"3";
        domain3.name = @"ACElectricalNetwork";
        domain3.maxCount = @(24);
        
        Domain *domain4 = [Domain createInContext:localContext];
        domain4.entityID = @"4";
        domain4.name = @"Cage";
        domain4.maxCount = @(10);
        
        Domain *domain5 = [Domain createInContext:localContext];
        domain5.entityID = @"5";
        domain5.name = @"Cabinet";
        domain5.maxCount = @(15);
        
        Domain *domain6 = [Domain createInContext:localContext];
        domain6.entityID = @"6";
        domain6.name = @"Company";
        domain6.maxCount = @(40);
        
        Domain *domain7 = [Domain createInContext:localContext];
        domain7.entityID = @"7";
        domain7.name = @"Domain ABC";
        domain7.maxCount = @(20);
        
        Domain *domain8 = [Domain createInContext:localContext];
        domain8.entityID = @"8";
        domain8.name = @"Domain DEF";
        domain8.maxCount = @(20);
        
        Domain *domain9 = [Domain createInContext:localContext];
        domain9.entityID = @"9";
        domain9.name = @"Domain GHI";
        domain9.maxCount = @(20);
        
        Domain *domain10 = [Domain createInContext:localContext];
        domain10.entityID = @"10";
        domain10.name = @"Domain JKL";
        domain10.maxCount = @(20);
        
        Domain *domain11 = [Domain createInContext:localContext];
        domain11.entityID = @"11";
        domain11.name = @"Domain MNO";
        domain11.maxCount = @(20);
        
        Domain *domain12 = [Domain createInContext:localContext];
        domain12.entityID = @"12";
        domain12.name = @"Domain PQR";
        domain12.maxCount = @(20);
        
        Domain *domain13 = [Domain createInContext:localContext];
        domain13.entityID = @"13";
        domain13.name = @"Domain STU";
        domain13.maxCount = @(20);
        
        Domain *domain14 = [Domain createInContext:localContext];
        domain14.entityID = @"14";
        domain14.name = @"Domain VWX";
        domain14.maxCount = @(20);
        
        Domain *domain15 = [Domain createInContext:localContext];
        domain15.entityID = @"15";
        domain15.name = @"Domain ABC";
        domain15.maxCount = @(20);
        
        Domain *domain16 = [Domain createInContext:localContext];
        domain16.entityID = @"16";
        domain16.name = @"Domain YZ";
        domain16.maxCount = @(20);
        
        Domain *domain17 = [Domain createInContext:localContext];
        domain17.entityID = @"17";
        domain17.name = @"Domain 123";
        domain17.maxCount = @(20);
        
        Domain *domain18 = [Domain createInContext:localContext];
        domain18.entityID = @"18";
        domain18.name = @"Domain 456";
        domain18.maxCount = @(20);
        
        Domain *domain19 = [Domain createInContext:localContext];
        domain19.entityID = @"19";
        domain19.name = @"Domain 789";
        domain19.maxCount = @(20);
    }];
}

- (NSDictionary *)domainsIndexedDictionary
{
    NSMutableDictionary *domainsDictionary = [NSMutableDictionary dictionary];
    NSArray *sortedDomains = [Domain findAllSortedBy:kSTIPoCNameAttributeKey ascending:YES];
    
    for (Domain *domain in sortedDomains) {
        NSString *indexKey = [domain.name substringToIndex:1];
        NSMutableArray *indexDomains = nil;
        
        if (!(indexDomains = [domainsDictionary objectForKey:indexKey])) {
            indexDomains = [NSMutableArray new];
            [domainsDictionary setObject:indexDomains forKey:indexKey];
        }
        
        [indexDomains addObject:domain];
    }
    
    return domainsDictionary;
}

@end
