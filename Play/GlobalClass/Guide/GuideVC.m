//
//  GuideVC.m
//  Play
//
//  Created by haohao on 16/7/25.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import "GuideVC.h"
#import "QDBTabBarVC.h"

#define totalCounts 3  //引导页数量

@interface GuideVC ()<UIScrollViewDelegate>

@property (strong, nonatomic)  UIScrollView *pageScroll;
@property (strong, nonatomic)  UIPageControl *pageControl;

@end

@implementation GuideVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createScrollView];
}

/**
 *  创建显示引导图片ScrollView
 */
-(void)createScrollView{
    
    self.pageScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.pageScroll.pagingEnabled = YES;
    self.pageScroll.delegate = self;
    self.pageScroll.contentSize = CGSizeMake(SCREEN_WIDTH * totalCounts, SCREEN_HEIGHT);
    self.pageScroll.backgroundColor = [UIColor whiteColor];
    self.pageScroll.showsHorizontalScrollIndicator = NO;
    self.pageScroll.showsVerticalScrollIndicator = YES;
    [self.view addSubview:self.pageScroll];
    
    /** 添加引导图片 */
    [self AddGuideImg];
    
    CGFloat w = 100;
    CGFloat h = 20;
    self.pageControl = [[UIPageControl alloc]init];
    [self.pageControl setFrame:CGRectMake((SCREEN_WIDTH-w)/2, SCREEN_HEIGHT-30, w, h)];
    self.pageControl.numberOfPages = totalCounts;  //设置引导页有几个界面
    self.pageControl.currentPage = 0;
    self.pageControl.tintColor = [UIColor lightGrayColor];
    [self.view addSubview:self.pageControl];
    
}

/**
 *  添加引导图片
 */
-(void)AddGuideImg{    
    for (int i=0; i<totalCounts; i++) {
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        NSString* imageNameStr =[NSString stringWithFormat:@"Guide%i.jpg",i+1];
        
        imageView.image = [UIImage imageNamed:imageNameStr];
        
        if (i == totalCounts-1) {
            /** 最后一张图片添加按钮 */
            [imageView setUserInteractionEnabled:YES];
            UIButton* start = [UIButton buttonWithType:UIButtonTypeCustom];
            UIImage* startBtnImg = [UIImage imageNamed:@"btn"];
            [start setImage:startBtnImg forState:UIControlStateNormal];
            
            [start setFrame:CGRectMake(SCREEN_WIDTH-20-startBtnImg.size.width, SCREEN_HEIGHT-25-startBtnImg.size.height, startBtnImg.size.width, startBtnImg.size.height)];
            
            [start addTarget:self action:@selector(gotoMainView) forControlEvents:
             UIControlEventTouchUpInside];
            [imageView addSubview:start];
            
        }
        [self.pageScroll addSubview:imageView];
    }
    
}

/** 跳转到首页 */
-(void)gotoMainView{
    QDBTabBarVC *mainTabbar = [[QDBTabBarVC alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = mainTabbar;
}

#pragma mark - UIScrollViewDelegate
#pragma mark
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.view.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}


@end
