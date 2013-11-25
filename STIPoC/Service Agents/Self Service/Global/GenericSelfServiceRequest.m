//
//  GenericSelfServiceRequest.m
//  STIPoC
//
//  Created by Administrator on 11/22/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "GenericSelfServiceRequest.h"

@implementation GenericSelfServiceRequest

- (NSString *)SourceSystem
{
    return [SelfServiceEnumTranslator stringFromSourceSystem:SourceSystemCAP];
}

@end
