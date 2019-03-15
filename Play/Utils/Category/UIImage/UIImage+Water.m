//
//  UIImage+Water.m
//  QiandaiPersonalV2
//
//  Created by weixiaoyang on 15/8/17.
//
//

#import "UIImage+Water.h"

@implementation UIImage (Water)
+ (instancetype)waterImageWithPath:(NSString *)imgPath logo:(NSString *)logo rect:(CGRect)rect
{
    UIImage *bgImage = [UIImage imageWithData:[NSData dataWithContentsOfFile:imgPath]];
    
    // 1.创建一个基于位图的上下文(开启一个基于位图的上下文)
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    
    // 2.画背景
    [bgImage drawInRect:rect];
    
    // 3.画右下角的水印
    UIImage *waterImage = [UIImage imageNamed:logo];
    [waterImage drawInRect:rect];
    
    // 4.从上下文中取得制作完毕的UIImage对象
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 5.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (instancetype)waterImageWith:(NSData*)imgData logo:(NSString *)logo rect:(CGRect)rect
{
    UIImage *bgImage = [UIImage imageWithData:imgData];
    
    // 1.创建一个基于位图的上下文(开启一个基于位图的上下文)
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    
    // 2.画背景
    [bgImage drawInRect:rect];
    
    // 3.画右下角的水印
    UIImage *waterImage = [UIImage imageNamed:logo];
    [waterImage drawInRect:rect];
    
    // 4.从上下文中取得制作完毕的UIImage对象
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 5.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;

}
//切图
+ (instancetype )rectImageWithImage:(UIImage *)img
{
    // 1.加载原图
    UIImage *oldImage = img;
    
    // 2.开启上下文
    CGFloat imageW = oldImage.size.width;
    CGFloat imageH = oldImage.size.height;
    CGFloat min = imageH > imageW ? imageW:imageH;
    CGSize imageSize = CGSizeMake(min, min);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    // 3.取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //4.画矩形
    CGContextAddRect(ctx, CGRectMake(0, 0, imageW, imageW));
    CGContextClip(ctx);
    // 6.画图
    [oldImage drawInRect:CGRectMake(0, 0, oldImage.size.width, oldImage.size.width)];
    
    // 7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 8.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
