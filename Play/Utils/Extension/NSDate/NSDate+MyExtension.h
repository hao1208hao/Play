//
//  NSDate+MyExtension.h
//  QiandaiPersonalV2
//
//  Created by weixiaoyang on 16/1/12.
//
//

#import <Foundation/Foundation.h>

@interface NSDate (MyExtension)
/**
 *  获取日期字符串
 *
 *  @param date <#date description#>
 *
 *  @return <#return value description#>
 */
+(NSString *)getDateStrWithString:(NSString *)str;
/**
 *  获取日期字符串
 *
 *  @param date <#date description#>
 *
 *  @return <#return value description#>
 */
+(NSString *)getDateStrWithDate:(NSDate *)date;
/**
 *  获取三个月前日期
 *
 *  @param date <#date description#>
 *
 *  @return <#return value description#>
 */
+(NSDate *)getThreeMonthAgoDateWithDate:(NSDate *)date;
/**
 *  获取三个月前日期字符串
 *
 *  @param date <#date description#>
 *
 *  @return <#return value description#>
 */
+(NSString *)getThreeMonthAgoDateStrWithDate:(NSDate *)date;
/**
 *  获取一年前日期
 *
 *  @param date <#date description#>
 *
 *  @return <#return value description#>
 */
+(NSDate *)getOneYearAgoDateWithDate:(NSDate *)date;
/**
 *  获取 yyyy-MM-dd HH:mm:ss格式字符串
 *
 *  @param date <#date description#>
 *
 *  @return <#return value description#>
 */

+(NSString *)getFormatterDateAndTimeStringWithDate:(NSDate *)date;
@end
