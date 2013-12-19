//
//  Entity.h
//  STIPoC
//
//  Created by Alex Gutierrez on 12/19/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

extern NSString *const kSTIPoCEntityIDAttributeKey;

@interface Entity : NSManagedObject

@property (nonatomic, retain) NSString * entityID;

@end
