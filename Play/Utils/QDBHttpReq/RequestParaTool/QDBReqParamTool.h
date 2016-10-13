//
//  QDBReqParamTool.h
//  
//
//  Created by weixiaoyang on 16/3/14.
//  Copyright © 2016年 某某某. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QDBSingleton.h"


@interface QDBReqParamTool : NSObject

/**
 *  获取闪屏请求字典
 *
 *  @return 返回请求的字典
 */
+(NSDictionary*)getSplashReqParam;

/**
 *  获取登陆请求参数
 */
+(NSDictionary *)getLoginReqParamWithUserName:(NSString *)userName pwd:(NSString *)pwd;

/**
 *  提取货款
 *
 *  @return 返回提取货款的请求参数
 */
+(NSDictionary *)getTQHHReq;

/**
 *  提现请求参数
 *
 *  @param amount  提现金额
 *  @param cardGid 银行卡Gid
 *
 *  @return 返回提现请求参数
 */
+(NSDictionary *)getTXReqWithAmount:(NSString*)amount andCardGid:(NSString*)cardGid;
/**
 *  获取提现记录参数
 *
 *  @return 获取体现记录参数
 */
+(NSDictionary *)getTXRecordListWithCardNum:(NSString *)cardNum rowNum:(NSString *)rowNum;

/**
 *  交易查询
 *
 *  @param reqDict 筛选条件字典
 *
 *  @return 返回交易查询请求参数
 */
+(NSDictionary *)getTradeQueryReqWithParams:(NSMutableDictionary*)reqDict;

/**
 *  获取任务列表
 *
 *  @return 返回任务列表请求参数
 */
+(NSDictionary *)getTaskListReq;

/**
 *  任务列表查询审核状态
 *
 *  @param taskName 任务名称
 *  @param orderID  订单ID
 *
 *  @return 返回 任务列表查询审核状态 请求参数
 */
+(NSDictionary *)getTaskListQueryStateWithTaskName:(NSString*)taskName andOrderId:(NSString*)orderID;

/**
 *  获取设备列表
 *
 *  @return 返回设备列表请求参数
 */
+(NSDictionary *)getEquipmentReq:(NSString *)deviceType;

/**
 *  获取激活码 注销码
 *
 *  @param deviceNo 设备编号
 *  @param codeType 激活码类型(激活、注销)
 *
 *  @return 返回获取激活码、注销码请求参数
 */
+(NSDictionary *)getActiveAndUndoCodeReqWithDeiviceNO:(NSString*)deviceNo andCodeType:(NSString*)codeType;

/**
 *  获取二维码支持列表
 *  @param type 0 主扫   1被扫
 *  @return 返回二维码支持列表请求参数
 */
+(NSDictionary *)getSupportQRPayWapWithWay:(NSString*)type;

/*!
 *  @author 钱袋宝, 16-05-13 11:05:16
 *
 *  @brief 获取二维码（支付宝 京东）
 *
 *  @param money        金额
 *  @param orderID      订单号
 *  @param handlerType  处理类型:
 *
 *  @return 获取二维码（支付宝 京东）请求参数
 */
+(NSDictionary *)getQrCodeReqWithMoney:(NSString *)money clientOrderID:(NSString *)clientOrderID handlerType:(NSString*)handlerType;

/**
 *  扫码支付（支付宝 京东）
 *
 *  @return
 */
+(NSDictionary *)getScanQrCodePayReqWithReqDict:(NSMutableDictionary*)reqDict;

/**
 *  扫码状态查询（微信 支付宝 京东）
 *
 *  @return
 */
+(NSDictionary *)queryScanCodeStatusWithOrderId:(NSString *)orderID;

/**
 *  （微信 支付宝 京东）自动退款
 *   @param 订单号
 *
 *  @return
 */

+(NSDictionary *)cancelQRTradeWithOrderID:(NSString *)orderID;

/*!
 *  @author 钱袋宝, 16-05-17 19:05:17
 *
 *  @brief 刷新首页
 *
 *  @return 刷新首页请求参数
 */
+(NSDictionary *)refreshIndexPage;

/*!
 *  @author 钱袋宝, 16-05-17 19:05:37
 *
 *  @brief 密码重置
 *
 *  @param phone    手机号
 *  @param password 老密码
 *  @param newPassword 新密码
 *  @return 密码重置请求参数
 */
+(NSDictionary *)resetPwdWitholdPassword:(NSString *)password
              newPassword:(NSString *)newPassword;
/*!
 *  @author 钱袋宝, 16-05-17 20:05:21
 *
 *  @brief 获取手机验证码
 *
 *  @param phone        手机号
 *  @param merchantNo    商户编号
 *  @param validateType 验证类型
 *  @param issueType    下发类型
 *
 *  @return 获取手机验证码参数
 */
+(NSDictionary *)getMsgCode:(NSString *)phone validateType:(NSString *)validateType issueType:(NSString *)issueType;

/**
 *  验证码校验
 *
 *  @param userPhone 收到验证码的手机号
 *  @param msgCode   难码
 *  @param verifyType 短信类型
 *
 *  @return 验证码校验参数
 */
+(NSDictionary *)validMsgCodeWithPhone:(NSString *)userPhone AndMsgCode:(NSString *)msgCode andVerifyType:(NSString *)verifyType;

/*!
 *  @author 钱袋宝, 16-05-18 08:05:23
 *
 *  @brief 找回密码
 *
 *  @param merchantNo  商户编号
 *  @param phone       手机号
 *  @param newPassword 新密码
 *
 *  @return 找回密码请求参数
 */
+(NSDictionary *)findPassword:(NSString *)phone newPassword:(NSString *)newPassword;

/*!
 *  @author 钱袋宝, 16-05-18 08:05:23
 *
 *  @brief 初始化
 *
 *  @return 初始化请求参数
 */
+(NSDictionary *)initRequest;

/*!
 *  @author 钱袋宝, 16-05-18 10:05:56
 *
 *  @brief 收单撤销
 *
 *  @param orderID 订单号
 *  @param neme    持卡人姓名
 *  @param phone   持卡人手机号
 *
 *  @return 收单撤销参数
 */
+(NSDictionary *)revokePay:(NSString *)orderID name:(NSString *)neme phone:(NSString *)phone;

/*!
 *  @author 钱袋宝, 16-05-23 19:05:34
 *
 *  @brief 设置自动提现状态
 *
 *  @param visitType 自动提现状态
 *
 *  @param operationType 1:查询，2:修改
 *
 *  @return 设置自动提现状态参数
 */
+(NSDictionary *)autoWithDrawState:(NSString *)state operationType:(NSString *)operationType;

/*!
 *  @author 钱袋宝, 16-05-23 19:05:34
 *
 *  @brief   获取消息列表
 *
  *  @return 获得消息列表状态参数
 */
+(NSDictionary *)getMessageListWithPageNum:(NSString *)pageNum;
/*!
 *  @author 钱袋宝, 16-05-23 19:05:34
 *
 *  @brief   设置消息已读
 *
 *  @return 获得设置消息已读参数
 */

+(NSDictionary *)setReadMessageStatuesWithMessageGidVar:(NSString *)messageGidVar messageGroup:(NSString *)messageGroup messageTitle:(NSString *)messageTitle allRead:(NSString *)allRead;

/*!
 *  @author 钱袋宝, 16-05-30 17:05:16
 *
 *  @brief 任务中心提现拍照
 *
 *  @param orderID     订单号
 *  @param photoType   拍照类型
 *  @param receiptName 小票名称
 *  @param srcType 拍照名称
 *  @param timeStamp 时间戳
 *  @return 提现拍照参数.
 */
+(NSDictionary *)taskCenterTakeAmountPhoto:(NSString *)orderID taskName:(NSString *)taskName receiptName:receiptName srcType:(NSString *)srcType timeStamp:(NSString *)timeStamp;

/*!
 *  @author 钱袋宝, 16-05-30 13:05:33
 *
 *  @brief 任务中心调单
 *
 *  @param taskName 任务名称
 *  @param orderID   订单号
 *  @param timeStamp 时间戳
 *  @return 调单参数
 */
+(NSDictionary *)taskCenterDD:(NSString *)taskName orderID:(NSString *)orderID srcType:(NSString *)srcType timeStamp:(NSString *)timeStamp;

/*!
 *  @author 钱袋宝, 16-05-31 16:05:49
 *
 *  @brief 修改小票状态查询
 *
 *
 *  @return 修改小票参数
 */
+(NSDictionary *)modifyTicketStateQuery;

/*!
 *  @author 钱袋宝, 16-07-04 13:07:36
 *
 *  @brief 获取账户名
 *
 *  @return 获取账户名请求参数
 */
+(NSDictionary *)getAccountName;
/*!
 *  @author 钱袋宝, 16-07-04 13:07:36
 *
 *  @brief 添加银行卡
 *
 *  @return 获取添加银行卡请求参数
 */
+(NSDictionary *)addBankCardWithpublicAccountName:(NSString*)publicAccountName publicAccount:(NSString*)publicAccount publicAccountBank:(NSString*)publicAccountBank privateAccountName:(NSString *)privateAccountName privateAccount:(NSString *)privateAccount;
/*!
 *  @author 钱袋宝, 16-07-06 10:07:18
 *
 *  @brief 获取银行卡列表
 *
 *  @return 获取银行卡列表参数
 */
+(NSDictionary *)getCardList;
/*!
 *  @author 钱袋宝, 16-07-06 14:07:36
 *
 *  @brief 银行卡管理参数
 *
 *  @param logGid 卡gid
 *  @param type   类型:1.删除 2.设置默认
 *
 *  @return 银行卡管理参数
 */
+(NSDictionary *)cardManager:(NSString *)logGid type:(NSString *)type;
/*!
 *  @author 钱袋宝, 16-07-06 16:07:51
 *
 *  @brief 添加银行卡
 *
 *  @param publicAccountName  对公账户名
 *  @param publicAccount      对公账户账号
 *  @param publicAccountBank  对公账户开户行
 *  @param privateAccountName 个人账户名
 *  @param privateAccount     个人账户账号
 *
 *  @return 添加银行卡
 */
+(NSDictionary *)addBankCard:(NSString *)publicAccountName publicAccount:(NSString *)publicAccount publicAccountBank:(NSString *)publicAccountBank privateAccountName:(NSString *)privateAccountName privateAccount:(NSString *)privateAccount;
/*!
 *  @author 钱袋宝, 16-07-06 16:07:50
 *
 *  @brief 修改对公账户
 *
 *  @param logGid            提现Gid
 *  @param publicAccount     对公账户账号
 *  @param publicAccountBank 对公账户开户行
 *
 *  @return 修改对公账户
 */
+(NSDictionary *)modifyPublicCard:(NSString *)logGid publicAccount:(NSString *)publicAccount publicAccountBank:(NSString *)publicAccountBank;


@end
