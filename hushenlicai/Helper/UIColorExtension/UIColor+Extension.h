//
//  UIColor+Extension.h
//  MiaoWo
//
//  Created by WPY on 2017/1/16.
//  Copyright © 2017年 WPY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)

/** 十六进制颜色 */
+ (UIColor *) colorWithHexString:(NSString *)hexString;
/** 十六进制颜色 透明度 */
+ (UIColor *) colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

@end
