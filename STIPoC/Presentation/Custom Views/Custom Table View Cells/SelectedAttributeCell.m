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

@implementation SelectedAttributeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
