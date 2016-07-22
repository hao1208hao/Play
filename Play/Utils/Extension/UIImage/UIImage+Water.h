//
//  UIImage+Water.h
//  QiandaiPersonalV2
//
//  Created by weixiaoyang on 15/8/17.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (Water)
/**
 *  打水印
 *
 */
+ (instancetype)waterImageWithPath:(NSString *)imgPath logo:(NSString *)logo rect:(CGRect)rect;

+ (instancetype)waterImageWith:(NSData*)imgData logo:(NSString *)logo rect:(CGRect)rect;

//切图(切取图片为正方形）
+ (instancetype )rectImageWithImage:(UIImage *)img;

@end
