//
//  SelectedAttributeCell.h
//  STIPoC
//
//  Created by Alex Gutierrez on 12/26/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kSTIPoCSelectedAttributeCellIdentifier;
extern NSString *const kSTIPoCSelectedAttributeWithFiltersCellIdentifier;
extern NSString *const kSTIPoCSelectedOrderedAttributeCellIdentifier;
extern NSString *const kSTIPoCSelectedOrderedAttributeWithFiltersCellIdentifier;

@interface SelectedAttributeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextView *filtersTextView;
@property (weak, nonatomic) IBOutlet UIButton *orderTypeButton;
@property (weak, nonatomic) IBOutlet UIButton *editFiltersButton;
@property (weak, nonatomic) IBOutlet UIButton *orderPriorityButton;


@end
