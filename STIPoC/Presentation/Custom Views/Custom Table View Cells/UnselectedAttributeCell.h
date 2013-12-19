//
//  UnselectedAttributeCell.h
//  STIPoC
//
//  Created by Alex Gutierrez on 12/19/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kSTIPoCUnselectedAttributeCellIdentifier;

@interface UnselectedAttributeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
