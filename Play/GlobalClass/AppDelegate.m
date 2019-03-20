//
//  AppDelegate.m
//  Play
//
//  Created by haohao on 16/7/8.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import "AppDelegate.h"
#import "QDBTabBarVC.h"
#import "GuideVC.h"
#import "VideoLoginVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    //开启定位
    [[QDBLocation sharedinstance] startLocationMonitor];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = GlobalNavColor;
    application.statusBarHidden = NO;
    application.statusBarStyle = UIStatusBarStyleLightContent;    
    
    /** 是否想要显示引导页----demo 设置每次都显示引导页 */
    BOOL showGuide = true;
    if (showGuide) {
        GuideVC* guide = [[GuideVC alloc]init];
        VideoLoginVC* video = [[VideoLoginVC alloc]init];
        self.window.rootViewController = video;
    }else{
        QDBTabBarVC *tabbar = [[QDBTabBarVC alloc] init];
        //QDBNavController * nav = [[QDBNavController alloc]initWithRootViewController:tabbar];
        self.window.rootViewController = tabbar;
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
