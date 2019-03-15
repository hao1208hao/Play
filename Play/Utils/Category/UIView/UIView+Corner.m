//
//  UIView+Corner.m
//  Play
//
//  Created by haohao on 2019/3/15.
//  Copyright © 2019 haohao. All rights reserved.
//

#import "UIView+Corner.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (Corner)

-(void)cornerStyle:(cornerStyle)cornerStyle cornerRadius:(CGFloat) radius{
    
    UIRectCorner corners;
    
    switch ( cornerStyle )
    {
        case cornerStyleLeftTop:
            corners = UIRectCornerTopLeft;
            break;
        case cornerStyleRightTop:
            corners = UIRectCornerTopRight;
            break;
        case cornerStyleLeftBottom:
            corners = UIRectCornerBottomLeft;
            break;
        case cornerStyleRightBottom:
            corners = UIRectCornerBottomRight;
            break;
        case cornerStyleTopAll:
            corners = UIRectCornerTopLeft | UIRectCornerTopRight;
            break;
        case cornerStyleBottomAll:
            corners = UIRectCornerBottomLeft | UIRectCornerBottomRight;
            break;
        case cornerStyleLeftAll:
            corners = UIRectCornerTopLeft | UIRectCornerBottomLeft;
            break;
        case cornerStyleRightAll:
            corners = UIRectCornerTopRight | UIRectCornerBottomRight;
            break;
        case cornerStyleAll:
            corners = UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight;
            break;
        case cornerStyleNoLeftTop:
            corners = UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight;
            break;
        case cornerStyleNoRightTop:
            corners = UIRectCornerTopLeft  | UIRectCornerBottomLeft | UIRectCornerBottomRight;
            break;
            
        case cornerStyleNoLeftBottom:
            corners = UIRectCornerTopLeft | UIRectCornerTopRight  | UIRectCornerBottomRight;
            break;
            
        case cornerStyleNoRightBottom:
            corners = UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft ;
            break;
            
        default:
            corners = UIRectCornerAllCorners;
            break;
    }
    
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(radius*2, radius*2)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame         = self.bounds;
    maskLayer.path          = maskPath.CGPath;
    self.layer.mask         = maskLayer;
}


@end
