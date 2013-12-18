//
//  Domain.h
//  STIPoC
//
//  Created by Alex Gutierrez on 12/18/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Entity.h"

@interface Domain : Entity

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * maxCount;

@end
