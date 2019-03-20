//
//  GuideVC.m
//  Play
//
//  Created by haohao on 16/7/25.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import "GuideVC.h"
#import "QDBTabBarVC.h"

#import "GuideGradualVC.h"


@interface GuideVC ()<UIScrollViewDelegate>

@property (strong, nonatomic)  UIScrollView *pageScroll;
@property (strong, nonatomic)  UIPageControl *pageControl;

@property (nonatomic, strong) GuideGradualVC *introductionView; 


@end

@implementation GuideVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self createScrollView];
    
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    // Added Introduction View Controller
    NSArray *coverImageNames = @[@"img_index_01txt", @"img_index_02txt", @"img_index_03txt"];
    
    
    NSArray *backgroundImageNames = @[@"img_index_01bg", @"img_index_02bg", @"img_index_03bg"];
    
    self.introductionView = [[GuideGradualVC alloc] initWithCoverImageNames:coverImageNames backgroundImageNames:backgroundImageNames];
    
    
    // Example 1 : Simple
     //self.introductionView = [[GuideGradualVC alloc] initWithCoverImageNames:backgroundImageNames];
    
    // Example 2 : Custom Button
    //UIButton *enterButton = [UIButton new];
    //[enterButton setBackgroundImage:[UIImage imageNamed:@"bg_bar"] forState:UIControlStateNormal];
    //self.introductionView = [[ZWIntroductionViewController alloc] initWithCoverImageNames:coverImageNames backgroundImageNames:backgroundImageNames button:enterButton];
    
    
    [self.view addSubview:self.introductionView.view];
    
    __weak GuideVC *weakSelf = self;
    
    self.introductionView.didSelectedEnter = ^() {
        weakSelf.introductionView = nil;
        [weakSelf gotoMainView];
    };
    
}


/** 跳转到首页 */
-(void)gotoMainView{
    QDBTabBarVC *mainTabbar = [[QDBTabBarVC alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = mainTabbar;
}
 
@end
