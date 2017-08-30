//
//  HHShowImage2.m
//  Play
//
//  Created by haohao on 2017/8/30.
//  Copyright © 2017年 haohao. All rights reserved.
//

#import "HHShowImage2.h"

#define left 20

@implementation HHShowImage2


-(id)initWithImage:(UIImage*)img{
    CGRect mainFrame=[[UIScreen mainScreen] bounds];
    self=[super initWithFrame:mainFrame];
    if(self){
        [self setBackgroundColor:[UIColor colorWithRed:100/255.0f green:100/255.0f blue:100/255.0f alpha:0.8f]];
        
        CGFloat width = mainFrame.size.width-left*2;
        CGFloat height = img.size.height;
        CGFloat top = (mainFrame.size.height-height)/2;
        
        UIView* frameView=[[UIView alloc] initWithFrame:CGRectMake(left, top, width, height+50)];
        [frameView setBackgroundColor:[UIColor whiteColor]];
        
        CGFloat imgLeft = 10;
        CGFloat imgTop = 10;
        CGFloat imgWidth = width-imgLeft*2;
        CGFloat imgHeight = height-imgTop;
        
        UIImageView* imgView=[[UIImageView alloc] initWithFrame:CGRectMake(imgLeft, imgTop, imgWidth, imgHeight)];
        [imgView setImage:img];
        [frameView addSubview:imgView];
        
        UIButton* btnOk=[UIButton buttonWithType:UIButtonTypeSystem];
        [btnOk setFrame:CGRectMake(0, height, width, 50)];
        [btnOk setTitle:@"确定" forState:UIControlStateNormal];
        [frameView addSubview:btnOk];
        [btnOk addTarget:self action:@selector(onOk:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:frameView];
    }
    return self;
}

-(void)onOk:(id)sender{
    [self removeFromSuperview];
}

-(void)showInView:(UIView*)view{
    [view addSubview:self];
}


@end
