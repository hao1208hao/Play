//
//  HHShowImage.m
//  Play
//
//  Created by haohao on 2017/8/30.
//  Copyright © 2017年 haohao. All rights reserved.
//

#import "HHShowImage.h"

@implementation HHShowImage

-(id)initWithImage:(UIImage*)img{
    CGRect mainFrame=[[UIScreen mainScreen] bounds];
    self=[super initWithFrame:mainFrame];
    if(self){
        [self setBackgroundColor:[UIColor colorWithRed:100/255.0f green:100/255.0f blue:100/255.0f alpha:0.8f]];
        
        
        CGSize containerSize=CGSizeMake(290, img.size.height/2);
        CGPoint containerPoint=CGPointMake(mainFrame.size.width/2-containerSize.width/2, mainFrame.size.height/2-containerSize.height/2);
        
        
        UIView* containerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, containerSize.width, containerSize.height)];
        
        UIImageView* imgView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 270, img.size.height/2)];
        [imgView setImage:img];
        [containerView addSubview:imgView];
        
        
        UIView* frameView=[[UIView alloc] initWithFrame:CGRectMake(containerPoint.x, containerPoint.y, containerSize.width, containerSize.height+50)];
        [frameView setBackgroundColor:[UIColor whiteColor]];
        
        
        [frameView addSubview:containerView];
        
        
        UIButton* btnOk=[UIButton buttonWithType:UIButtonTypeSystem];
        [btnOk setFrame:CGRectMake(0, containerSize.height, containerSize.width, 50)];
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
