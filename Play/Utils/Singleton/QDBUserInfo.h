//
//  QDBUserInfo.h
//  DaCaiShen
//
//  Created by haohao on 16/3/8.
//  Copyright © 2016年 某某某. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QDBSingleton.h"


@interface QDBUserInfo : NSObject

SingletonH(UserInfo);

/** 用户编号 */
@property(nonatomic,copy)NSString* userAgent;
//用户访问凭证
@property(nonatomic,copy)NSString* agentTicket;
//真实姓名
@property(nonatomic,copy)NSString* realName;
//用户电话
@property(nonatomic, copy)NSString *userPhone;
//加急结算标志
@property(nonatomic,copy) NSString * automaticWithdrawalState;

//财富值
@property(nonatomic,copy) NSString * wealthValue;
//财富值开关
@property(nonatomic,copy) NSString * weakthSwitch;


//小票名称
@property(copy,nonatomic) NSString * storeName;
//营业执照名称
@property(copy,nonatomic) NSString * businessLicenseName;
//法人姓名
@property(copy,nonatomic) NSString * legalPerson;
//注册地址
@property(copy,nonatomic) NSString * registeAddress;
//经营地址
@property(copy,nonatomic)NSString * storeSite;


/**
 *  Ticket 失效,退出登录
 */
+(void)ticketInvalid;

//注册推送接口
+ (void)deviceTokenUpService;

/**
 *  获取最上层的控制器
 *
 *  @return 返回最上层的控制器
 */
+(UIViewController*)getTopVC;

@end
