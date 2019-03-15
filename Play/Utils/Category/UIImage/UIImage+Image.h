//
//  UIImage+Image.h
//  02-图片裁剪
//
//  Created by xiaomage on 15/6/19.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)
// 圆形裁剪
+ (UIImage *)imageWithClipImage:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)color;

// 控件截屏
+ (UIImage *)imageWithCaputureView:(UIView *)view;

@end
