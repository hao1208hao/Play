  //
//  MHNetworkManager.m
//  MHProject
//
//  Created by yons on 15/9/22.
//  Copyright (c) 2015年 MengHuan. All rights reserved.
//

#import "MHNetworkManager.h"
#import "MHAsiNetworkHandler.h"
#import "MHUploadParam.h"
#import "MBProgressHUD+MJ.h"
#import <AFNetworking.h>
#import "AppDelegate.h"
#import "NSString+MD5.h"
#import "NSString+reverse.h"
#import "RSA.h"
#import "INBAES.h"
@implementation MHNetworkManager
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static MHNetworkManager *_manager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [super allocWithZone:zone];
    });
    return _manager;
}
/// 返回单例
+(instancetype)sharedInstance
{
    return [[super alloc] init];
}
#pragma mark - GET 请求的三种回调方法

/**
 *   GET请求的公共方法 一下三种方法都调用这个方法 根据传入的不同参数觉得回调的方式
 *
 *   @param url          url
 *   @param paramsDict   paramsDict
 *   @param target       target
 *   @param action       action
 *   @param delegate     delegate
 *   @param successBlock successBlock
 *   @param failureBlock failureBlock
 *   @param showHUD      showHUD
 */
+ (void)getRequstWithURL:(NSString*)url
                  params:(NSDictionary*)params
                  target:(id)target
                  action:(SEL)action
                delegate:(id)delegate
            successBlock:(MHAsiSuccessBlock)successBlock
            failureBlock:(MHAsiFailureBlock)failureBlock
                 showHUD:(BOOL)showHUD
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:params];
    [[MHAsiNetworkHandler sharedInstance] conURL:url networkType:MHAsiNetWorkGET params:mutableDict delegate:delegate showHUD:showHUD target:target action:action successBlock:successBlock failureBlock:failureBlock];
}
/**
 *   GET请求通过Block 回调结果
 *
 *   @param url          url
 *   @param paramsDict   paramsDict
 *   @param successBlock  成功的回调
 *   @param failureBlock  失败的回调
 *   @param showHUD      是否加载进度指示器
 */
+ (void)getRequstWithURL:(NSString*)url
                  params:(NSDictionary*)params
            successBlock:(MHAsiSuccessBlock)successBlock
            failureBlock:(MHAsiFailureBlock)failureBlock
                 showHUD:(BOOL)showHUD
{
    [self getRequstWithURL:url params:params target:nil action:nil delegate:nil successBlock:successBlock failureBlock:failureBlock showHUD:showHUD];
}
/**
 *   GET请求通过代理回调
 *
 *   @param url         url
 *   @param paramsDict  请求的参数
 *   @param delegate    delegate
 *   @param showHUD    是否转圈圈
 */
+ (void)getRequstWithURL:(NSString*)url
                  params:(NSDictionary*)params
                delegate:(id<MHAsiNetworkDelegate>)delegate
                 showHUD:(BOOL)showHUD
{
    [self getRequstWithURL:url params:params target:nil action:nil delegate:delegate successBlock:nil failureBlock:nil showHUD:showHUD];
}

/**
 *   get 请求通过 taget 回调方法
 *
 *   @param url         url
 *   @param paramsDict  请求参数的字典
 *   @param target      target
 *   @param action      action
 *   @param showHUD     是否加载进度指示器
 */
+ (void)getRequstWithURL:(NSString*)url
                  params:(NSDictionary*)params
                  target:(id)target
                  action:(SEL)action
                 showHUD:(BOOL)showHUD
{
    [self getRequstWithURL:url params:params target:target action:action delegate:nil successBlock:nil failureBlock:nil showHUD:showHUD];
}

#pragma mark - POST请求的三种回调方法
/**
 *   发送一个 POST请求的公共方法 传入不同的回调参数决定回调的方式
 *
 *   @param url           ur
 *   @param paramsDict   paramsDict
 *   @param target       target
 *   @param action       action
 *   @param delegate     delegate
 *   @param successBlock successBlock
 *   @param failureBlock failureBlock
 *   @param showHUD      showHUD
 */
+ (void)postReqeustWithURL:(NSString*)url
                    params:(NSDictionary*)params
                    target:(id)target
                    action:(SEL)action
                  delegate:(id<MHAsiNetworkDelegate>)delegate
              successBlock:(MHAsiSuccessBlock)successBlock
              failureBlock:(MHAsiFailureBlock)failureBlock
                   showHUD:(BOOL)showHUD
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:params];
    [[MHAsiNetworkHandler sharedInstance] conURL:url networkType:MHAsiNetWorkPOST params:mutableDict delegate:delegate showHUD:showHUD target:target action:action successBlock:successBlock failureBlock:failureBlock];
}



/**
 *   通过 Block回调结果
 *
 *   @param paramsDict    请求的参数字典
 *   @param successBlock  成功的回调
 *   @param failureBlock  失败的回调
 *   @param showHUD       是否加载进度指示器
 */
+ (void)postReqeustWithParams:(NSDictionary*)params
                 successBlock:(MHAsiSuccessBlock)successBlock
                 failureBlock:(MHAsiFailureBlock)failureBlock
                      showHUD:(BOOL)showHUD
{
    /** 明文传输 */
    NSDictionary* reqDict = [self getFinalParamDictWithReq:params andEncryptReq:@"" andEncryptKey:@""];
    
    [self postReqeustWithURL:reqURL params:reqDict target:nil action:nil delegate:nil successBlock:successBlock failureBlock:failureBlock showHUD:showHUD];
    
    /** 加密请求 */
    //[self postSafeReqeustWithParams:params successBlock:successBlock failureBlock:failureBlock showHUD:showHUD];
    
}
/**
 *   通过 Block回调结果
 *
 *   @param paramsDict    请求的参数字典
 *   @param successBlock  成功的回调
 *   @param failureBlock  失败的回调
 *   @param showHUD       是否加载进度指示器
 */
+ (void)postQDurlReqeustWithParams:(NSDictionary*)params
                 successBlock:(MHAsiSuccessBlock)successBlock
                 failureBlock:(MHAsiFailureBlock)failureBlock
                      showHUD:(BOOL)showHUD
{
    /** 明文传输 */
    NSDictionary* reqDict = [self getFinalParamDictWithReq:params andEncryptReq:@"" andEncryptKey:@""];
    
    [self postReqeustWithURL:QDReqURL params:reqDict target:nil action:nil delegate:nil successBlock:successBlock failureBlock:failureBlock showHUD:showHUD];
    
    /** 加密请求 */
    //[self postSafeReqeustWithParams:params successBlock:successBlock failureBlock:failureBlock showHUD:showHUD];
    
}

/**
 *   通过 Block回调结果
 *
 *   @param url           url
 *   @param paramsDict    请求的参数字典
 *   @param successBlock  成功的回调
 *   @param failureBlock  失败的回调
 *   @param showHUD       是否加载进度指示器
 */
+ (void)postReqeustWithURL:(NSString*)url
                    params:(NSDictionary*)params
              successBlock:(MHAsiSuccessBlock)successBlock
              failureBlock:(MHAsiFailureBlock)failureBlock
                   showHUD:(BOOL)showHUD
{
    [self postReqeustWithURL:url params:params target:nil action:nil delegate:nil successBlock:successBlock failureBlock:failureBlock showHUD:showHUD];
}
/**
 *   post请求通过代理回调
 *
 *   @param url         url
 *   @param paramsDict  请求的参数
 *   @param delegate    delegate
 *   @param showHUD    是否转圈圈
 */
+ (void)postReqeustWithURL:(NSString*)url
                    params:(NSDictionary*)params
                  delegate:(id<MHAsiNetworkDelegate>)delegate
                   showHUD:(BOOL)showHUD;
{
    [self postReqeustWithURL:url params:params target:nil action:nil delegate:delegate successBlock:nil failureBlock:nil showHUD:showHUD];
}
/**
 *   post 请求通过 target 回调结果
 *
 *   @param url         url
 *   @param paramsDict  请求参数的字典
 *   @param target      target
 *   @param showHUD     是否显示圈圈
 */
+ (void)postReqeustWithURL:(NSString*)url
                    params:(NSDictionary*)params
                    target:(id)target
                    action:(SEL)action
                   showHUD:(BOOL)showHUD
{
    [self postReqeustWithURL:url params:params target:target action:action delegate:nil successBlock:nil failureBlock:nil showHUD:showHUD];
}

/**
 *  上传文件
 *
 *  @param url          上传文件的 url 地址
 *  @param paramsDict   参数字典
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *  @param showHUD      显示 HUD
 */
+ (void)uploadFileWithURL:(NSString*)url
                   params:(NSDictionary*)paramsDict
             successBlock:(MHAsiSuccessBlock)successBlock
             failureBlock:(MHAsiFailureBlock)failureBlock
              uploadParam:(MHUploadParam *)uploadParam
                  showHUD:(BOOL)showHUD
{
    if (showHUD) {
        [MBProgressHUD showHUDAddedTo:nil animated:YES];
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:paramsDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
         [formData appendPartWithFileData:uploadParam.data name:uploadParam.name fileName:uploadParam.fileName mimeType:uploadParam.mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:nil animated:YES];
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:nil animated:YES];
        if (error) {
            failureBlock(error);
        }
    }];
}

#pragma mark - 加密相关
#pragma mark

+(NSString *)getRandKey{
    
    NSMutableString * ms = [[NSMutableString alloc]initWithCapacity:16];
    NSArray * source = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    
    for (int i=0; i<16; i++) {
        int x = arc4random() % 62;
        NSString * s = [source objectAtIndex:x];
        [ms appendString:s];
    }
    QDBLog(@"---生成的AES加密用的key:%@",ms);
    return ms;
}

/**
 *   通过 Block回调结果
 *
 *   @param paramsDict    请求的参数字典
 *   @param successBlock  成功的回调
 *   @param failureBlock  失败的回调
 *   @param showHUD       是否加载进度指示器
 */
+ (void)postSafeReqeustWithParams:(NSDictionary*)params
                     successBlock:(MHAsiSuccessBlock)successBlock
                     failureBlock:(MHAsiFailureBlock)failureBlock
                          showHUD:(BOOL)showHUD
{
    //3.获取aes加密的key
    NSString * aesKey = [MHNetworkManager getRandKey];
    NSString * rsaKey = [RSA encryptString:aesKey publicKey:RSA_PUB_KEY];
    //4.反转获得向量ivkey
    NSString * ivKey = [aesKey reverse];
    //5.aes加密。
    INBAES *aes = [INBAES sharedINBAES];
    [aes updateKeyWithKeySize:kCCKeySizeAES128];
    NSString* jsonParams = dictToJson(params);
    NSData *plainData = [jsonParams dataUsingEncoding:NSUTF8StringEncoding];
    NSData * keyData = [aesKey dataUsingEncoding:NSUTF8StringEncoding];
    NSData *ivData = [ivKey dataUsingEncoding:NSUTF8StringEncoding];
    NSData * binData = [aes doCipher:plainData key:keyData iv:ivData operation:kCCEncrypt];
    //aes加密的结果
    NSData * base64Data = [binData base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    NSString * reqVal = [[NSString alloc]initWithData:base64Data encoding:NSUTF8StringEncoding];
    
    NSDictionary* reqDict = [self getFinalParamDictWithReq:params andEncryptReq:reqVal andEncryptKey:rsaKey];
    
    [self postReqeustWithURL:reqURL params:reqDict target:nil action:nil delegate:nil successBlock:successBlock failureBlock:failureBlock showHUD:showHUD];
    
}

/**
 *  拼接最后的请求数据
 *
 *  @param reqDict    明文的req请求
 *  @param encryptReq 加密的req请求
 *  @param encryptKey 加密的key值
 *
 *  @return 最后的请求参数
 */
+(NSDictionary*)getFinalParamDictWithReq:(NSDictionary*)reqDict andEncryptReq:(NSString*)encryptReq andEncryptKey:(NSString*)encryptKey{
    //1.获取加密源串
    NSString* jsonParams = dictToJson(reqDict);
    if (encryptReq.length<=0) {
        encryptReq = jsonParams;
    }
    NSString* queryType = [reqDict objectForKey:@"type"];  //接口名称
    
    NSString* appNo = [userDefaults objectForKey:@"userAgent"];
    if(appNo.length<=0){
        appNo = fzfChannel;
    }
    NSDictionary* dict = @{
                           @"req":encryptReq,
                           @"key":encryptKey,
                           @"encryptData":QDBMD5(jsonParams),
                           @"queryType":queryType?:@"",
                           @"merchantNo":fzfChannel,//商户编号
                           @"appNO":NotNil(appNo),//用户编号 手机号
                           @"appType":deviceModel?:@"", //ios android
                           @"appSystemNO":sysVersion?:@"",
                           @"appImei":deviceID?:@"",
                           @"appVersion":dcs_appVersion,
                           @"IP":QDBGetIpAddr?:@""
                           };
//    NSData * reqData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
//    NSString * reqStr = [[NSString alloc]initWithData:reqData encoding:NSUTF8StringEncoding];
//    QDBLog(@"接口%@的明文请求数据是：%@",queryType,reqStr);
    
    return dict;
}

@end
