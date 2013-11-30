//
//  UIColor+VerizonColors.h
//  STIPoC
//
//  Created by Alex Gutierrez on 11/30/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface UIColor (VerizonColors)

+ (UIColor *)verizonDarkRed;
+ (UIColor *)verizonRed;
+ (UIColor *)verizonBlack;
+ (UIColor *)verizonGrey;
+ (UIColor *)verizonDarkGrey;
+ (UIColor *)verizonLightGrey;
+ (UIColor *)verizonTurquoise;
+ (UIColor *)verizonGreen;
+ (UIColor *)verizonYellow;
+ (UIColor *)verizonBlue;
+ (UIColor *)verizonBeige;
+ (UIColor *)verizonFucsia;
+ (UIColor *)verizonPurple;
+ (UIColor *)verizonLightBlue;

@end
