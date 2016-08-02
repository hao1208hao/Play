//
//  DCSLocalWebViewVC.h
//  QiandaiPersonalV2
//
//  Created by weixiaoyang on 16/6/4.
//
//适用于本地导航控制器压栈

#import <UIKit/UIKit.h>

@interface DCSLocalWebViewVC : UIViewController

//webView加载的链接
@property (nonatomic,copy) NSString *linkUrl;

//webView加载链接时要拼接的参数
@property (nonatomic,strong) NSDictionary *inParams;

//是否转指示器
@property (nonatomic,assign) BOOL showHud;
@end
