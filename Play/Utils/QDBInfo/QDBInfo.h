//
//  QDBInfo.h
//  qiandaibao_pos
//
//  Created by haohao on 16/5/7.
//  Copyright © 2016年 钱袋宝. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QDBInfo : NSObject

/** 获取系统版本 */
+(NSString*)getSystemVersion;
/** 应用版本 */
//+(NSString*)getAppVersion;
/**appVersion*/
+(NSString *)formatAppVersion;
/** md5加密 */
+(NSString*)md5:(NSString *)input;
/** 手机设备号 */
+(NSString*)getDeviceID;
/** 获得设备型号 */
+ (NSString *)getDeviceModel;
/** 终端信息 */
+(NSString*)getTerminalInfo;
/** 获取网络类型 */
+(BOOL)isNetworkUseful;
+(NSString*)getNetType;
/** 字典转json */
+(NSString*)dictToJson:(NSDictionary*)dict;
/**字典转JSON数组*/
+(NSArray<NSDictionary*>*)jsonToArray:(NSString *)jsonArrayStr;
+(NSString *)getField5f34WithICData:(NSString *)ICData;

+(NSString *)parseCardNum:(NSString *)trackInfo;

/**
 *  获取地址
 *
 *  @return wifi 地址 和 mac 地址
 */
+(NSString *)getIPAddress;
+(NSString *)getMacAddress;

/** 根据颜色生成图片 */
+(UIImage *)buttonImageFromColor:(UIColor *)color;
@end
