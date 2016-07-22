//
//  QDBMacros.h
//  qiandaibao_pos
//
//  Created by haohao on 16/5/7.
//  Copyright © 2016年 钱袋宝. All rights reserved.
//

#ifndef QDBMacros_h
#define QDBMacros_h

#pragma mark - 辅助方法
#pragma mark
#define dictToJson(dict) [QDBInfo dictToJson:dict]
#define jsonToArray(jsonStr) [QDBInfo jsonToArray:jsonStr]
//如果值为nil 传空
#define NotNil(value) value?:@""
//忽略大小写比较字符串
#define ignoreCompare(str,str2) [str compare:str2                         options:NSCaseInsensitiveSearch ] == NSOrderedSame

#pragma mark - 尺寸相关
#pragma mark

// 屏幕相关尺寸
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
// iPhone6屏幕宽度
#define SCREEN_WIDTH6 375.0f
// 适配比率
#define RATIO ([UIScreen mainScreen].bounds.size.width) / SCREEN_WIDTH6

// 导航栏高度
#define NAV_HEIGHT 44.0f
#define STATES_HEIGHT 20.0f
#define TAB_HEIGHT 49.0f
#define NavAndStatus_HEIGHT 64.0f


#pragma mark - 颜色相关
#pragma mark

#define UIColorFromRGB(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]

#define UIColorFromHex(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:1.0f]

#define UIColorFromHexA(rgbValue, a) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:a * 1.0f]

// 全局的文本高亮状态时的颜色
#define GlobalTextHighColor UIColorFromHexA(0xffffff, 0.5)

// 全局导航栏颜色
#define GlobalNavColor UIColorFromHex(0x007be6)

// 全局背景颜色
#define GlobalBackgroundColor UIColorFromHex(0xf7f7f7)

#define QDBImage(imageName) [UIImage imageNamed:imageName]

#pragma mark - 系统版本
#pragma mark

// 判断版本是否是7.0及以上
#define iOS7  ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
// 判断版本是否是8.0及以上
#define iOS8  ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)

// 自定义Log
#ifdef DEBUG
#define QDBLog(...) NSLog(__VA_ARGS__)
#else
#define QDBLog(...)
#endif

#pragma mark - 版本信息及硬件
#pragma mark
//获取版本及硬件信息
#define sysVersion [QDBInfo getSystemVersion]  //获取系统版本
#define dcs_appVersion [QDBInfo formatAppVersion]  //appVersion
#define deviceID [QDBInfo getDeviceID]    //获取手机唯一标识 UUID
#define deviceModel [QDBInfo getDeviceModel]   // 获取手机类型  iPhone5s
#define terminalInfo [QDBInfo getTerminalInfo]  //获取终端信息
#define QDBNetUseFul [QDBInfo isNetworkUseful]  //网络是否可用
#define QDBNetType [QDBInfo getNetType]  //获取当前网络连接类型 wifi/4G/3G
#define QDBGetLocation [[QDBLocation sharedinstance] getLocation] //获取定位json串
#define QDBGetLongitude [[QDBLocation sharedinstance] getLongitude]  //获取经度
#define QDBGetLatitude [[QDBLocation sharedinstance] getLatitude]  //获取纬度
#define QDBMD5(str) [QDBInfo md5:str]  //md5
#define QDBGetIpAddr [QDBInfo getIPAddress]  //获取连接网络的IP
#define QDBGetMacAddr [QDBInfo getMacAddress]  //获取mac地址
#define QDBGetImgByColor(color) [QDBInfo buttonImageFromColor:color]  //获取图片

#define userDefaults [NSUserDefaults standardUserDefaults]
#define userDefaultsForKey(Key) [[NSUserDefaults standardUserDefaults] objectForKey:Key]

// UIApplication对象
#define QDBApplication [UIApplication sharedApplication]
#define QDBAppDelegate (AppDelegate *)[[UIApplication sharedApplication] delegate]
#define QDBWindow [[[UIApplication sharedApplication] delegate] window]


#pragma mark - 提示相关
#pragma mark

#define QDBAlertView [QDBAlert shareAlertTool]

// 提示框alert(带自定义标题)
#define QDBAlertWithTitle(_title_, _msg_)  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_title_ message:_msg_ delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];\
[alert show];

// 提示框alert(带“提示”标题)
#define CommonAlert(_msg_) QDBAlertWithTitle(@"提示", _msg_)

#endif /* macros_h */
