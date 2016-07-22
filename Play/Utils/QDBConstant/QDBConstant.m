//
//  QDBConstant.m
//  QiandaiPersonalV2
//
//  Created by weixiaoyang on 15/12/7.
//
//

#import "QDBConstant.h"

//大财神appSign
NSString * const appSign = @"C311DC27444E4C8AAE0DC2EA59131368";

NSString* const  md5Key =@"!@#456QIANDAIBAOhaishiXiaojinling456!@#muji";
NSString * const UMengAppKey = @"5771e53267e58e71e6001d55";
//NSString* const reqURL = @"http://172.16.14.10:8080/oem-web/index";  //线下网络请求地址


//NSString* const reqURL = @"https://merchant.qiandai.net/index";

NSString* const reqURL = @"https://oem8test.qiandai.net/index";  //准生产请求地址
NSString *const QDReqURL = @"https://poscenter.qiandai.com/qzycenter/api/entry.php";//钱袋闪屏地址

NSString* const html5ReqURL = @"https://web.qiandai.net/qdbclient/merchant/doService";
//昌宇本地
//NSString* const html5ReqURL = @"http://172.16.21.104:8080/qdbclient/merchant/doService";
NSString* const locationTip = @"为了确保交易正常结算，我们需要获取您的位置信息";  //位置提示信息
NSString* const locationTipDefault = @"钱袋宝需要使用您的地理位置";  //默认位置提示信息

//登录时来源渠道
NSString* const wkfChannel = @"10000010003";//微卡付
NSString* const lsChannel = @"10000010006";//亮刷
NSString* const fzfChannel = @"10000010008";//飞支付
NSString* const mfhChannel = @"20000010001";//妙付汇
NSString* const gtbChannel = @"20000010002";//国通宝
NSString* const gfbChannel = @"20000010003";//高付宝
NSString* const wjChannel = @"20000010004";//微金
NSString* const akdChannel = @"20000010006";//爱客多
NSString* const gxqChannel = @"10000010010";//高新奇


NSString* const wxAppID = @"wxd3d91dc05b6bd033";//微信ID

NSString* const resCodeSucc = @"0000";
NSString* const resCodeTicketUnvalid = @"0019";
NSString* const netErrorTip =@"网络异常";

