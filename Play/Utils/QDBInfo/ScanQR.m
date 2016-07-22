//
//  ScanQR.m
//  Play
//
//  Created by haohao on 16/7/21.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import "ScanQR.h"
#import "QRView.h"
#import <AVFoundation/AVFoundation.h>

@interface ScanQR ()<AVCaptureMetadataOutputObjectsDelegate>

@property (strong, nonatomic) AVCaptureSession *session;
@property (strong, nonatomic) AVCaptureDevice * device;
@property (strong, nonatomic) AVCaptureDeviceInput * input;
@property (strong, nonatomic) AVCaptureMetadataOutput * output;
/** 预览区 */
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *preview;

@property (nonatomic,weak) QRView *qrView;
@end

@implementation ScanQR

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 标题
    self.title = @"扫一扫";
    //self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithBackTarget:self action:@selector(back)];
    
    [self scanQR];

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

-(void)scanQR{
    
    [self checkCaremaAuth];
    
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusAuthorized) {
        //授权
        
    }else if(status == AVAuthorizationStatusNotDetermined){
        //未决定
    }else{
        
        
        return;
    }
    
    //增加条形码扫描
    // 条码类型 AVMetadataObjectTypeQRCode
    //_output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
    _output.metadataObjectTypes = @[AVMetadataObjectTypeEAN13Code,
                                    AVMetadataObjectTypeEAN8Code,
                                    AVMetadataObjectTypeCode128Code,
                                    AVMetadataObjectTypeQRCode];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity =AVLayerVideoGravityResizeAspectFill;
    _preview.frame =self.view.layer.bounds;
    [self.view.layer insertSublayer:_preview atIndex:0];
    
    [_session startRunning];
   
    
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    CGRect screenRect = [UIScreen mainScreen].bounds;
    
    QRView *qrRectView = [[QRView alloc] initWithFrame:screenRect];
    
    CGFloat qrvX = 240;
    CGFloat qrvY = 240;
    
    qrRectView.transparentArea = CGSizeMake(qrvX, qrvY);
    qrRectView.backgroundColor = [UIColor clearColor];
    qrRectView.center = CGPointMake(screenWidth/ 2, screenHeight/ 2);
    [self.view addSubview:qrRectView];
    self.qrView = qrRectView;
    
    CGFloat cropY = (screenHeight - qrvY) / 2-120;
    if (screenHeight == 480) {
        cropY = (screenHeight - qrvY) / 2 - 60;
    }
    
    //修正扫描区域
    CGRect cropRect = CGRectMake((screenWidth - qrRectView.transparentArea.width) / 2,
                                 cropY,
                                 qrvX,
                                 qrvY);
    
    [_output setRectOfInterest:CGRectMake(cropRect.origin.y / screenHeight,
                                          cropRect.origin.x / screenWidth,
                                          cropRect.size.height / screenHeight,
                                          cropRect.size.width / screenWidth)];
    
}

#pragma mark - 实现output的回调方法
// 当扫描到数据时就会执行该方法
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count > 0) {
        // 停止扫描
        [self.session stopRunning];
        [self.qrView stopAnimation];

        //震动提示
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        
        AVMetadataMachineReadableCodeObject *object = [metadataObjects lastObject];
        
        [self getResult:object.stringValue];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        NSLog(@"没有扫描到数据");
    }
}

-(void)getResult:(NSString*)result{
    if ([self.scanDelegate respondsToSelector:@selector(getScanResult:)]) {
        [self.scanDelegate getScanResult:result];
    }
}

@end
