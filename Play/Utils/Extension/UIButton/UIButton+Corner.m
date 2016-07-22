//
//  UIButton+Corner.m
//  qiandaibao_pos
//
//  Created by 亮亮 on 16/5/23.
//  Copyright © 2016年 钱袋宝. All rights reserved.
//

#import "UIButton+Corner.h"

@implementation UIButton (Corner)

-(void)cornerStyle{
    self.backgroundColor = GlobalNavColor;
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.layer.cornerRadius = 4;
    self.layer.masksToBounds = YES;
}

@end
