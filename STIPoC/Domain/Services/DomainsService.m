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

+ (instancetype)sharedInstance
{
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self class] new];
    });
    return _sharedInstance;
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
