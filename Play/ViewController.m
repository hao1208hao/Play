//
//  ViewController.m
//  Play
//
//  Created by haohao on 16/7/8.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import "ViewController.h"

#import <AVFoundation/AVFoundation.h>
#import "TakeInSecretVC.h"
#import "QRTool.h"
#import "ScanQR.h"
#import "UIImage+Image.h"

#import <WebKit/WKWebView.h>
#import "WKWebViewVC.h"

#import "convertGB_BIG.h"

#import "HHLoginAuthTool.h"
 

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,scanResultDelegate,getTakeImgDelegate,WKWebDelegate>

/** 最后一次拍照ID */
@property(nonatomic,assign) NSInteger lastTakePicID;


 

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"X-man";
    
    [self foreach];
}


-(void)createTakeBtn{
    int w = 40;
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(80, 100, w, w)];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn setTitle:@"拍照" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 4;
    [btn addTarget:self action:@selector(takePic) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}


-(void)takePic{
    
}

-(void)foreach{
    NSArray* titleArr = @[@"拍照",@"生成二维码",@"扫一扫",@"截屏",@"测试Gzip",@"wkwebView",@"简体转繁体",@"验证码",@"FaceID或者指纹"];
    
    int col = 4;//列
    int row = titleArr.count/col; //行
    if (titleArr.count%col>0) {
        row +=1;
    }
    int btnW = 60;//按钮长
    int btnH = 60;//按钮宽
    
    
    //按钮间距
    int left = (SCREEN_WIDTH - col*btnW)/(col+1);
    int padH = (SCREEN_HEIGHT-row*btnH)/(row+1);
    for (int i = 0; i<titleArr.count; i++) {
        /** 需要的按钮 */
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGRect frame = CGRectMake(i%col*btnW+(i%col+1)*left, i/col*btnH+(i/col+1)*padH, btnW, btnH);
        [btn setFrame:frame];
        btn.layer.cornerRadius = 4;
        btn.titleLabel.font = [UIFont systemFontOfSize:11.0f];
        NSString* str = [NSString stringWithFormat:@"拍照%d",i];
//        [btn setTitle:str forState:UIControlStateNormal];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor redColor]];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTag:i];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
    }
}

-(void)test:(UITapGestureRecognizer*)ss{
    
    UIImageView* imgv = (UIImageView*)ss.view;
    //最低系统版本要求  8.0
    NSString* result = [QRTool recognizeImgWithImage:imgv.image];
    UIAlertView* alert =[[UIAlertView alloc]initWithTitle:@"识别结果" message:result delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
    
    [imgv removeFromSuperview];
}

-(void)btnClick:(UIButton*)btn{
    NSInteger tag = btn.tag;
    self.lastTakePicID = tag;
//    [self startSystemCamera];
//    return;
    if (tag == 0) {
        [self take];   //偷拍
    }else if(tag == 1){
        
        NSArray* qrArr = @[@"能不能借我 5k 块钱?",@"能不能借我 1w 块钱?",@"能不能借我 1.5w 块钱?",@"能不能借我 2w 块钱?",@"能不能借我 2.5w 块钱?",@"能不能借我 3w 块钱?",@"能不能借我 3.5w 块钱?",@"能不能借我 4w 块钱?",];
        
        int i =  arc4random() % 8;
        NSString* str = qrArr[i];
        
        UIImage* img =[QRTool createQRImgWithContent:str imgSize:200];
        
        /*
        UIImageView* imgV = [[UIImageView alloc]initWithImage:img];
        [imgV setFrame:CGRectMake(50, 100, 200, 200)];
        [self.view addSubview:imgV];
        */
        
        HHShowImage2* alert=[[HHShowImage2 alloc] initWithImage:img];
        [alert showInView:[[[UIApplication sharedApplication] windows] lastObject]];
        
        /*
        //长按手势
        [imgV setUserInteractionEnabled:YES];
        UITapGestureRecognizer* longT = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(test:)];
        [longT setNumberOfTouchesRequired:1];
        [imgV addGestureRecognizer:longT];
        
        */
    }else if(tag == 2){
        ScanQR *scan = [[ScanQR alloc]init];
        scan.scanDelegate = self;
//        [self presentViewController:scan animated:YES completion:nil];
        [self.navigationController pushViewController:scan animated:YES];
    }else if(tag == 3){
        /** 截屏并保存到相册 */
        UIImage *image =  [UIImage imageWithCaputureView:self.view];
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        
    }else if(tag == 4){
       /** 测试Gzip 压缩 */
        
    }else if(tag == 5){
        /** 测试WKWebView */
        WKWebViewVC* wk = [[WKWebViewVC alloc]init];
        /** 往项目中存储了一个网页文件 */
        wk.loadLocalHtmlFile = @"testWKWeb";   //传文件名
        wk.loadURL = @"http://192.168.208.156/testWKWeb.html";
        NSMutableArray* arr = [NSMutableArray arrayWithArray:@[@"loginAction",@"closeCurrPage"]];
        wk.jsFunName = arr;
        wk.wkWebDelegate = self;
        [self.navigationController pushViewController:wk animated:YES];
        
        //[self presentViewController:wk animated:YES completion:nil];
        
    }else if(tag == 6){
        NSString* zh_hant = [[convertGB_BIG new] gbToBig5:@"首页"];
        NSLog(@"繁体字是：%@", zh_hant);
        NSString* msg =[NSString stringWithFormat:@"首页的繁体字是：%@",zh_hant];
        CommonAlert(msg);
    }else if(tag == 7){
        //本地生成验证码
        /*
        QDBAuthCode* authCodeV = [[QDBAuthCode alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-100)/2, 450, 100, 40)];
        //authCodeV.layer.cornerRadius = 5;
        [self.view addSubview:authCodeV];
        
        [authCodeV returnAuthCode:^(NSString *codeStr) {
            NSLog(@"=========%@",codeStr);
        }];
        */
        
        /*
        QDBAuthCode* authCodeV = [QDBAuthCode shareQDBAuthCode];
        [authCodeV setFrame:CGRectMake((SCREEN_WIDTH-100)/2, 450, 100, 40)];
        [authCodeV returnAuthCode:^(NSString *codeStr) {
            NSLog(@"=========%@",codeStr);
        }];
        [authCodeV getNewAuthCode];
        
        [self.view addSubview:authCodeV];
        */
        
         
        
    }else if(tag == 8){
        //FaceID 或 指纹 
        [[HHLoginAuthTool shareLoginAuth] loginByLocalAuth:^(BOOL result, NSError *error) {
            if(result){
                dispatch_async(dispatch_get_main_queue(), ^{
                    CommonAlert(@"验证成功");
                });
                
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    CommonAlert(error.localizedDescription);
                });
            }
        }];
        
        
    }else if(tag == 9){
        
    }else  if(tag == 10){
       
    }
}

-(void)combine:(NSMutableArray *)result data:(NSArray *)data curr:(int)currIndex count:(int)count{
    
    if (currIndex == count) {
        //[_combinationArr addObject:[result mutableCopy]];
        [result removeLastObject];
    }else {
        NSArray* array = [data objectAtIndex:currIndex];
        
        for (int i = 0; i < array.count; ++i) {
            
            [result addObject:[array objectAtIndex:i]];
            //进入递归循环
            [self combine:result data:data curr:currIndex+1 count:count];
            
            if ((i+1 == array.count) && (currIndex-1>=0)) {
                
                [result removeObjectAtIndex:currIndex-1];
            }
        }
    }
}

#pragma mark - wkWebDelegate
#pragma mark

-(void)getJSInfoWithJSFunctionName:(NSString *)jsFunctionName andJsReqData:(NSMutableDictionary *)reqDict andWkWebView:(WKWebView *)wk{
    if([jsFunctionName isEqualToString:@"loginAction"]){
        NSString* name = reqDict[@"userName"];
        NSString* pwd = reqDict[@"userPwd"];
        
        if ([name isEqualToString:@"1"] && [pwd isEqualToString:@"1"]) {
            // 登录成功
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"测试" message:@"登录成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            //调用网页js方法
            /*
            [wk evaluateJavaScript:@"alertMobile()" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
                //TODO
                NSLog(@"%@ %@",response,error);
            }];
            */
        }else{
            // 登录失败
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"测试" message:@"登录失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }else if([jsFunctionName isEqualToString:@"closeCurrPage"]){
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/** 确认弹窗 */
-(void)getWebConfirmContent:(BOOL)webConfirmResult{
    NSString* msg = @"";
    if (webConfirmResult) {
        msg = @"点击了确定";
    }else{
        msg = @"点击了取消";
    }
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

/** 带文本框的弹窗 */
-(void)getWebPromptContent:(NSString *)webPromptContent{
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"文本框输入的内容是:%@",webPromptContent] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}


// 监听保存完成，必须实现这个方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (!error) {
        NSLog(@"保存图片成功");
    }
}


-(void)checkCaremaAuth{
    /** 判断授权状态 */
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusAuthorized) {
        //授权
        
    }else if(status == AVAuthorizationStatusNotDetermined){
        //未决定
    }else{
        [[QDBAlert shareAlertTool]showAlertViewWithVC:self title:@"提示" message:@"您可以进入系统“设置>隐私>相机”,允许“此APP”访问您的相机" cancel:@"取消" other:@"设置" cancleAction:^{
            /** 返回输入金额页面 */
            [self.navigationController popViewControllerAnimated:YES];
        } confirmAction:^{
            /** 跳转到授权设置 */
            if ([[[UIDevice currentDevice]systemVersion]floatValue]>=8.0) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }else{
                NSURL*url=[NSURL URLWithString:@"prefs:root=Privacy"];
                [[UIApplication sharedApplication] openURL:url];
            }
        }];
        return;
    }
}

-(void)take{
    TakeInSecretVC* ts = [TakeInSecretVC sharedInstance];
    ts.takeInSecretDelegate = self;
    [ts startTakePhoto];
}

-(void)getTakeInSecretImg:(UIImage *)img{
    NSLog(@"获取人脸信息成功");
}


-(void)startSystemCamera{
    [self checkCaremaAuth];
    
    //先设定sourceType为相机，然后判断相机是否可用（ipod）没相机，不可用将sourceType设定为相片库
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
//    picker.allowsEditing = YES;
    picker.sourceType = sourceType;
    if ([self respondsToSelector:@selector(presentViewController:animated:completion:)]) {
        [self presentViewController:picker animated:YES completion:nil];
    }
    else{
        [self presentModalViewController:picker animated:YES];
    }
    
}

#pragma mark- UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage* img=[info valueForKey:UIImagePickerControllerOriginalImage];
    //    CGSize newSize = CGSizeMake(320, 480);
    CGSize newSize = [UIScreen mainScreen].bounds.size;
    UIGraphicsBeginImageContext(newSize);
    
    [img drawInRect:[UIScreen mainScreen].bounds];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    NSData* photoData = UIImageJPEGRepresentation(img, 1.0);
    CGSize iconSize=CGSizeMake(96, 96*(SCREEN_HEIGHT/SCREEN_WIDTH));
    UIGraphicsBeginImageContext(iconSize);
    [img drawInRect:[UIScreen mainScreen].bounds];
    UIImage* iconImg=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData* iconData=UIImageJPEGRepresentation(img, 1.0);// iconImg
    
    UIButton* btn = (UIButton*)[self.view viewWithTag:self.lastTakePicID];
    
//    [btn setImage:img forState:UIControlStateNormal];
    
    dispatch_async(dispatch_get_main_queue(),^{
//        [btn setImage:img forState:UIControlStateNormal];
        
        [btn setBackgroundImage:img forState:UIControlStateNormal];
        
        if ([self respondsToSelector:@selector(dismissViewControllerAnimated:completion:)]) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else{
            [self dismissModalViewControllerAnimated:YES];
        }
    });
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
        
    if ([self respondsToSelector:@selector(dismissViewControllerAnimated:completion:)]) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
    else{
        [self dismissModalViewControllerAnimated:NO];
    }
   
}


-(void)getScanResult:(NSString *)scanResult{
    NSLog(@"扫描结果是:============%@",scanResult);
    
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"扫描结果" message:scanResult delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
    
}


@end
