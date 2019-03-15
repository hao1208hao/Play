//
//  UIView+Corner.h
//  Play
//
//  Created by haohao on 2019/3/15.
//  Copyright © 2019 haohao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,cornerStyle) {
    cornerStyleLeftTop = 0, //左上
    cornerStyleRightTop,      //右上
    cornerStyleLeftBottom,     //左下
    cornerStyleRightBottom,    //右下
    cornerStyleAll,      //all 全部
    cornerStyleLeftAll,   //全部左面
    cornerStyleRightAll,   //全部右面
    cornerStyleTopAll,   //全部上面
    cornerStyleBottomAll,    //全部下面
    cornerStyleNoLeftTop, //除去左上角
    cornerStyleNoRightTop, //除去右上角
    cornerStyleNoLeftBottom, //除去左下角
    cornerStyleNoRightBottom, //除去右下角
};

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Corner)

-(void)cornerStyle:(cornerStyle)cornerStyle cornerRadius:(CGFloat) radius;

@end

NS_ASSUME_NONNULL_END
