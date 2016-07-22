//
//  DCSLocalWebViewVC.m
//  QiandaiPersonalV2
//
//  Created by weixiaoyang on 16/6/4.
//
//

#import "DCSLocalWebViewVC.h"
#import "MBProgressHUD.h"
#import "UIBarButtonItem+AD.h"

@interface DCSLocalWebViewVC ()<UIWebViewDelegate>

@property (nonatomic,strong) UIWebView *web;

@property (nonatomic,weak) UIImageView *loadErrorImgView;

@property (nonatomic,copy) NSURL *currentLoadingURL;

@property (nonatomic,weak) UIView *errorView;
@end

@implementation DCSLocalWebViewVC
@synthesize web;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBaseUI];
}
//初始化UI
-(void)setupBaseUI
{
    //加载失败的图片
    UIView *errorView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, 155, 170)];
    [self.view addSubview:errorView];
    self.errorView = errorView;
    UIImage *errorImg = [UIImage imageNamed:@"webLoadError"];
    UIImageView *loadErrorImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 155, 130)];
    loadErrorImgView.image = errorImg;
    loadErrorImgView.center = CGPointMake(SCREEN_WIDTH*0.5,60);
    [errorView addSubview:loadErrorImgView];
    //重新加载按钮
    UIButton *reloadBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    reloadBtn.center = CGPointMake(SCREEN_WIDTH*0.5, 150);
    [errorView addSubview:reloadBtn];
    [reloadBtn setBackgroundImage:[UIImage imageNamed:@"reload_bg"] forState:UIControlStateNormal];
    [reloadBtn addTarget:self action:@selector(tapErrorImg) forControlEvents:UIControlEventTouchUpInside];
    //初始化webView
    web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    web.scrollView.bounces = NO;
    web.scrollView.showsVerticalScrollIndicator = NO;
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    web.delegate = self;
    [self.view addSubview:web];
    //加载链接
    if (_linkUrl.length) {
        NSURLRequest *request = nil;
        if (_inParams != nil) {
            //带参数的请求
            NSMutableDictionary * mdic = [NSMutableDictionary dictionary];
            //添加通用参数.
            [mdic setObject:NotNil(deviceID) forKey:@"appImei"];
            
            NSString* userAgent = [QDBUserInfo sharedUserInfo].userAgent;
            NSString* agentTicket = [QDBUserInfo sharedUserInfo].agentTicket;
            
            [mdic setObject:dcs_appVersion forKey:@"appVersion"];
            [mdic setObject:agentTicket forKey:@"ticket"];
            [mdic setObject:NotNil(QDBGetIpAddr) forKey:@"IP"];
            [mdic setObject:@"" forKey:@"appNO"];
            [mdic setObject:userAgent forKey:@"merchantNo"];
            [mdic setObject:@"shanghuban" forKey:@"channel"];
            [mdic setObject:sysVersion forKey:@"appSystemNO"];
            [mdic setObject:deviceModel forKey:@"appType"];
            [mdic setObject:fzfChannel forKey:@"webChannel"];
            [mdic setObject:@"ios" forKey:@"platform"];
            
            [mdic addEntriesFromDictionary:_inParams];
            
            NSData * data = [NSJSONSerialization dataWithJSONObject:mdic options:0 error:nil];
            //req的值
            NSString *jsonString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            //计算签名

            //NSString * sign = QDBMD5(jsonString);

            //拼接url,对req编码
            QDBLog(@"--webView加载的参数:%@",jsonString);
            jsonString  = [self encodeToPercentEscapeString:jsonString];
            NSString * fullURL = [NSString stringWithFormat:@"%@&req=%@",_linkUrl,jsonString];
            QDBLog(@"--webView加载的完整URL:%@",fullURL);
            request = [NSURLRequest requestWithURL:[NSURL URLWithString:fullURL]];
        }else{
            //不带参数的请求
            request = [NSURLRequest requestWithURL:[NSURL URLWithString:_linkUrl]];
        }
        [web loadRequest:request];
    }
    
    [self checkLeftBtnNeedHidden];
}
//重新加载网页
-(void)tapErrorImg
{
    //隐藏重新加载图片
    [self.view insertSubview:self.errorView belowSubview:self.web];
    
//    [self.webView reload];
    //重新加载当前请求网页
    [self.web loadRequest:[NSURLRequest requestWithURL:self.currentLoadingURL]];
}
//检查是否显示返回按钮
-(void)checkLeftBtnNeedHidden
{
    if (web.canGoBack) {
        //能返回 显示左侧返回按钮
        
        UIBarButtonItem *left = [UIBarButtonItem itemWithBackTarget:self action:@selector(leftBtnClicked)];
        UIBarButtonItem * space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem * right = [UIBarButtonItem itemWithIcon:@"关闭" highIcon:@"关闭" target:self action:@selector(rightBtnClicked)];
            UIBarButtonItem * space2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//            UIBarButtonItem * space3 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//            UIBarButtonItem * space4 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        self.navigationItem.leftBarButtonItems = @[left,space,right,space2/*,space3,space4*/];
//        QDBLog(@"can go back!");
    }else{
        UIBarButtonItem *right = [UIBarButtonItem itemWithBackTarget:self action:@selector(rightBtnClicked)];
        self.navigationItem.leftBarButtonItems = @[right];
//        QDBLog(@"不能 go back!");
    }
}

-(void)leftBtnClicked
{
    //返回之前加载的网页
    [web goBack];
}


-(void)rightBtnClicked
{
    //关闭当前控制器
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIWebViewDelegate

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([request.URL.absoluteString isEqualToString:@"app://close"]) {
        [self rightBtnClicked];
        //发出通知刷新交易记录(加急结算后刷新交易记录)
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center postNotificationName:@"reloadRecord" object:nil];
        
        return NO;
    }else{
        self.currentLoadingURL = request.URL;
        return YES;
    }
}
//开始加载
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    //开启指示器
    if (self.showHud) {
        MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:[[[UIApplication sharedApplication]delegate]window] animated:YES];
        hud.labelText = @"加载中,请稍候...";
    }
}

//加载完成
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //判断左侧返回按钮
    [self checkLeftBtnNeedHidden];
    //关闭指示器
    if (self.showHud) {
        [MBProgressHUD hideAllHUDsForView:[[[UIApplication sharedApplication]delegate]window] animated:YES];
    }
    //把网页的title作为页面的标题
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if (title.length>5) {
        NSString * tmp = [title substringToIndex:5];//(下标为7不包括下标为7的字)
        title = [NSString stringWithFormat:@"%@...",tmp];
    }
    
    self.title = title;
}

//加载失败  显示加载失败UI
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //判断左侧返回按钮
    [self checkLeftBtnNeedHidden];
    //关闭指示器
    if (self.showHud) {
        [MBProgressHUD hideAllHUDsForView:[[[UIApplication sharedApplication]delegate]window] animated:YES];
    }
    //显示加载失败的图片 点击可以重新加载
    [self.view bringSubviewToFront:self.errorView];
    //设置显示错误标题
    self.title = @"加载错误";
    QDBLog(@"---网页链接失败原因:%@",error);
}

- (NSString *)encodeToPercentEscapeString: (NSString *) input
{
    NSString *outputStr = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)input,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    return outputStr;
}

@end
