//
//  MHAsiNetworkItem.m
//  MHProject
//
//  Created by MengHuan on 15/4/23.
//  Copyright (c) 2015年 MengHuan. All rights reserved.
//

#import "MHAsiNetworkItem.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "MHAsiNetworkDefine.h"
@interface MHAsiNetworkItem ()

@end

@implementation MHAsiNetworkItem


#pragma mark - 创建一个网络请求项，开始请求网络
/**
 *  创建一个网络请求项，开始请求网络
 *
 *  @param networkType  网络请求方式
 *  @param url          网络请求URL
 *  @param params       网络请求参数
 *  @param delegate     网络请求的委托，如果没有取消网络请求的需求，可传nil
 *  @param hashValue    网络请求的委托delegate的唯一标示
 *  @param showHUD      是否显示HUD
 *  @param successBlock 请求成功后的block
 *  @param failureBlock 请求失败后的block
 *
 *  @return MHAsiNetworkItem对象
 */
- (MHAsiNetworkItem *)initWithtype:(MHAsiNetWorkType)networkType
                               url:(NSString *)url
                            params:(NSDictionary *)params
                          delegate:(id)delegate
                            target:(id)target
                            action:(SEL)action
                         hashValue:(NSUInteger)hashValue
                           showHUD:(BOOL)showHUD
                      successBlock:(MHAsiSuccessBlock)successBlock
                      failureBlock:(MHAsiFailureBlock)failureBlock
{
    if (self = [super init])
    {
        self.networkType    = networkType;
        self.url            = url;
        self.params         = params;
        self.delegate       = delegate;
        self.showHUD        = showHUD;
        self.tagrget        = target;
        self.select         = action;
        if (showHUD==YES) {
            [MBProgressHUD showHUDAddedTo:QDBWindow animated:YES];
        }
        __weak typeof(self)weakSelf = self;
        QDBLog(@"----请求参数%@\n",params);
        [self convertToJson:params];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        //        manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObject:@"text/html"];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", nil];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        if (networkType==MHAsiNetWorkGET)
        {
            [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                //
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSString * respStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                
                [MBProgressHUD hideAllHUDsForView:QDBWindow animated:YES];
                QDBLog(@"\n\n----返回结果 %@\n",respStr);
                //返回数据转换为字典
                NSDictionary * respDict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                if (successBlock) {
                    successBlock(respDict);
                }
                if ([weakSelf.delegate respondsToSelector:@selector(requestDidFinishLoading:)]) {
                    [weakSelf.delegate requestDidFinishLoading:respDict];
                }
                [weakSelf performSelector:@selector(finishedRequest: didFaild:) withObject:respDict withObject:nil];
                [weakSelf removewItem];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [MBProgressHUD hideAllHUDsForView:nil animated:YES];
                QDBLog(@"---error==%@\n",error.localizedDescription);
                if (failureBlock) {
                    failureBlock(error);
                }
                if ([weakSelf.delegate respondsToSelector:@selector(requestdidFailWithError:)]) {
                    [weakSelf.delegate requestdidFailWithError:error];
                }
                [weakSelf performSelector:@selector(finishedRequest: didFaild:) withObject:nil withObject:error];
                [weakSelf removewItem];
            }];
        }else{
            
            [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                //
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSString * respStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                [MBProgressHUD hideHUDForView:QDBWindow animated:YES];
                QDBLog(@"\n\n----返回结果 %@\n",respStr);
                NSDictionary * respDict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                [self convertToJson:respDict];
                if (successBlock) {
                    successBlock(respDict);
                }
                if ([weakSelf.delegate respondsToSelector:@selector(requestDidFinishLoading:)]) {
                    [weakSelf.delegate requestDidFinishLoading:respDict];
                }
                [weakSelf performSelector:@selector(finishedRequest: didFaild:) withObject:respDict withObject:nil];
                [weakSelf removewItem];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [MBProgressHUD hideAllHUDsForView:QDBWindow animated:YES];
                QDBLog(@"---error==%@\n",error.localizedDescription);
                if (failureBlock) {
                    failureBlock(error);
                }
                if ([weakSelf.delegate respondsToSelector:@selector(requestdidFailWithError:)]) {
                    [weakSelf.delegate requestdidFailWithError:error];
                }
                [weakSelf performSelector:@selector(finishedRequest: didFaild:) withObject:nil withObject:error];
                [weakSelf removewItem];
            }];
        }
    }
    return self;
}
/**
 *   移除网络请求项
 */
- (void)removewItem
{
    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([weakSelf.delegate respondsToSelector:@selector(netWorkWillDealloc:)]) {
            [weakSelf.delegate netWorkWillDealloc:weakSelf];
        }
    });
}

- (void)finishedRequest:(id)data didFaild:(NSError*)error
{
    if ([self.tagrget respondsToSelector:self.select]) {
        [self.tagrget performSelector:@selector(finishedRequest:didFaild:) withObject:data withObject:error];
    }
}

- (void)dealloc
{
    
    
}
//把字典转为json格式
- (NSString*) convertToJson:(NSDictionary*)dic{
    
    NSError *error=nil;
    NSData *JsonData=[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        NSLog(@"Error %@",[error localizedDescription]);
    }
    
    NSString *JsonStr = [[NSString alloc]initWithData:JsonData encoding:NSUTF8StringEncoding];
//    NSLog(@"json报文：%@",JsonStr);
    return JsonStr;
}
@end
