//
//  PaddingTextField.m
//  STIPoC
//
//  Created by Alex Gutierrez on 11/30/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "PaddingTextField.h"

@implementation PaddingTextField

#pragma mark -
#pragma mark Overriden Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder]) {
        [self setValue:[UIColor verizonLightGrey] forKeyPath:@"_placeholderLabel.textColor"];
    }
    
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect textRect = [super textRectForBounds:bounds];
    textRect.origin.x += 10;
    textRect.size.width -= 20;
    return textRect;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

@end
