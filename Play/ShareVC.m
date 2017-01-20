//
//  ShareVC.m
//  Play
//
//  Created by haohao on 17/1/20.
//  Copyright © 2017年 haohao. All rights reserved.
//

#import "ShareVC.h"
//#import "Toast+UIView.h"
//#import "WXApi.h"
//#import <TencentOpenAPI/TencentOAuth.h>
//#import <TencentOpenAPI/QQApiInterface.h>

#define shareLink @"http://m.xiaocaishen.net.cn/dcs/"
#define shareTitle @"轻松支付，简单生活"
#define shareContent @"大财神，您随身的金融终端!转账汇款、信用卡还款、充话费、水电煤缴费等"
typedef enum {
    shareToQQPersonal = 0, //分享给QQ好友
    shareToQQGroup //QQ空间
} shareToQQ;

typedef enum : NSUInteger {
    shareToWXPersonal = 0, //微信好友
    shareToWXGroup //微信朋友圈
} shareToWX;


@interface ShareVC ()<UIActionSheetDelegate>

/** 分享View背景模板View */
@property (nonatomic,strong) UIView* bgView;

/** 提示文字 */
@property(nonatomic,strong) UILabel* tipLab;
/** 分享按钮 */
@property(nonatomic,strong) UIButton* shareBtn;

@end

@implementation ShareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"分享";
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //创建View
    [self createView];
    [self createShareView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];
    
}

/**
 *  创建当前展示View
 */
-(void)createView{
    /** 显示二维码 */
    UIImage* img = [UIImage imageNamed:@"shareQR"];
    UIImageView* imgView = [[UIImageView alloc]init];
    [imgView setImage:img];
    int imgX = (SCREEN_WIDTH - img.size.width)/2;
    [imgView setFrame:CGRectMake(imgX, 100, img.size.width, img.size.height)];
    [self.view addSubview:imgView];
    
    /** 提示 */
    UILabel* tipLab = [[UILabel alloc]init];
    [tipLab setFrame:CGRectMake(15, CGRectGetMaxY(imgView.frame)+10, 290, 25)];
    [tipLab setFont:[UIFont systemFontOfSize:14.0f]];
    [tipLab setText:@"扫描以上二维码下载客户端"];
    [tipLab setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:tipLab];
    self.tipLab = tipLab;
    
    /** 分享按钮 */
    UIButton* shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    int x = 20;
    int h = 40;
    [shareBtn setFrame:CGRectMake(x, CGRectGetMaxY(tipLab.frame)+15, SCREEN_WIDTH-x*2, h)];
    [shareBtn setTitle:@"分享好友" forState:UIControlStateNormal];
    shareBtn.layer.cornerRadius = 4;
    [shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shareBtn setBackgroundColor:GlobalNavColor];
    [shareBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
    self.shareBtn = shareBtn;
}

/** 创建分享view */
-(void)createShareView{
    
    int top = 15;
    int col = 4;//列
    UIImage* img = [UIImage imageNamed:@"share_wb"];
    NSArray* imgArr = @[@"share_wxGroup",@"share_wx",@"share_QZone",@"share_QQ"];
    NSArray* titleArr = @[@"微信朋友圈",@"微信",@"QQ空间",@"QQ"];
    
    /** 背景模板 */
    UIView* bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [bgView setBackgroundColor:[UIColor blackColor]];
    [bgView setAlpha:0];
    [[[[UIApplication sharedApplication]delegate]window] addSubview:bgView];
    self.bgView = bgView;
    
    int viewX = 15;
    //    int viewH = 180; //每列3个
    int viewH = 100; //每列4个
    
    //图片间距
    int x = (SCREEN_WIDTH -viewX*2 - col*img.size.width)/(col+1);
    
    /** 分享区域View */
    UIView* shareBgView = [[UIView alloc]init];
    [shareBgView setBackgroundColor:[UIColor whiteColor]];
    [shareBgView setFrame:CGRectMake(viewX, SCREEN_HEIGHT-viewH-60, SCREEN_WIDTH-viewX*2, viewH)];
    shareBgView.layer.cornerRadius = 10;
    [bgView addSubview:shareBgView];
    
    for (int i = 0; i<imgArr.count; i++) {
        /** 需要的按钮 */
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGRect frame = CGRectMake(i%col*img.size.width+(i%col+1)*x, i/col*img.size.height+(i/col+1)*top, img.size.width, img.size.height);
        [btn setFrame:frame];
        [btn setImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
        [btn setTag:i];
        [btn addTarget:self action:@selector(shareTo:) forControlEvents:UIControlEventTouchUpInside];
        [shareBgView addSubview:btn];
        
        /** 分享到内容 */
        UILabel* titleLab = [[UILabel alloc]init];
        [titleLab setFrame:CGRectMake(frame.origin.x-5, CGRectGetMaxY(frame)-15, frame.size.width+10, frame.size.height)];
        [titleLab setText:titleArr[i]];
        [titleLab setFont:[UIFont systemFontOfSize:11.0f]];
        [titleLab setTextColor:[UIColor blackColor]];
        [titleLab setTextAlignment:NSTextAlignmentCenter];
        [shareBgView addSubview:titleLab];
    }
    
    /** 取消分享按钮 */
    int btnH = 40;
    UIButton* cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setFrame:CGRectMake(viewX, CGRectGetMaxY(shareBgView.frame)+12, SCREEN_WIDTH-viewX*2, btnH)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.layer.cornerRadius = 10;
    [cancelBtn setTitleColor:GlobalNavColor forState:UIControlStateNormal];
    [cancelBtn setBackgroundColor:[UIColor whiteColor]];
    [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:cancelBtn];
    
}

/**
 *  分享按钮点击
 */

-(void)shareAction{
    /** 显示背景模板时处理 */
    
    CATransition *animation = [CATransition animation];
    //设置运动时间
    animation.duration = 0.2;
    //设置运动type
    animation.type = kCATransitionFade;
    //设置子类
    animation.subtype = kCATransitionFromBottom;
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
    [self.bgView.layer addAnimation:animation forKey:@"animation"];
    self.bgView.alpha = 0.8;
}

/** 取消分享 */
-(void)cancelAction{
    
    CATransition *animation = [CATransition animation];
    //设置运动时间
    animation.duration = 0.2;
    //设置运动type
    animation.type = kCATransitionFade;
    //设置子类
    animation.subtype = kCATransitionFromBottom;
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
    [self.bgView.layer addAnimation:animation forKey:@"animation"];
    self.bgView.alpha = 0.0;
}

/** 分享到 */
-(void)shareTo:(UIButton*)btn{
    NSInteger tag = btn.tag;
    if (tag == 0) {
        /** 分享到微信朋友圈 */
        //[self shareToWxWithShareType:shareToWXGroup];
    }else if(tag == 1){
        /** 分享到微信朋友 */
        ///[self shareToWxWithShareType:shareToWXPersonal];
    }else if(tag == 2){
        /** 分享到QQ空间 */
        //[self shareToQQWithSence:shareToQQGroup];
    }else if(tag == 3){
        /** 分享到QQ */
        //[self shareToQQWithSence:shareToQQPersonal];
    }
}

#pragma mark - QQ分享
#pragma mark
/*
 -(void)shareToQQWithSence:(shareToQQ)shareType{
 [[TencentOAuth alloc]initWithAppId:QQAppid andDelegate:self];
 BOOL isInstall = [TencentOAuth iphoneQQInstalled];
 if (!isInstall) {
 [[[[UIApplication sharedApplication] delegate]window] makeToast:@"当前尚未安装QQ"];
 return;
 }
 
 NSData *data =[[NSData alloc]init];
 data=UIImagePNGRepresentation([UIImage imageNamed:@"aboutIcon"]);
 
 QQApiNewsObject  *newsObj=[QQApiNewsObject objectWithURL:[NSURL URLWithString:shareLink] title:shareTitle description:shareContent previewImageData:data];
 
 SendMessageToQQReq  *req = [SendMessageToQQReq reqWithContent:newsObj];
 
 QQApiSendResultCode sent = nil;
 if (shareType == shareToQQPersonal) {
 //将内容分享到qq
 sent = [QQApiInterface sendReq:req];
 }else if(shareType == shareToQQGroup){
 //将内容分享到qzone
 sent = [QQApiInterface SendReqToQZone:req];
 }
 
 [self handleSendResult:sent];
 }
 
 //QQ分享处理
 - (void)handleSendResult:(QQApiSendResultCode)sendResult
 {
 switch (sendResult)
 {
 caseEQQAPIAPPNOTREGISTED:
 {
 [[[[UIApplication sharedApplication]delegate]window] makeToast:@"App未注册"];
 
 break;
 }
 caseEQQAPIMESSAGECONTENTINVALID:
 caseEQQAPIMESSAGECONTENTNULL:
 caseEQQAPIMESSAGETYPEINVALID:
 {
 [[[[UIApplication sharedApplication]delegate]window] makeToast:@"发送参数错误"];
 break;
 }
 caseEQQAPIQQNOTINSTALLED:
 {
 [[[[UIApplication sharedApplication]delegate]window] makeToast:@"未安装QQ"];
 break;
 }
 caseEQQAPIQQNOTSUPPORTAPI:
 {
 [[[[UIApplication sharedApplication]delegate]window] makeToast:@"API接口不支持"];
 break;
 }
 caseEQQAPISENDFAILD:
 {
 [[[[UIApplication sharedApplication]delegate]window] makeToast:@"分享失败"];
 break;
 }
 default:
 {
 break;
 }
 }
 }
 
 #pragma mark - 微信分享
 #pragma mark
 -(void)shareToWxWithShareType:(shareToWX)shareType{
 //分享微信
 BOOL isInstall = [WXApi isWXAppInstalled];   //检测是否安装微信
 BOOL isSupport= [WXApi isWXAppSupportApi];   //检测是否支持openApi
 if (!isInstall) {
 [[[[UIApplication sharedApplication] delegate]window] makeToast:@"当前尚未安装微信"];
 return;
 }
 if (!isSupport) {
 [[[[UIApplication sharedApplication] delegate]window] makeToast:@"当前微信版本暂不支持该功能"];
 return;
 }
 
 WXWebpageObject* webPage = [WXWebpageObject  object];
 [webPage setWebpageUrl:shareLink];
 
 WXMediaMessage* message = [WXMediaMessage message];
 [message setTitle:shareTitle];
 [message setDescription:shareContent];
 [message setMediaObject:webPage];
 
 UIImage* img = [UIImage imageNamed:@"aboutIcon"];
 
 UIImage *thumbImg = [self thumbImageWithImage:img limitSize:CGSizeMake(250, 250)];
 
 message.thumbData = UIImagePNGRepresentation(thumbImg);
 
 
 SendMessageToWXReq* req = [[SendMessageToWXReq alloc]init];
 req.bText = NO;  //文本消息类型   文本或多媒体消息
 //WXSceneSession = 0 回话   WXSceneTimeline = 1 朋友圈  WXSceneFavorite =2 收藏
 if (shareType == shareToWXPersonal) {
 req.scene = 0;
 }else if(shareType == shareToWXGroup){
 req.scene = 1;
 }
 req.message = message;
 [WXApi sendReq:req];
 }
 
 //分享响应回调
 -(void)onResp:(BaseResp*) resp{
 if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
 //-2  取消    0//分享
 NSString* code = [NSString stringWithFormat:@"%d",resp.errCode];
 
 if ([code isEqualToString:@"-2"]) {
 //点击了取消分享
 DCSLog(@"点击了取消分享按钮");
 }else if ([code isEqualToString:@"0"]){
 //分享
 DCSLog(@"点击了分享按钮");
 }
 }else if ([resp isKindOfClass:[SendMessageToQQResp class]]){
 SendMessageToQQResp * tmpResp = (SendMessageToQQResp *)resp;
 
 if (tmpResp.type ==ESENDMESSAGETOQQRESPTYPE && [tmpResp.result integerValue] == 0) {
 //分享成功
 }
 else{
 //分享失败
 }
 }
 }
 
 #pragma mark - 辅助方法
 #pragma mark
 
 // 缩放图片
 - (UIImage *)thumbImageWithImage:(UIImage *)scImg limitSize:(CGSize)limitSize
 {
 if (scImg.size.width <= limitSize.width && scImg.size.height <= limitSize.height) {
 return scImg;
 }
 CGSize thumbSize;
 if (scImg.size.width / scImg.size.height > limitSize.width / limitSize.height) {
 thumbSize.width = limitSize.width;
 thumbSize.height = limitSize.width / scImg.size.width * scImg.size.height;
 }
 else {
 thumbSize.height = limitSize.height;
 thumbSize.width = limitSize.height / scImg.size.height * scImg.size.width;
 }
 UIGraphicsBeginImageContext(thumbSize);
 [scImg drawInRect:(CGRect){CGPointZero,thumbSize}];
 UIImage *thumbImg = UIGraphicsGetImageFromCurrentImageContext();
 UIGraphicsEndImageContext();
 return thumbImg;
 }
 */


@end
