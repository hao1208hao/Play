//
//  HHLoginAuthTool.m
//  
//
//  Created by haohao on 2018/10/30.
//  Copyright © 2018年 haohao. All rights reserved.
//

#import "HHLoginAuthTool.h"
#import <LocalAuthentication/LocalAuthentication.h>


@interface HHLoginAuthTool()

/** 回调代码块 */
@property (nonatomic, copy) getAuthResultBlock block;

@property (nonatomic, strong) LAContext *context;

@end

@implementation HHLoginAuthTool

//初始化
+(instancetype)shareLoginAuth{
    
    static HHLoginAuthTool *instance;
    static dispatch_once_t toolOnce;
    dispatch_once(&toolOnce, ^{
        
        instance = [[self alloc] init];
    });
    return instance;
}

//懒加载
- (LAContext *)context {
    if (_context == nil) {
        _context = [LAContext new];
    }
    return _context;
}


-(void)loginByLocalAuth:(getAuthResultBlock)block{
    
    self.block = block;
    
    NSError *error;
    
    BOOL canAuthentication = [self.context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error];
    
    if (canAuthentication) {
        [self.context evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:@"请使用FaceID或指纹解锁" reply:^(BOOL success, NSError * _Nullable error) {
            
            //注意iOS 11.3之后需要配置Info.plist权限才可以通过Face ID验证哦!不然只能输密码啦...
            self.block(success,error);
        }];
    }
}


@end
