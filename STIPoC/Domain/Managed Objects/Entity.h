//
//  Domain.h
//  STIPoC
//
//  Created by Administrator on 11/20/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

extern NSString *const kSTIPoCEntityIDAttributeKey;

@interface Entity : NSManagedObject

/// The domain ID for this object
@property (nonatomic, retain) NSString * entityID;

@end
