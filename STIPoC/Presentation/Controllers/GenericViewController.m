//
//  GenericViewController.m
//  STIPoC
//
//  Created by Administrator on 11/12/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "GenericViewController.h"

@interface GenericViewController ()

@end

@implementation GenericViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

#if DEBUG

    DDLogWarn(@"Memory Warning Detected! - %@", [self class]);
    
#endif
    
}

@end
