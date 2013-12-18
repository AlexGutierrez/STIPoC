//
//  DomainCell.h
//  STIPoC
//
//  Created by Alex Gutierrez on 12/18/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kSTIPoCDomainCellIdentifier;

@interface DomainCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
