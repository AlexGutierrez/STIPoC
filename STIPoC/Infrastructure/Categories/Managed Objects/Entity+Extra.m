//
//  Entity+Copy.m
//  STIPoC
//
//  Created by Alex Gutierrez on 12/19/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "Entity+Extra.h"

static NSManagedObjectContext *_currentLocalContext;

@implementation Entity (Extra)

- (void)setCurrentLocalContext:(NSManagedObjectContext *)currentLocalContext
{
    if (_currentLocalContext != currentLocalContext) {
        _currentLocalContext = currentLocalContext;
    }
}

- (NSManagedObjectContext *)currentLocalContext
{
    return _currentLocalContext;
}

@end
