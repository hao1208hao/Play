//
//  SecondVC.m
//  Play
//
//  Created by haohao on 16/7/25.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import "SecondVC.h"
#import "ShareVC.h"
#import "HHScrollView.h"

#define btnTop  100   //第一个矩形距上高度
#define btnWidth  50   //按钮宽和高
#define btnSpace  15   //按钮间距

@interface SecondVC ()

@end

@implementation SecondVC

- (void)viewDidLoad {
    [super viewDidLoad];    
    
    //创建View
    //
    self.title = @"Second";
    [self createBtnUI]; // 图形部分逻辑
    
    [self createView];
}

//矩形部分UI 展示
-(void)createBtnUI{
    NSArray* arr = @[@"下拉",@"1",@"2",@"3",@"4",@"5"];
    for (int i = 0; i <= 2; i++){
        for(int j=1;j<=i+1;j++){
            UIButton* btn = [self createBtn];
            [btn setTitle:arr[j-1+i] forState:UIControlStateNormal];
            
            int topOffset = 100+btnWidth*i+btnSpace*i; //计算距上高度
            int left = (SCREEN_WIDTH-(i+1)*btnWidth-i*btnSpace)/2; //计算左右两侧的距离
            int leftOffset = left+(j-1)*btnWidth+(j-1)*btnSpace; //计算距左距离
            CGSize size = CGSizeMake(btnWidth, btnWidth); //按钮大小
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view).offset(topOffset);
                make.leading.equalTo(self.view).offset(leftOffset);
                make.size.mas_equalTo(size);
            }];
        }
    }
}

//创建按钮
-(UIButton*)createBtn{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    return btn;
}

//按钮点击事件处理
-(void)change:(id)sender{
    UIButton* btn = (UIButton*)sender;
    if([btn.titleLabel.text isEqualToString:@"下拉"]){
        HHScrollView * scroll = [[HHScrollView alloc]init];
        [self.navigationController pushViewController:scroll animated:YES];
    }
    /*
    CGFloat width = btn.frame.size.width;
    btn.layer.cornerRadius = width/2.0;
    btn.layer.masksToBounds = YES;
    [btn setBackgroundColor:[UIColor greenColor]];
     */
}


/**
 *  创建当前展示View
 */
-(void)createView{
    
    
    /** 跳转分享按钮 */
    UIButton* shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    int x = 20;
    int h = 40;
    [shareBtn setFrame:CGRectMake(x, 450, SCREEN_WIDTH-x*2, h)];
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
