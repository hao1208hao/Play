//
//  WKWebViewVC.m
//  WKWebViewDemo
//
//  Created by haohao on 16/10/13.
//  Copyright © 2016年 qiandai. All rights reserved.
//

#import "WKWebViewVC.h"

#import <WebKit/WKUserContentController.h>
#import <WebKit/WKWebViewConfiguration.h>
#import "WKDelegateController.h"

@interface WKWebViewVC()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler,WKDelegate>

/** WKWebView对象 */
@property(nonatomic,strong) WKWebView* wk;

@property(nonatomic,strong) UIProgressView* progressView;

@property(nonatomic,strong) WKUserContentController* userContentController;

@end

@implementation WKWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.alertTitle.length<=0) {
        self.alertTitle = @"提示";
    }
    
    //配置环境
    WKWebViewConfiguration * configuration = [[WKWebViewConfiguration alloc]init];
    _userContentController =[[WKUserContentController alloc]init];
    configuration.userContentController = _userContentController;
    
    //注册方法
    WKDelegateController * delegateController = [[WKDelegateController alloc]init];
    delegateController.delegate = self;
    
    
    for (int i=0; i<self.jsFunName.count; i++) {
        [_userContentController addScriptMessageHandler:self name:self.jsFunName[i]]; //注册一个name为sayhello的js方法
    }
    
    _wk = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    _wk.UIDelegate = self;
    _wk.navigationDelegate = self;
    [self.view addSubview:_wk];
    
    self.progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, 2)];
    [self.view addSubview:self.progressView];
    
    [self.wk addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    if (self.loadLocalHtmlFile.length>0) {
        //http://www.jianshu.com/p/ccb421c85b2e  参考链接
        
        NSString *path = [[NSBundle mainBundle] pathForResource:self.loadLocalHtmlFile ofType:@"html"];
        if(path){
            if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
                // iOS9. One year later things are OK.
                NSURL *fileURL = [NSURL fileURLWithPath:path];
                [_wk loadFileURL:fileURL allowingReadAccessToURL:fileURL];
            } else {
                // iOS8. Things can be workaround-ed
                //   Brave people can do just this
                //   fileURL = try! pathForBuggyWKWebView8(fileURL)
                //   webView.loadRequest(NSURLRequest(URL: fileURL))
                
                NSURL *fileURL = [self fileURLForBuggyWKWebView8:[NSURL fileURLWithPath:path]];
                NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
                [_wk loadRequest:request];
            }
        }
    }else if (self.loadURL.length>0){
        [_wk loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.loadURL]]];
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if([keyPath isEqualToString:@"estimatedProgress"] && object == self.wk){
        [self.progressView setAlpha:1.0];
        [self.progressView setProgress:self.wk.estimatedProgress animated:YES];
        if (self.wk.estimatedProgress>=1.0) {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0 animated:NO];
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc{
    
    [self.wk removeObserver:self forKeyPath:@"estimatedProgress"];
    
    //这里需要注意，前面增加过的方法一定要remove掉。
    for (int i=0; i<self.jsFunName.count; i++) {
        [_userContentController removeScriptMessageHandlerForName:self.jsFunName[i]]; //这里需要注意，前面增加过的方法一定要remove掉。
    }
}

// 发送信息给网页
-(void)sendDataToHtmlWith:(NSString *)functionName andParam:(id)reqObj{
    
    id obj = reqObj;
    
    //数据转json
    NSDictionary *paramDict = nil;
    
    if (reqObj == nil) {
        NSDictionary* data = [NSDictionary new];
        
        paramDict = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"message",@"0000",@"statusCode",data, @"data",
                     nil];
    }else{
        NSString* msg = @"";
        NSString* statusCode = @"";
        NSArray* data = @[];
        
        if([obj isKindOfClass:[NSDictionary class]]){
            NSDictionary* dict =(NSDictionary*)obj;
            
            msg = dict[@"msg"];
            statusCode = dict[@"code"];
            
            paramDict = [NSDictionary dictionaryWithObjectsAndKeys:msg,@"message",statusCode,@"statusCode",dict, @"data",
                         nil];
            
        }else if([data isKindOfClass:[NSMutableArray class]]){
            NSMutableArray* dataArr = (NSMutableArray*)data;
            paramDict = [NSDictionary dictionaryWithObjectsAndKeys:msg,@"message",statusCode,@"statusCode",dataArr, @"data",
                         nil];
        }
    }
    
    
    //convert object to data
    NSData* jsonData =[NSJSONSerialization dataWithJSONObject:paramDict options:NSJSONWritingPrettyPrinted error:nil];
    
    //print out the data contents
    NSString* jsonParam =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    NSString* jsFunction = [NSString stringWithFormat:@"%@(%@)",functionName,jsonParam];
    
    [self.wk evaluateJavaScript:jsFunction completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        
        NSLog(@"%@",result);
        
    }];
    
}



#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    /** 
      1. message.name    对应js 方法名
      2. message.body    对应js 请求参数
      3. message.frameInfo    对应js webView信息
     */
    
    if ([self.wkWebDelegate respondsToSelector:@selector(getJSInfoWithJSFunctionName:andJsReqData: andWkWebView:)]) {
        [self.wkWebDelegate getJSInfoWithJSFunctionName:message.name andJsReqData:message.body andWkWebView:_wk];
    }    
}

#pragma mark - 代理事件
#pragma mark

#pragma mark - WKNavigationDelegate 
// 开始导航跳转时会回调
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
    
    
}
// 当内容开始返回时调用（页面内容到达main frame时回调）
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
    
}
//导航完成时，会回调（也就是页面载入完成了）
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    //oc 主动调用js方法  say()是JS方法名，completionHandler是异步回调block
//    [webView evaluateJavaScript:@"say()" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
//        NSLog(@"%@",result);
//    }];
}
// 页面加载失败时调用（导航失败时会回调）
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
}
// 接收到服务器跳转请求之后调用（接收到重定向时会回调）
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
}

// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
//    NSLog(@"%@",navigationAction.request.URL.absoluteString);
    
    NSString *hostname = navigationAction.request.URL.host.lowercaseString;
    if (navigationAction.navigationType == WKNavigationTypeLinkActivated
        && ![hostname containsString:@".baidu.com"]) {
        // 对于跨域，需要手动跳转
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
        
        // 不允许web内跳转
        decisionHandler(WKNavigationActionPolicyCancel);
    } else {
        //允许跳转
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    //    NSLog(@"%@",navigationResponse.response.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}

#pragma mark - WKUIDelegate 
// 创建一个新的WebView
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    return [[WKWebView alloc]init];
}

// 在JS端调用alert函数时，会触发此代理方法。
// JS端调用alert时所传的数据可以通过message拿到
// 在原生得到结果后，需要回调JS，是通过completionHandler回调
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    NSLog(@"%@",message);
    //    completionHandler();
    
    if ([self.wkWebDelegate respondsToSelector:@selector(getWebAlertContent:)]) {
        [self.wkWebDelegate getWebAlertContent:message];
    }
    
    /** 假如没有实现该方法,弹窗 */
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:self.alertTitle message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    
}

/**
    JS端调用confirm函数时，会触发此方法
    通过message可以拿到JS端所传的数据
    在iOS端显示原生alert得到YES/NO后
    通过completionHandler回调给JS端
*/
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:self.alertTitle message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
        if ([self.wkWebDelegate respondsToSelector:@selector(getWebConfirmContent:)]) {
            [self.wkWebDelegate getWebConfirmContent:YES];
        }
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
        if ([self.wkWebDelegate respondsToSelector:@selector(getWebConfirmContent:)]) {
            [self.wkWebDelegate getWebConfirmContent:NO];
        }
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

/*
    JS端调用prompt函数时，会触发此方法
    要求输入一段文本
    在原生输入得到文本内容后，通过completionHandler回调给JS
*/
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:self.alertTitle message:prompt preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = defaultText;
//        textField.textColor = [UIColor redColor];
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString* textContent = [[alert.textFields lastObject] text];
        if ([textContent isEqualToString:[[alert.textFields lastObject] placeholder]]) {
            /** 没有输入内容 */
            textContent = @"";
        }
        completionHandler(textContent);
        if ([self.wkWebDelegate respondsToSelector:@selector(getWebPromptContent:)]) {            
            [self.wkWebDelegate getWebPromptContent:textContent];
        }
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

/*
    对于HTTPS的都会触发此代理，如果不要求验证，传默认就行
    如果需要证书验证，与使用AFN进行HTTPS证书验证是一样的
*/
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *__nullable credential))completionHandler {
    NSLog(@"%s", __FUNCTION__);
    completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
}

// 9.0才能使用，web内容处理中断时会触发
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    NSLog(@"%s", __FUNCTION__);
}

#pragma mark - 辅助方法
#pragma mark
//将文件copy到tmp目录
- (NSURL *)fileURLForBuggyWKWebView8:(NSURL *)fileURL {
    NSError *error = nil;
    if (!fileURL.fileURL || ![fileURL checkResourceIsReachableAndReturnError:&error]) {
        return nil;
    }
    // Create "/temp/www" directory
    NSFileManager *fileManager= [NSFileManager defaultManager];
    NSURL *temDirURL = [[NSURL fileURLWithPath:NSTemporaryDirectory()] URLByAppendingPathComponent:@"www"];
    [fileManager createDirectoryAtURL:temDirURL withIntermediateDirectories:YES attributes:nil error:&error];
    
    NSURL *dstURL = [temDirURL URLByAppendingPathComponent:fileURL.lastPathComponent];
    // Now copy given file to the temp directory
    [fileManager removeItemAtURL:dstURL error:&error];
    [fileManager copyItemAtURL:fileURL toURL:dstURL error:&error];
    // Files in "/temp/www" load flawlesly :)
    return dstURL;
}

@end
