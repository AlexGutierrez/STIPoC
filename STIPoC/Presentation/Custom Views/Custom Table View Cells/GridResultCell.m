//
//  GridResultCell.m
//  STIPoC
//
//  Created by Arturo Gamarra on 2/01/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "GridResultCell.h"

NSString *const kSTIPoCGridHeaderAttributeCellIdentifier = @"GridHeaderCell";
NSString *const kSTIPoCGridDetailAttributeCellIdentifier = @"GridDetailCell";

@interface GridResultCell()

#define LABEL_MAX_WIDTH 200
#define LABEL_MIN_WIDTH 80

@end

@implementation GridResultCell

- (void)setValues:(NSArray *)values{
    if (_values != values) {
        _values = values;
        [self createLabelsForValues];
    }
}

-(void)updateConstraints
{
    for (UILabel *label in self.contentView.subviews) {
        label.translatesAutoresizingMaskIntoConstraints = NO; //important
        
        NSLayoutConstraint* c1 = [NSLayoutConstraint constraintWithItem:label
                                                              attribute:NSLayoutAttributeBottom
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.contentView
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1
                                                               constant:-10];
        
        NSLayoutConstraint* c2 = [NSLayoutConstraint constraintWithItem:label
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.contentView
                                                              attribute:NSLayoutAttributeTop
                                                             multiplier:1
                                                               constant:10];
        
        NSLayoutConstraint* c3 = [NSLayoutConstraint constraintWithItem:label
                                                              attribute:NSLayoutAttributeLeft
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.contentView
                                                              attribute:NSLayoutAttributeLeft
                                                             multiplier:1
                                                               constant:label.frame.origin.x];
        
        [self.contentView addConstraint:c1];
        [self.contentView addConstraint:c2];
        [self.contentView addConstraint:c3];
    }
    [super updateConstraints];
}

#pragma mark -
#pragma Private Methods
- (void)createLabelsForValues
{
    [self.valueLabel removeFromSuperview];
    if ([self.values count] != 0) {
        for (int i=0; i < [self.values count]; i++) {
            UILabel *label = [self cloneLabel:self.valueLabel];
            label.text = [self.values objectAtIndex:i];
            label.frame = CGRectMake(label.frame.origin.x + (label.frame.size.width + 5) * i, label.frame.origin.y, label.frame.size.width, label.frame.size.height);
            [self.contentView addSubview:label];
        }
    }
}

- (UILabel *)cloneLabel:(UILabel *)label {
    UILabel *clonedLabel = [[UILabel alloc] initWithFrame:label.frame];
    clonedLabel.textColor = label.textColor;
    clonedLabel.lineBreakMode = label.lineBreakMode;
    clonedLabel.numberOfLines = label.numberOfLines;
    clonedLabel.font = label.font;
    clonedLabel.minimumScaleFactor = label.minimumScaleFactor;
    clonedLabel.adjustsFontSizeToFitWidth = label.adjustsFontSizeToFitWidth;
    clonedLabel.preferredMaxLayoutWidth = label.preferredMaxLayoutWidth;
    return clonedLabel;
}

- (CGRect)getTextLabelRectFromText:(NSString *)text withMaxWith:(float)maxWidth
{
    self.valueLabel.text = text;
    return [self.valueLabel.text boundingRectWithSize:CGSizeMake(maxWidth, 0)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{NSFontAttributeName:self.valueLabel.font}
                                              context:nil];
}

#pragma mark -
#pragma Public Methods
- (int)calculatePreferedHeightForValues:(NSArray *)values;
{
    int heightFactor = 1;
    
    for (NSString *value in values) {
        CGRect r = [self getTextLabelRectFromText:value withMaxWith:self.valueLabel.frame.size.width];
        float newHeightFactor = r.size.height / self.valueLabel.frame.size.height;
        heightFactor = (newHeightFactor > heightFactor) ? (int)round(newHeightFactor) : heightFactor;
    }
    return self.frame.size.height * heightFactor;
}

- (float)calculatePreferedWidthForValues:(NSArray *)values
{
    float width = 5;
    for (NSString *value in values) {
        CGRect r = [self getTextLabelRectFromText:value withMaxWith:LABEL_MAX_WIDTH];
        width += 5 + ((r.size.width > LABEL_MAX_WIDTH) ? LABEL_MAX_WIDTH : self.valueLabel.frame.size.width);//r.size.width
    }
    return width;
}

@end
