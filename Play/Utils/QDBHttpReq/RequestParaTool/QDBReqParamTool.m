//
//  QDBReqParamTool.m
//
//
//  Created by weixiaoyang on 16/3/14.
//  Copyright © 2016年 某某某. All rights reserved.
//

#import "QDBReqParamTool.h"
#import <AFNetworking/AFNetworking.h>


@implementation QDBReqParamTool

+(NSDictionary*)getSplashReqParam{
    CGSize size=[[UIScreen mainScreen] currentMode].size;
    NSInteger width=MIN(size.width, size.height);
    NSInteger height=MAX(size.width, size.height);
//    NSString *app_name = @"cn.net.dacaishen.app";
    NSString *app_name = @"com.qiandai.shanghuban";
    //NSString* userAgent = [userDefaults objectForKey:@"userAgent"];
    NSDictionary *reqParam = @{
                               @"schema":@"personal",
                               @"type":@"闪屏",
                               @"@appid":app_name,
                               @"@width":[NSNumber numberWithInteger:width],
                               @"@height":[NSNumber numberWithInteger:height],
                               @"@phoneeqno":deviceID?:@"",
//                               @"@agentno":@"986803961936",
                               @"agentno":@"",
                              // @"@agentno":NotNil(userAgent),
                               @"@rescode":@"?",
                               @"@resmsg":@"?",
                               @"@splashList":@"@@1"
                               };
    return reqParam;    
}

/** 登录 */
+(NSDictionary *)getLoginReqParamWithUserName:(NSString *)userName pwd:(NSString *)pwd
{
    pwd = QDBMD5(pwd);
    pwd = [pwd uppercaseString];
    //版本号  测试时使用   MSP.0.0.1   正式时使用 MER.0.0.1
    NSDictionary *reqParam = @{
                                @"type":@"merchartloginservice",
                                @"schema":@"miaoshua",
                                @"accountNumber":NotNil(userName),
                                @"passWord":NotNil(pwd),
                                @"fromChannel":fzfChannel,
                                @"appType":NotNil(deviceModel),
                                @"appSystemNO":NotNil(sysVersion),
                                @"appVersion":NotNil(dcs_appVersion),   //MSP.0.0.1
                                @"longitude":NotNil(QDBGetLongitude),
                                @"latitude":NotNil(QDBGetLatitude),
                                @"positionInformation":NotNil(QDBGetLocation),
                                @"channel":@"商户版", //商户版/个人版
                                @"IMEI":NotNil(deviceID), //串号
                                @"IP":NotNil(QDBGetIpAddr), //IP地址
                                @"retCode":@"?",//返回码
                                @"retMsg":@"?",//返回描述
                                @"isNewVersion":@"?",//是否新版本
                                @"isForceUpdate":@"?",//是否强制更新
                                @"describe":@"?",//描述
                                @"DAddress":@"?",//下载地址
                                @"userNumber":@"?",//用户编号
                                @"accessCredentials":@"?",//评证
                                @"userName":@"?" //真实姓名
                                };

    return reqParam;
}

/** 提取货款 */
+(NSDictionary *)getTQHHReq{
    //版本号  测试时使用   MSP.0.0.1   正式时使用 MER.0.0.1
    NSString* userAgent = [QDBUserInfo sharedUserInfo].userAgent;
    NSString* agentTicket = [QDBUserInfo sharedUserInfo].agentTicket;
    NSDictionary *reqParam = @{
                                @"type":@"merchantWithdrawExtractPaymentforGoodsService",
                                @"schema":@"miaoshua",
                                @"userNumber":NotNil(userAgent),
                                @"accessCredentials":NotNil(agentTicket),
                                @"appType":NotNil(deviceModel),
                                @"appSystemNO":NotNil(sysVersion),
                                @"appVersion":NotNil(dcs_appVersion),
                                @"channel":@"商户版", //商户版/个人版
                                @"positionInformation":NotNil(QDBGetLocation),
                                @"longitude":NotNil(QDBGetLongitude),
                                @"latitude":NotNil(QDBGetLatitude),
                                @"retCode":@"?",//返回码
                                @"retMsg":@"?",//返回描述
                                @"promptLanguage":@"?",//提现提示语
                                @"CashWithdrawalAmount":@"?",//可提现金额 2位小数
                                @"cardList":@"?",//银行卡列表
                                @"photograph":@"?",//拍照标识
                                @"orderGid":@"?",//订单Gid
                                @"automaticWithdrawal":@"?"//自动提现标识
                                };
    return reqParam;
}

/** 提现 */
+(NSDictionary *)getTXReqWithAmount:(NSString*)amount andCardGid:(NSString*)cardGid{
    NSString* userAgent = [QDBUserInfo sharedUserInfo].userAgent;
    NSString* agentTicket = [QDBUserInfo sharedUserInfo].agentTicket;
    NSDictionary *reqParam = @{
                                @"type":@"merchantWithdrawService",
                                @"schema":@"miaoshua",
                                @"userNumber":NotNil(userAgent),
                                @"accessCredentials":NotNil(agentTicket),
                                @"appType":NotNil(deviceModel),
                                @"appSystemNO":NotNil(sysVersion),
                                @"appVersion":NotNil(dcs_appVersion),
                                @"channel":@"商户版", //商户版/个人版
                                @"longitude":NotNil(QDBGetLongitude),
                                @"latitude":NotNil(QDBGetLatitude),
                                @"positionInformation":NotNil(QDBGetLocation),
                                @"logGid":NotNil(cardGid), //提现卡Gid
                                @"cashWithdrawalAmount":NotNil(amount),  //提现金额
                                @"retCode":@"?",//返回码
                                @"retMsg":@"?",//返回描述
                                @"resultList":@"?"//订单信息                                
                                };
    return reqParam;
}

/** 提现记录 */
+(NSDictionary *)getTXRecordListWithCardNum:(NSString *)cardNum rowNum:(NSString *)rowNum;
{
    NSString* userAgent = [QDBUserInfo sharedUserInfo].userAgent;
    NSString* agentTicket = [QDBUserInfo sharedUserInfo].agentTicket;
    NSDictionary *reqParam = @{
                               @"type":@"merchantWithdrawRecordService",
                               @"schema":@"miaoshua",
                               @"userNumber":userAgent?:@"",
                               @"accessCredentials":agentTicket?:@"",
                               @"cardNumber":cardNum,
                               @"rowNumber":rowNum,
                               @"appType":deviceModel?:@"",
                               @"appSystemNO":sysVersion?:@"",
                               @"appVersion":dcs_appVersion,
                               @"channel":@"商户版", //商户版/个人版
                               @"retCode":@"?",//返回码
                               @"retMsg":@"?",//返回描述
                               @"resultList":@"?"//订单信息
                               };
    return reqParam;

}

/**获取交易查询*/
+(NSDictionary *)getTradeQueryReqWithParams:(NSMutableDictionary*)reqDict{
    /** 筛选条件
     * 1、开始时间、结束时间  2015-01-01 01:01:01
     * 2、设备编号、设备类型
     * 3、交易状态
     * 4、最小金额、最大金额
     */
    
    NSString* beginTime = [reqDict objectForKey:@"beginTime"];
    NSString* endTime = [reqDict objectForKey:@"endTime"];
    NSString* deviceNumber = [reqDict objectForKey:@"deviceNumber"];
    NSString* deviceType = [reqDict objectForKey:@"deviceType"];
    NSString* tradeState = [reqDict objectForKey:@"tradeState"];
    NSString* minimumMoney = [reqDict objectForKey:@"minimumMoney"];
    NSString* maximumMoney = [reqDict objectForKey:@"maximumMoney"];
    NSString* pageNum = [reqDict objectForKey:@"pageNum"];
    
    NSString* userAgent = [QDBUserInfo sharedUserInfo].userAgent;
    NSString* agentTicket = [QDBUserInfo sharedUserInfo].agentTicket;
    NSDictionary *reqParam = @{
                               @"type":@"merchantTradeQueryService",
                               @"schema":@"miaoshua",
                               @"userNumber":userAgent?:@"",
                               @"accessCredentials":agentTicket?:@"",
                               @"beginTime":beginTime?:@"",//开始时间 yyyy-MM-dd HH:mm:ss
                               @"endTime":endTime?:@"",//结束时间 yyyy-MM-dd HH:mm:ss
                               @"deviceNumber":deviceNumber?:@"",//设备编号
                               @"minimumMoney":minimumMoney?:@"0.02",//最小金额
                               @"maximumMoney":maximumMoney?:@"99999999999.99",//最大金额
                               @"tradeState":tradeState?:@"",//交易状态
                               @"deviceType":deviceType?:@"",//设备类型
                               @"appType":deviceModel?:@"",//终端类型
                               @"appSystemNO":sysVersion?:@"",//终端系统
                               @"appVersion":dcs_appVersion,//版本号
                               @"channel":@"商户版",//渠道(商户版\个人版)
                               @"pageNumber":pageNum?:@"1",//页码
                               @"retCode":@"?",//返回码
                               @"retMsg":@"?",//返回描述
                               @"resultList":@"?",//交易列表
                               @"totalNumber":@"?" //总条数
                               };
    return reqParam;
}

/** 任务列表 */
+(NSDictionary *)getTaskListReq{
    NSString* userAgent = [QDBUserInfo sharedUserInfo].userAgent;
    NSString* agentTicket = [QDBUserInfo sharedUserInfo].agentTicket;
    NSDictionary *reqParam = @{
                               @"type":@"merchantTaskListService",
                               @"schema":@"miaoshua",
                               @"userNumber":userAgent?:@"",
                               @"accessCredentials":agentTicket?:@"",
                               @"retCode":@"?",//返回码
                               @"retMsg":@"?",//返回描述
                               @"totalNumber":@"?",//任务个数
                               @"resultList":@"?" //任务列表
                               };
    return reqParam;
}

/**任务列表查询审核状态*/
+(NSDictionary *)getTaskListQueryStateWithTaskName:(NSString*)taskName andOrderId:(NSString*)orderID{
    
    NSString* userAgent = [QDBUserInfo sharedUserInfo].userAgent;
    NSString* agentTicket = [QDBUserInfo sharedUserInfo].agentTicket;
    NSDictionary * reqParam = @{
                                @"type":@"merchanTaskListQueryExamineService",
                                @"schema":@"miaoshua",
                                @"userNumber":userAgent?:@"",//用户编号
                                @"accessCredentials":agentTicket?:@"",//访问凭证
                                @"taskName":taskName?:@"",//任务名称
                                @"orderId":orderID?:@"",//订单号
                                @"retCode":@"?",
                                @"retMsg":@"?",
                                @"resultList":@"?",//详情列表
                                };
    return reqParam;
}

/** 获取设备列表 */
+(NSDictionary *)getEquipmentReq:(NSString *)deviceType{
    NSString* userAgent = [QDBUserInfo sharedUserInfo].userAgent;
    NSString* agentTicket = [QDBUserInfo sharedUserInfo].agentTicket;
    NSDictionary *reqParam = @{
                               @"type":@"merchantDeviceListService",
                               @"schema":@"miaoshua",
                               @"userNumber":userAgent?:@"",
                               @"accessCredentials":agentTicket?:@"",
                               @"deviceType":deviceType?:@"",
                               @"retCode":@"?",//返回码
                               @"retMsg":@"?",//返回描述
                               @"bindingNum":@"?",//绑定个数
                               @"bindingList":@"?" //绑定列表
                               };
    return reqParam;
}

/** 获取激活码 注销码 */
+(NSDictionary *)getActiveAndUndoCodeReqWithDeiviceNO:(NSString*)deviceNo andCodeType:(NSString*)codeType
{
    NSString* userAgent = [QDBUserInfo sharedUserInfo].userAgent;
    NSString* agentTicket = [QDBUserInfo sharedUserInfo].agentTicket;
    NSDictionary *reqParam = @{
                            @"type":@"merchantGetTerminalActivationCodeService",
                               @"schema":@"miaoshua",
                               @"userNumber":userAgent?:@"",
                               @"accessCredentials":agentTicket?:@"",
                               @"deviceNumber":deviceNo?:@"",//设备编号
                               @"verificationType":codeType?:@"",//类型激活/注销
                               @"retCode":@"?",//返回码
                               @"retMsg":@"?",//返回描述
                               @"code":@"?",
                               };
    return reqParam;

}

#pragma mark - 支付宝扫描和二维码相关
#pragma mark
/** 获取二维码支持列表 */
+(NSDictionary *)getSupportQRPayWapWithWay:(NSString*)type{
     NSString* userAgent = [QDBUserInfo sharedUserInfo].userAgent;
    NSDictionary *reqParam = @{
                               @"type":@"merchantGetPaymentListService",
                               @"schema":@"miaoshua",
                               @"userNumber":NotNil(userAgent),
                               @"fromChannel":NotNil(fzfChannel),
                               @"paymentType":type,   //0 主扫     1 被扫
                               @"retCode":@"?",//返回码
                               @"retMsg":@"?",//返回描述
                               @"resultList":@"?",  //二维码支持列表
                               };
    return reqParam;
}

/** 主扫获取二维码链接 */
+(NSDictionary *)getQrCodeReqWithMoney:(NSString *)money clientOrderID:(NSString *)clientOrderID handlerType:(NSString*)handlerType
{
    NSString* userAgent = [QDBUserInfo sharedUserInfo].userAgent;
    NSString* agentTicket = [QDBUserInfo sharedUserInfo].agentTicket;
    NSDictionary *reqParam = @{
                            @"type":@"merchantWeChatPaymentLordEsauService",//
                            @"schema":@"miaoshua",//
                            @"userNumber":NotNil(userAgent),//
                            @"accessCredentials":NotNil(agentTicket),//
                            @"appType":NotNil(deviceModel),//
                            @"appVersion":NotNil(dcs_appVersion),//
                            @"channel":@"商户版", //商户版/个人版//
                            @"positionInformation":NotNil(QDBGetLocation),//
                            @"longitude":NotNil(QDBGetLongitude),//
                            @"latitude":NotNil(QDBGetLatitude),//
                            @"IMEI":@"",//imei
                            @"deviceNumber":@"",//设备编号
                            @"deviceInfo":@"",//设备信息
                            @"mobileDeviceNumber":@"",//移动设备编号
                            @"clientOrderId":NotNil(clientOrderID),//客户端订单号
                            @"extraData":@"",//附加数据
                            @"trademark":@"",//商品标记
                            @"money":NotNil(money),
                            @"IP":NotNil(QDBGetIpAddr),
                            @"handlerType":NotNil(handlerType),//处理类型:微信主扫支付\京东主扫支付\支付宝扫码支付-预下单
                            @"retCode":@"?",//返回码
                            @"retMsg":@"?",//返回描述
                            @"QRCodeLink":@"?",//二维码链接
                            @"orderId":@"?"
                               };
    
    return reqParam;

}
/** 扫码支付 */
+(NSDictionary *)getScanQrCodePayReqWithReqDict:(NSMutableDictionary*)reqDict
{
    NSString* userAgent = [QDBUserInfo sharedUserInfo].userAgent;
    NSString* agentTicket = [QDBUserInfo sharedUserInfo].agentTicket;
    
    NSString* sqCode = [reqDict objectForKey:@"sqCode"]; //授权码
    NSString* clientOrderID = [reqDict objectForKey:@"clientOrderID"];//客户端订单号
    NSString* handlerType = [reqDict objectForKey:@"handlerType"]; //处理类型
    NSString* money = [reqDict objectForKey:@"money"];//支付金额
    
    NSDictionary *reqParam = @{
                               @"type":@"merchantWeChatScanCodePaymentService",
                               @"schema":@"miaoshua",
                               @"userNumber":userAgent?:@"",
                               @"accessCredentials":agentTicket?:@"",
                               @"authorizationCode":NotNil(sqCode),//授权码
                               @"appType":deviceModel?:@"",
                               @"appVersion":dcs_appVersion,
                               @"channel":@"商户版", //商户版/个人版
                               @"positionInformation":QDBGetLocation?:@"",
                               @"longitude":QDBGetLongitude?:@"",
                               @"latitude":QDBGetLatitude?:@"",
                               @"IMEI":NotNil(deviceID),
                               @"deviceNumber":@"",//设备编号
                               @"deviceInfo":@"",//设备信息
                               @"mobileDeviceNumber":deviceID?:@"",
                               @"clientOrderId":NotNil(clientOrderID),
                               @"extraData":@"",//附加数据
                               @"trademark":@"",//商品标记
                               @"money":money?:@"",
                               @"IP":QDBGetIpAddr?:@"",
                               @"handlerType":NotNil(handlerType),//处理类型:微信主扫支付\京东主扫支付\支付宝扫码支付-预下单
                               @"extraInfo":@"",
                               @"retCode":@"?",//返回码
                               @"retMsg":@"?",//返回描述
                               @"orderId":@"?"//订单号
                               };
    
    return reqParam;
    
}
/**微信（支付宝、京东）—扫码状态查询*/   //生成二维码后 轮循调用查询
+(NSDictionary *)queryScanCodeStatusWithOrderId:(NSString *)orderID{
    NSString* userAgent = [QDBUserInfo sharedUserInfo].userAgent;
    NSString* agentTicket = [QDBUserInfo sharedUserInfo].agentTicket;
    NSDictionary *reqParam = @{
                               @"type":@"merchantWeChatScanCodeStatusQueryService",
                               @"schema":@"miaoshua",
                               @"userNumber":NotNil(userAgent),
                               @"accessCredentials":NotNil(agentTicket),
                               @"orderId":NotNil(orderID),
                               @"retCode":@"?",//返回码
                               @"retMsg":@"?",//返回描述
                               @"weChatInformState":@"?",//微信通知状态
                               @"QRCodeLinkAdd":@"?",//二维码链接地址
                               @"reason":@"?"//失败原因
                               };
    
    return reqParam;
}

/*!
 *  @author 钱袋宝, 16-05-13 13:05:59
 *
 *  @brief 自定退款
 *
 *  @param orderID 订单号
 *
 *  @return 自动退款参数.
 */
+(NSDictionary *)cancelQRTradeWithOrderID:(NSString *)orderID{
    NSString* userAgent = [QDBUserInfo sharedUserInfo].userAgent;
    NSString* agentTicket = [QDBUserInfo sharedUserInfo].agentTicket;
    NSDictionary *reqParam = @{
                               @"type":@"merchantWeChatPaymentAUTORepealService",
                               @"schema":@"miaoshua",
                               @"userNumber":NotNil(userAgent),
                               @"accessCredentials":NotNil(agentTicket),
                               @"orderId":NotNil(orderID),
                               @"retCode":@"?",//返回码
                               @"retMsg":@"?",//返回描述
                               };
    
    return reqParam;
}

/** 刷新首页 */
+(NSDictionary *)refreshIndexPage{
    NSString* userAgent = [QDBUserInfo sharedUserInfo].userAgent;
    NSString* agentTicket = [QDBUserInfo sharedUserInfo].agentTicket;
    NSDictionary *reqParam = @{
                               @"type":@"merchantManageRefreshMainService",
                               @"schema":@"miaoshua",
                               @"userNumber":NotNil(userAgent),//用户编号
                               @"accessCredentials":NotNil(agentTicket),//访问凭证
                               @"appType":deviceModel?:@"",
                               @"appVersion":dcs_appVersion?:@"",
                               @"channel":@"商户版",
                               @"retCode":@"?",//返回码
                               @"retMsg":@"?",//返回描述
                               @"taskNum":@"?",//任务个数
                               @"urgentLogo":@"?",//加急结算标识
                               @"extractableMoney":@"?",//可提取货款
                               @"withdrawTask":@"?",//提现任务标识
                               @"unbalancedMoney":@"?",//未结算货款
                               @"unreadMessages":@"?",//系统未读消息个数
                               @"wealthValue":@"?",//财富值
                               @"totalMoney":@"?",//总金额
                               @"wealthValueSwitch":@"?",//财富值开关
                               @"transfeTask":@"?",//转账还款拍照任务数
                               @"transfeNotTask":@"?",//转账还款拍照未任务数
                               @"urgentRedEnvelopeNum":@"?",//加急红包个数
                               @"automaticWithdrawalState":@"?",//自动提现标识
                               @"insertTime":@"?",
                               @"messageTitle":@"?",
                               @"messageCall":@"?",
                               @"messageContent":@"?",
                               @"messageContentURL":@"?"
                               };
    
    return reqParam;
}

/**密码重置*/
+(NSDictionary *)resetPwdWitholdPassword:(NSString *)password
              newPassword:(NSString *)newPassword{
    password = QDBMD5(password);
    newPassword = QDBMD5(newPassword);
    password = [password uppercaseString];
    newPassword = [newPassword uppercaseString];
    
    NSString* userAgent = [QDBUserInfo sharedUserInfo].userAgent;
    NSString* agentTicket = [QDBUserInfo sharedUserInfo].agentTicket;
    NSString *phoneNum = [QDBUserInfo sharedUserInfo].userPhone;
    NSDictionary *reqParam = @{
                               @"type":@"merchantResetPwdService",
                               @"schema":@"miaoshua",
                               @"phoneNumber":NotNil(phoneNum),//手机号
                               @"password":NotNil(password),//老密码
                               @"newPassword":NotNil(newPassword),//新密码
                               @"confirmNewPwd":NotNil(newPassword),//确认新密码
                               @"userNumber":NotNil(userAgent),//用户编号
                               @"accessCredentials":NotNil(agentTicket),//访问凭证
                               @"appType":deviceModel?:@"",
                               @"appVersion":dcs_appVersion,
                               @"channel":@"商户版",
                               @"retCode":@"?",//返回码
                               @"retMsg":@"?",//返回描述
                               };
    
    return reqParam;
}

/**获取手机验证码*/
+(NSDictionary *)getMsgCode:(NSString *)phone validateType:(NSString *)validateType issueType:(NSString *)issueType{
    NSDictionary *reqParam = @{
                               @"type":@"merchantGetSmsCodeService",
                               @"schema":@"miaoshua",
                               @"fromChannel":fzfChannel?:@"",//来源渠道
                               @"validateType":NotNil(validateType),//验证类型:注册｜找回密码
                               @"issueType":NotNil(issueType),//下发类型 :shortMessage 短信   callOut 外呼
                               @"phoneNumber":NotNil(phone),//手机号
                               @"channel":@"商户版",
                               @"retCode":@"?",//返回码
                               @"retMsg":@"?",//返回描述
                               };
    
    return reqParam;

}

/** 验证码校验 */
+(NSDictionary *)validMsgCodeWithPhone:(NSString *)userPhone AndMsgCode:(NSString *)msgCode andVerifyType:(NSString *)verifyType{

    NSDictionary *reqParam = @{
                               @"type":@"merchantCheckSmsCodeService",
                               @"schema":@"miaoshua",
                               @"fromChannel":NotNil(fzfChannel),//来源渠道
                               @"phoneNumber":NotNil(userPhone),//手机号
                               @"securityCode":NotNil(msgCode),//验证码
                               @"verifyType":NotNil(verifyType),//注册｜找回密码
                               @"appType":NotNil(deviceModel),
                               @"appVersion":NotNil(dcs_appVersion),
                               @"channel":@"商户版",
                               @"retCode":@"?",//返回码
                               @"retMsg":@"?",//返回描述
                               };
    
    return reqParam;
}

/**找回密码*/
+(NSDictionary *)findPassword:(NSString *)phone newPassword:(NSString *)newPassword{
    
    newPassword = QDBMD5(newPassword);
    newPassword = [newPassword uppercaseString];
    NSDictionary *reqParam = @{
                               @"type":@"merchantFindPasswordService",
                               @"schema":@"miaoshua",
                               @"fromChannel":fzfChannel?:@"",//来源渠道
                               @"phoneNumber":NotNil(phone),//手机号
                               @"newPassword":NotNil(newPassword),
                               @"confirmNewPwd":NotNil(newPassword),
                               @"retCode":@"?",//返回码
                               @"retMsg":@"?",//返回描述
                               };
    return reqParam;
}

/**初始化*/
+(NSDictionary *)initRequest{//通了
    
    NSDictionary *reqParam = @{
                               @"type":@"merchantinitializationservice",
                               @"schema":@"miaoshua",
                               @"fromChannel":NotNil(@"10000010008"),//来源渠道:(飞支付)
                               @"isEncryption":@"?",
                               @"publicKey":@"?",
                               @"retCode":@"?",//返回码
                               @"retMsg":@"?",//返回描述
                               };
    
    return reqParam;
}

/**收单撤销*/
+(NSDictionary *)revokePay:(NSString *)orderID name:(NSString *)name phone:(NSString *)phone{
    NSString* userAgent = [QDBUserInfo sharedUserInfo].userAgent;
    NSString* agentTicket = [QDBUserInfo sharedUserInfo].agentTicket;
    
    NSDictionary *reqParam = @{
                               @"type":@"merchantVoucherRepealService",
                               @"schema":@"miaoshua",
                               @"userNumber":NotNil(userAgent),//来源渠道
                               @"accessCredentials":NotNil(agentTicket),
                               @"orderId":NotNil(orderID),//订单号
                               @"cardName":NotNil(name),//持卡人姓名
                               @"cardPhone":NotNil(phone),//持卡人手机号
                               @"appType":deviceModel?:@"",
                               @"appVersion":dcs_appVersion,
                               @"channel":@"商户版",//渠道
                               @"retCode":@"?",//返回码
                               @"retMsg":@"?",//返回描述
                               };
    
    return reqParam;
}

+(NSDictionary *)autoWithDrawState:(NSString *)state operationType:(NSString *)operationType{
    
    NSString* userAgent = [QDBUserInfo sharedUserInfo].userAgent;
    NSString* agentTicket = [QDBUserInfo sharedUserInfo].agentTicket;
    
    NSDictionary *reqParam = @{
                               @"type":@"merchantT2WithdrawalSwitchService",
                               @"schema":@"miaoshua",
                               @"AUTOWithdrawState":NotNil(state),
                               @"userNumber":NotNil(userAgent),//来源渠道
                               @"accessCredentials":NotNil(agentTicket),
                               @"visitType":NotNil(operationType),//1:查询，2:修改 首页刷新已返回，无需查询。
                               @"retCode":@"?",//返回码
                               @"retMsg":@"?",//返回描述
                               };
    
    return reqParam;
}


+(NSDictionary *)getMessageListWithPageNum:(NSString *)pageNum
{
    NSString* userAgent = [QDBUserInfo sharedUserInfo].userAgent;
    NSString* agentTicket = [QDBUserInfo sharedUserInfo].agentTicket;
    
    NSDictionary *reqParam = @{
                               @"type":@"merchantSystemMessageListService",
                               @"schema":@"miaoshua",
                               @"userNumber":NotNil(userAgent),//来源渠道
                               @"accessCredentials":NotNil(agentTicket),
//                               @"appType":deviceModel?:@"",
//                               @"appVersion":appVersion,
//                               @"channel":@"商户版",//渠道
                               @"number":NotNil(pageNum),
                               @"retCode":@"?",//返回码
                               @"retMsg":@"?",//返回描述
                               @"rowCount":@"?",
                               @"resultList":@"?"
                               };
    
    return reqParam;

}

+(NSDictionary *)setReadMessageStatuesWithMessageGidVar:(NSString *)messageGidVar messageGroup:(NSString *)messageGroup messageTitle:(NSString *)messageTitle allRead:(NSString *)allRead
{
    NSString* userAgent = [QDBUserInfo sharedUserInfo].userAgent;
    NSString* agentTicket = [QDBUserInfo sharedUserInfo].agentTicket;
    
    NSDictionary *reqParam = @{
                               @"type":@"merchantSystemMessageReadService",
                               @"schema":@"miaoshua",
                               @"userNumber":NotNil(userAgent),//来源渠道
                               @"accessCredentials":NotNil(agentTicket),
                               //                               @"appType":deviceModel?:@"",
                               //                               @"appVersion":appVersion,
                               //                               @"channel":@"商户版",//渠道
                               @"messageGidVar":messageGidVar,
                               @"messageGroup":messageGroup,
                               @"messageTitle":messageTitle,
                               @"allRead":allRead,
                               @"retCode":@"?",//返回码
                               @"retMsg":@"?",//返回描述
                               };
    
    return reqParam;

}

//任务中心提现拍照
+(NSDictionary *)taskCenterTakeAmountPhoto:(NSString *)orderID taskName:(NSString *)taskName receiptName:receiptName srcType:(NSString *)srcType timeStamp:(NSString *)timeStamp{
    NSString* userAgent = [QDBUserInfo sharedUserInfo].userAgent;
    NSString* agentTicket = [QDBUserInfo sharedUserInfo].agentTicket;
    
    NSDictionary *reqParam = @{
                               @"type":@"merchantTakePhotosService",
                               @"schema":@"miaoshua",
                               @"userNumber":NotNil(userAgent),//来源渠道
                               @"accessCredentials":NotNil(agentTicket),
                               @"URL":timeStamp,
                               @"parameter1":NotNil(srcType),//照片名称
                               @"parameter2":@"",
                               @"parameter3":@"",
                               @"parameter4":@"",
                               @"parameter5":@"",
                               @"parameter6":@"",
                               @"appType":deviceModel?:@"",
                               @"appVersion":dcs_appVersion,
                               @"appSystemNO":@"",
                               @"channel":@"商户版",//渠道
                               @"longitude":NotNil(QDBGetLongitude),
                               @"latitude":NotNil(QDBGetLatitude),
                               @"positionInformation":NotNil(QDBGetLocation),
                               @"IP":NotNil(QDBGetIpAddr),
                               @"IMEI":NotNil(deviceID),
                               @"orderId":NotNil(orderID),
                               @"taskName":NotNil(taskName),//photoType
                               @"receiptName":NotNil(receiptName),
                               @"retCode":@"?",//返回码
                               @"retMsg":@"?",//返回描述
                               };
    
    return reqParam;

}

//任务中心调单
+(NSDictionary *)taskCenterDD:(NSString *)taskName orderID:(NSString *)orderID srcType:(NSString *)srcType timeStamp:(NSString *)timeStamp{
    NSString* userAgent = [QDBUserInfo sharedUserInfo].userAgent;
    NSString* agentTicket = [QDBUserInfo sharedUserInfo].agentTicket;
    
    NSDictionary *reqParam = @{
                               @"type":@"merchantAdjustSingleService",
                               @"schema":@"miaoshua",
                               @"userNumber":NotNil(userAgent),//来源渠道
                               @"accessCredentials":NotNil(agentTicket),
                               @"taskName":NotNil(taskName),
                               @"URL":timeStamp,
                               @"parameter1":NotNil(srcType),//照片名称
                               @"parameter2":@"",
                               @"parameter3":@"",
                               @"parameter4":@"",
                               @"parameter5":@"",
                               @"parameter6":@"",
                               @"appType":NotNil(deviceModel),
                               @"appSystemNO":NotNil(sysVersion),
                               @"appVersion":NotNil(dcs_appVersion),   //MSP.0.0.1
                               @"longitude":NotNil(QDBGetLongitude),
                               @"latitude":NotNil(QDBGetLatitude),
                               @"positionInformation":NotNil(QDBGetLocation),
                               @"channel":@"商户版", //商户版/个人版
                               @"IMEI":NotNil(deviceID), //串号
                               @"IP":NotNil(QDBGetIpAddr), //IP地址
                               @"orderId":NotNil(orderID),
                               @"retCode":@"?",//返回码
                               @"retMsg":@"?",//返回描述
                               };
    
    return reqParam;
}

/*!
 *  @author 钱袋宝, 16-05-31 16:05:49
 *
 *  @brief 修改小票状态查询
 *
 *
 *  @return 修改小票参数
 */
+(NSDictionary *)modifyTicketStateQuery{
    NSString* userAgent = [QDBUserInfo sharedUserInfo].userAgent;
    NSString* agentTicket = [QDBUserInfo sharedUserInfo].agentTicket;
    
    NSDictionary *reqParam = @{
                               @"type":@"merchantModifyReceiptsStateQueryService",// actionModifyReceiptsStateQueryService
                               @"schema":@"miaoshua",
                               @"userNumber":NotNil(userAgent),//来源渠道
                               @"accessCredentials":NotNil(agentTicket),
                               @"appType":NotNil(deviceModel),
                               @"appVersion":NotNil(dcs_appVersion),   //MSP.0.0.1
                               @"channel":@"商户版",
                               @"retCode":@"?",//返回码
                               @"retMsg":@"?",//返回描述
                               @"auditResult":@"?",//审核结果
                               @"auditTime":@"?",//审核时间
                               @"newReceiptName":@"?",//新小票名称
                               @"auditResultDescribe":@"?",//审核结果描述
                               };
    
    return reqParam;
}


+(NSDictionary *)getAccountName{
    
    NSString* userAgent = [QDBUserInfo sharedUserInfo].userAgent;
    NSString* agentTicket = [QDBUserInfo sharedUserInfo].agentTicket;
    
    NSDictionary *reqParam = @{
                               @"type":@"merchantGetAccountNameService",// 获取账户名
                               @"schema":@"miaoshua",
                               @"userNumber":NotNil(userAgent),//来源渠道
                               @"accessCredentials":NotNil(agentTicket),
                               @"registName":@"?",
                               @"legalName":@"?",
                               @"retCode":@"?",//返回码
                               @"retMsg":@"?",//返回描述
                               };
    
    return reqParam;
}

+(NSDictionary *)addBankCardWithpublicAccountName:(NSString*)publicAccountName publicAccount:(NSString*)publicAccount publicAccountBank:(NSString*)publicAccountBank privateAccountName:(NSString *)privateAccountName privateAccount:(NSString *)privateAccount
{
    NSString* userAgent = [QDBUserInfo sharedUserInfo].userAgent;
    NSString* agentTicket = [QDBUserInfo sharedUserInfo].agentTicket;
    
    NSDictionary *reqParam = @{
                               @"type":@"merchantAddCardService",// 获取账户名
                               @"schema":@"miaoshua",
                               @"userNumber":NotNil(userAgent),//来源渠道
                               @"accessCredentials":NotNil(agentTicket),
                               @"publicAccountName":publicAccountName,
                               @"publicAccount":publicAccount,
                               @"publicAccountBank":publicAccountBank,
                               @"privateAccountName":privateAccountName,
                               @"privateAccount":privateAccount,
                               @"retCode":@"?",//返回码
                               @"retMsg":@"?",//返回描述
                               };
    
    return reqParam;

}

+(NSDictionary *)getCardList{
    
    NSString* userAgent = [QDBUserInfo sharedUserInfo].userAgent;
    NSString* agentTicket = [QDBUserInfo sharedUserInfo].agentTicket;
    
    NSDictionary *reqParam = @{
                               @"type":@"merchantGetCardListService",// 获取账户名
                               @"schema":@"miaoshua",
                               @"userNumber":NotNil(userAgent),//来源渠道
                               @"accessCredentials":NotNil(agentTicket),
                               @"bankCardList":@"?",//银行卡列表
                               @"retCode":@"?",//返回码
                               @"retMsg":@"?",//返回描述
                               };
    
    return reqParam;
}

+(NSDictionary *)cardManager:(NSString *)logGid type:(NSString *)type{
    NSString* userAgent = [QDBUserInfo sharedUserInfo].userAgent;
    NSString* agentTicket = [QDBUserInfo sharedUserInfo].agentTicket;
    
    NSDictionary *reqParam = @{
                               @"type":@"merchantBankCardManagementService",// 银行卡管理
                               @"schema":@"miaoshua",
                               @"userNumber":NotNil(userAgent),//来源渠道
                               @"accessCredentials":NotNil(agentTicket),
                               @"logGid":NotNil(logGid),
                               @"implementType":NotNil(type),
                               @"retCode":@"?",//返回码
                               @"retMsg":@"?",//返回描述
                               };
    
    return reqParam;
}

+(NSDictionary *)addBankCard:(NSString *)publicAccountName publicAccount:(NSString *)publicAccount publicAccountBank:(NSString *)publicAccountBank privateAccountName:(NSString *)privateAccountName privateAccount:(NSString *)privateAccount{
    
    NSString* userAgent = [QDBUserInfo sharedUserInfo].userAgent;
    NSString* agentTicket = [QDBUserInfo sharedUserInfo].agentTicket;
    
    NSDictionary *reqParam = @{
                               @"type":@"merchantBankCardManagementService",// 银行卡管理
                               @"schema":@"miaoshua",
                               @"userNumber":NotNil(userAgent),//来源渠道
                               @"accessCredentials":NotNil(agentTicket),
                               @"publicAccountName":NotNil(publicAccountName),
                               @"publicAccount":NotNil(publicAccount),
                               @"publicAccountBank":NotNil(publicAccountBank),
                               @"privateAccountName":NotNil(privateAccountName),
                               @"privateAccount":NotNil(privateAccount),
                               @"retCode":@"?",//返回码
                               @"retMsg":@"?",//返回描述
                               };
    return reqParam;
}

+(NSDictionary *)modifyPublicCard:(NSString *)logGid publicAccount:(NSString *)publicAccount publicAccountBank:(NSString *)publicAccountBank{
    NSString* userAgent = [QDBUserInfo sharedUserInfo].userAgent;
    NSString* agentTicket = [QDBUserInfo sharedUserInfo].agentTicket;
    
    NSDictionary *reqParam = @{
                               @"type":@"merchantUpdateAccountService",// 修改对公账户
                               @"schema":@"miaoshua",
                               @"userNumber":NotNil(userAgent),
                               @"accessCredentials":NotNil(agentTicket),
                               @"logGid":NotNil(logGid),
                               @"publicAccount":NotNil(publicAccount),
                               @"publicAccountBank":NotNil(publicAccountBank),
                               @"retCode":@"?",//返回码
                               @"retMsg":@"?",//返回描述
                               };
    return reqParam;
}

+(void)uploadFileWithFileInfo:(NSMutableDictionary*)fileInfoDict{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
//    [manager POST:@"" parameters:@"" progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//    }];
    
    [manager POST:@"" parameters:@"" constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        /** 上传照片的数据 */
        /** 1、上传文件数据 2、服务器用来解析的字段 3、上传上去的图片 4、照片类型 */
        UIImage* img = fileInfoDict[@"uploadImg"];
        
        NSData *imageData = UIImageJPEGRepresentation(img, 1.0);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置时间格式
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        
        //添加要上传的文件，此处为图片
        [formData appendPartWithFileData:imageData
                                    name:@"uploadFile"
                                fileName:fileName
                                mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

@end
