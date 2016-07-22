//
//  QDBTabBarVC.m
//
//
//  Created by zhongad on 15/12/19.
//  Copyright © 2015年 zhongad. All rights reserved.
//

#import "QDBTabBarVC.h"
#import "QDBNavController.h"
#import "ViewController.h"


@interface QDBTabBarVC ()

@end

@implementation QDBTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化所有的子控制器
    [self setupAllChildViewControllers];
    
    self.tabBar.tintColor = GlobalNavColor;
}

/**
 *  初始化所有的子控制器
 */
- (void)setupAllChildViewControllers
{
    //0.首页
     ViewController * home = [[ViewController alloc]init];

    [self setupChildViewController:home title:@"首页" imageName:@"1" selectedImageName:@"1"];
//    //1.交易记录
//    
//    QDBTransRecordViewController *transRecordVc = [[QDBTransRecordViewController alloc]init];
//
    [self setupChildViewController:home title:@"交易记录" imageName:@"1" selectedImageName:@"1"];
//
//    //2.更多
//    QDBMoreViewController *moreVc = [[QDBMoreViewController alloc]init];
//    [self setupChildViewController:moreVc title:@"更多" imageName:@"more" selectedImageName:@"more_sel"];

    
}

/**
 *  初始化一个子控制器
 *
 *  @param childVc           需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    // 1.设置控制器的属性
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 2.包装一个导航控制器
    QDBNavController *nav = [[QDBNavController alloc] initWithRootViewController:childVc];
    childVc.view.backgroundColor = GlobalBackgroundColor;
    nav.view.backgroundColor = GlobalBackgroundColor;
    [self addChildViewController:nav];
}

@end
