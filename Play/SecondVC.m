//
//  SecondVC.m
//  Play
//
//  Created by haohao on 16/7/25.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import "SecondVC.h"
#import "ShareVC.h"

@interface SecondVC ()

@end

@implementation SecondVC

- (void)viewDidLoad {
    [super viewDidLoad];    
    
    //创建View
    [self createView];
    
}

/**
 *  创建当前展示View
 */
-(void)createView{
    
    
    /** 跳转分享按钮 */
    UIButton* shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    int x = 20;
    int h = 40;
    [shareBtn setFrame:CGRectMake(x, 150, SCREEN_WIDTH-x*2, h)];
    [shareBtn setTitle:@"跳转分享" forState:UIControlStateNormal];
    shareBtn.layer.cornerRadius = 4;
    [shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shareBtn setBackgroundColor:GlobalNavColor];
    [shareBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
    
}


/**
 *  分享按钮点击
 */

-(void)shareAction{
    ShareVC* share = [[ShareVC alloc]init];
    share.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:share animated:YES];
}


@end
