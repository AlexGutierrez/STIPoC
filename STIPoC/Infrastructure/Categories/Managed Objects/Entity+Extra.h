//
//  Entity+Copy.h
//  STIPoC
//
//  Created by Alex Gutierrez on 12/19/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "Entity.h"

@interface Entity (Extra)

@property (strong, nonatomic) NSManagedObjectContext *currentLocalContext;

@end
