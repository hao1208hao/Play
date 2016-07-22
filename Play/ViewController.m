//
//  ViewController.m
//  Play
//
//  Created by haohao on 16/7/8.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

#import "QRTool.h"
#import "ScanQR.h"


@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,scanResultDelegate>

/** 最后一次拍照ID */
@property(nonatomic,assign) NSInteger lastTakePicID;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    NSArray* titleArr = @[@"微信朋友圈",@"微信",@"QQ空间",@"QQ",@"微信朋友圈",@"微信",@"QQ空间",@"QQ",@"微信朋友圈",@"微信",@"QQ空间",@"QQ",@"微信朋友圈",@"微信",@"QQ空间",@"QQ"];
    
    int col = 5;//列
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
        [btn setTitle:str forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor redColor]];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTag:i];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
    }
}

-(void)btnClick:(UIButton*)btn{
    NSInteger tag = btn.tag;
    self.lastTakePicID = tag;
//    [self startSystemCamera];
//    return;
    if (tag == 0) {
        
    }else if(tag == 1){
        
     UIImage* img =[QRTool createQRImgWithContent:@"http://www.baidu.com" imgSize:200];
        
    UIImageView* imgV = [[UIImageView alloc]initWithImage:img];
    [imgV setFrame:CGRectMake(50, 100, 200, 200)];
    [self.view addSubview:imgV];
        
        
    }else if(tag == 2){
        ScanQR *scan = [[ScanQR alloc]init];
        scan.scanDelegate = self;
        [self presentViewController:scan animated:YES completion:nil];
        
    }else if(tag == 3){
        
    }else if(tag == 4){
        
    }else if(tag == 5){
        
    }else if(tag == 6){
        
    }else if(tag == 7){
        
    }else if(tag == 8){
        
    }else if(tag == 9){
        
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
