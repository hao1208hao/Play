//
//  NSDate+MyExtension.m
//  QiandaiPersonalV2
//
//  Created by weixiaoyang on 16/1/12.
//
//

#import "NSDate+MyExtension.h"

@implementation NSDate (MyExtension)
+(NSString *)getDateStrWithString:(NSString *)str
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:str];
    [formatter setDateFormat:@"yyyy-MM"];
    return [formatter stringFromDate:date];
}
+(NSString *)getDateStrWithDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    return [formatter stringFromDate:date];
}
+(NSDate *)getThreeMonthAgoDateWithDate:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:0];
    
    [adcomps setMonth:-3];
    
    [adcomps setDay:0];
    
    
    
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
    
    return newdate;
}

+(NSString *)getThreeMonthAgoDateStrWithDate:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:0];
    
    [adcomps setMonth:-3];
    
    [adcomps setDay:0];
    
    [adcomps setHour:0];
    
    [adcomps setMinute:0];
    
    [adcomps setSecond:0];

    
    
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return [formatter stringFromDate:newdate];

}

+(NSDate *)getOneYearAgoDateWithDate:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:-1];
    
    [adcomps setMonth:0];
    
    [adcomps setDay:0];
    
    
    
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
    return newdate;
}

+(NSString *)getFormatterDateAndTimeStringWithDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return [formatter stringFromDate:date];
}
@end
