//
//  OrderSummaryCell.m
//  STIPoC
//
//  Created by Administrator on 11/28/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "OrderSummaryCell.h"

@implementation OrderSummaryCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    self.backgroundColor = selected? [UIColor redColor] : [UIColor whiteColor];
}

@end
