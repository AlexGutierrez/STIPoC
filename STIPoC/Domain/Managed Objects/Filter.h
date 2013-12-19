//
//  Filter.h
//  STIPoC
//
//  Created by Alex Gutierrez on 12/19/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Entity.h"

@class Attribute;

@interface Filter : Entity

@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSString * value;
@property (nonatomic, retain) Attribute *attribute;

@end
