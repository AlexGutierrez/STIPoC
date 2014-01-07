//
//  GridResultCell.h
//  STIPoC
//
//  Created by Arturo Gamarra on 2/01/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kSTIPoCGridHeaderAttributeCellIdentifier;
extern NSString *const kSTIPoCGridDetailAttributeCellIdentifier;

@interface GridResultCell : UITableViewCell

@property (strong, nonatomic) NSArray *values;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

- (int)calculatePreferedHeightForValues:(NSArray *)values;
- (float)calculatePreferedWidthForValues:(NSArray *)values;

@end
