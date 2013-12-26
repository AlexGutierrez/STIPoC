//
//  SelectedAttributeCell.m
//  STIPoC
//
//  Created by Alex Gutierrez on 12/26/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "SelectedAttributeCell.h"

NSString *const kSTIPoCSelectedAttributeCellIdentifier = @"SelectedAttributeCell";
NSString *const kSTIPoCSelectedAttributeWithFiltersCellIdentifier = @"SelectedAttributeWithFiltersCell";
NSString *const kSTIPoCSelectedOrderedAttributeCellIdentifier = @"SelectedOrderedAttributeCell";
NSString *const kSTIPoCSelectedOrderedAttributeWithFiltersCellIdentifier = @"SelectedOrderedAttributeWithFiltersCell";

static NSString *const kSTIPoCAttributeOrderTypeImageNone = @"OrderButtonNone.png";
static NSString *const kSTIPoCAttributeOrderTypeImageASC = @"OrderButtonASC.png";
static NSString *const kSTIPoCAttributeOrderTypeImageDESC = @"OrderButtonDESC.png";

@implementation SelectedAttributeCell

#pragma mark -
#pragma mark Public Methods

- (void)changeOrderTypeButtonImageWithAttributeOrderType:(AttributeOrderType)attributeOrderType
{
    UIImage *buttonImage = nil;
    
    if (attributeOrderType == AttributeOrderTypeNone) {
        buttonImage = [UIImage imageNamed:kSTIPoCAttributeOrderTypeImageNone];
    }
    else if (attributeOrderType == AttributeOrderTypeAsc) {
        buttonImage = [UIImage imageNamed:kSTIPoCAttributeOrderTypeImageASC];
    }
    else {
        buttonImage = [UIImage imageNamed:kSTIPoCAttributeOrderTypeImageDESC];
    }
    
    [self.orderTypeButton setImage:buttonImage forState:UIControlStateNormal];
    [self.orderTypeButton setImage:buttonImage forState:UIControlStateSelected];
    [self.orderTypeButton setImage:buttonImage forState:UIControlStateApplication];
    [self.orderTypeButton setImage:buttonImage forState:UIControlStateHighlighted];
}

#pragma mark -
#pragma mark IBActions

- (IBAction)changeOrderType:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(selectedAttributeCellDidChangeOrderType:)]) {
        [self.delegate selectedAttributeCellDidChangeOrderType:self];
    }
}

@end
