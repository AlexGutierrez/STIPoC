//
//  ResultsViewController.h
//  STIPoC
//
//  Created by Alex Gutierrez on 12/18/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "Domain.h"
#import "GenericViewController.h"

@interface ResultsViewController : GenericViewController

@property (nonatomic) int pageSize;
@property (nonatomic) int pageNumber;
@property (nonatomic, strong) Domain *domain;
@property (nonatomic, strong) NSArray *results;
@property (nonatomic, strong) NSArray *headAttributes;

@end
