//
//  QDBConstant.h
//  QiandaiPersonalV2
//
//  Created by weixiaoyang on 15/12/7.
//
//

#import<Foundation/Foundation.h>
#import<UIKit/UIKit.h>

//appSign
UIKIT_EXTERN NSString * const appSign;

//加密Key
UIKIT_EXTERN NSString* const md5Key;

UIKIT_EXTERN NSString* const UMengAppKey;
UIKIT_EXTERN NSString* const reqURL;  //网络请求地址
UIKIT_EXTERN NSString* const bkReqURL;  //备用网络请求地址
UIKIT_EXTERN NSString* const html5ReqURL;//h5网页请求地址。
UIKIT_EXTERN NSString *const QDReqURL;//钱袋地址

UIKIT_EXTERN NSString* const locationTip;  //位置提示信息
UIKIT_EXTERN NSString* const locationTipDefault;  //默认位置提示信息

//登录时来源渠道
UIKIT_EXTERN NSString* const wkfChannel;//微卡付
UIKIT_EXTERN NSString* const lsChannel;//亮刷
UIKIT_EXTERN NSString* const fzfChannel;//飞支付
UIKIT_EXTERN NSString* const mfhChannel;//妙付汇
UIKIT_EXTERN NSString* const gtbChannel;//国通宝
UIKIT_EXTERN NSString* const gfbChannel;//高付宝
UIKIT_EXTERN NSString* const wjChannel;//微金
UIKIT_EXTERN NSString* const akdChannel;//爱客多
UIKIT_EXTERN NSString* const gxqChannel;//高新奇

#pragma mark - 第三方appID
#pragma mark
UIKIT_EXTERN NSString* const wxAppID;//微信ID

UIKIT_EXTERN NSString* const resCodeSucc;
UIKIT_EXTERN NSString* const resCodeTicketUnvalid;
UIKIT_EXTERN NSString* const netErrorTip;