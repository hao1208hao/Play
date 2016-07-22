//
//  QDBInfo.m
//  qiandaibao_pos
//
//  Created by haohao on 16/5/7.
//  Copyright © 2016年 钱袋宝. All rights reserved.
//

#import "QDBInfo.h"
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
//#import "UIDevice+Extensions.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <sys/types.h>
#import <sys/sysctl.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#include <net/if.h>
#include <net/if_dl.h>

@implementation QDBInfo

/** 系统版本号 */
+(NSString*)getSystemVersion
{
    NSString* result=@"";
    result=[[UIDevice currentDevice] systemVersion];
    return result;
}

/* 获取应用版本 */
//+ (NSString*)getAppVersion
//{
//    NSString* result = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
//    return result;
//}

+(NSString *)formatAppVersion{
     NSString* result = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString * formatAppVersion = [NSString stringWithFormat:@"AppStoreMSP%@",result];
    return /*formatAppVersion*/result;
}

/** md5加密 */
+ (NSString*)md5:(NSString *)input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (unsigned int)strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

/** 手机设备号 */
+(NSString*)getDeviceID{
    return [[UIDevice currentDevice].identifierForVendor UUIDString];
}

//获得设备型号
+ (NSString *)getDeviceModel
{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    //随着新设备的不断出现，这里已经不止这么多了。
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    
    return platform;
}

/** 终端信息 */
+(NSString*)getTerminalInfo
{
    UIDevice* device = [UIDevice currentDevice];
    NSMutableDictionary* devProps = [NSMutableDictionary dictionaryWithCapacity:5];
    
    [devProps setObject:[device model] forKey:@"platform"];
    [devProps setObject:[device systemVersion] forKey:@"version"];
//    [devProps setObject:[device uniqueAppInstanceIdentifier] forKey:@"uuid"];
    [devProps setObject:[self getDeviceModel] forKey:@"name"];
    [devProps setObject:@"3.9.1" forKey:@"cordova"];
    
    NSDictionary* terInfo = [NSDictionary dictionaryWithDictionary:devProps];
    
    return [self dictToJson:terInfo];
}

+(BOOL)isNetworkUseful{
    NSString* currentNetType = [self getNetType];
    if ([currentNetType isEqualToString:@"none"]) {
        return NO;
    }
    return YES;
}

/** 获取网络类型 */
+(NSString*)getNetType{
    NSString* netType = @"none";
    if ([self isReachableViaWWAN]) {
        netType = @"mobile";
    }
    else if([self isReachableViaWiFi]){
        netType = @"wifi";
    }
    return netType;
}

+(BOOL)isReachableViaWiFi
{
    SCNetworkReachabilityFlags flags = 0;
    SCNetworkReachabilityRef reachabilityRef = SCNetworkReachabilityCreateWithName(NULL, [@"client.qiandai.com" UTF8String]);
    if(SCNetworkReachabilityGetFlags(reachabilityRef, &flags))
    {
        // Check we're reachable
        if((flags & kSCNetworkReachabilityFlagsReachable))
        {
#if	TARGET_OS_IPHONE
            // Check we're NOT on WWAN
            if((flags & kSCNetworkReachabilityFlagsIsWWAN))
            {
                CFRelease(reachabilityRef);
                return NO;
            }
#endif
            CFRelease(reachabilityRef);
            return YES;
        }
    }
    CFRelease(reachabilityRef);
    return NO;
}
+(BOOL)isReachableViaWWAN
{
#if	TARGET_OS_IPHONE
    
    SCNetworkReachabilityFlags flags = 0;
    SCNetworkReachabilityRef reachabilityRef = SCNetworkReachabilityCreateWithName(NULL, [@"client.qiandai.com" UTF8String]);
    if(SCNetworkReachabilityGetFlags(reachabilityRef, &flags))
    {
        // Check we're REACHABLE
        if(flags & kSCNetworkReachabilityFlagsReachable)
        {
            // Now, check we're on WWAN
            if(flags & kSCNetworkReachabilityFlagsIsWWAN)
            {
                CFRelease(reachabilityRef);
                return YES;
            }
        }
    }
#endif
    CFRelease(reachabilityRef);
    return NO;
}

/**
 *  字典转json
 *
 *  @param dict 字典
 *
 *  @return 返回转换成的json 数据格式
 */
+(NSString*)dictToJson:(NSDictionary*)dict{
    if (dict == nil) {
        return @"";
    }
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+(NSArray<NSDictionary*>*)jsonToArray:(NSString *)jsonArrayStr{
    if (!jsonArrayStr.length) return nil;
    NSData * data = [jsonArrayStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError * err;
    NSArray * array = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
    if (err) {
        QDBLog(@"%@",err);
        return nil;
    } else {
        return array;
    }
}

+(NSString *)getField5f34WithICData:(NSString *)ICData
{
    NSString *field5f34 = @"";
    NSRange range = [[ICData uppercaseString] rangeOfString:@"5F34"];
    unsigned long loc = range.location + 4;
    int len = 2;
    NSString *field5f34LenHex= [ICData substringWithRange:NSMakeRange(loc, len)];
    NSScanner *scanner = [NSScanner scannerWithString:field5f34LenHex];
    unsigned int field5f34Len;
    [scanner scanHexInt:&field5f34Len];
    loc += len;
    len = field5f34Len * 2;
    field5f34 = [ICData substringWithRange:NSMakeRange(loc, len)];
    if ([field5f34 length]==2) {
        field5f34 = [NSString stringWithFormat:@"00%@", field5f34];
    }
    return field5f34;
}

+(NSString *)parseCardNum:(NSString *)trackInfo
{
    if (trackInfo.length==0) {
        return @"";
    }
    NSString *lengStr = [trackInfo substringWithRange:NSMakeRange(2,2)];
    long strLeng = strtoul([lengStr UTF8String], 0, 16)*2;
    NSString *cardNoSrt = [trackInfo substringWithRange:NSMakeRange(4, strLeng)];
    NSString *cardNo = [cardNoSrt stringByReplacingOccurrencesOfString:@"f" withString:@""];
    cardNo = [cardNo stringByReplacingOccurrencesOfString:@"d" withString:@"*"];
    return cardNo;
}

// Get IP Address
+(NSString *)getIPAddress {
    /*
    NSString *address = @"";
    struct ifaddrs *temp_addr = NULL;
    while (temp_addr != NULL) {
        // Check if interface is en0 which is the wifi connection on the iPhone
        if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"] || [[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"pdp_ip0"])
        {
            //如果是IPV4地址，直接转化
            if (temp_addr->ifa_addr->sa_family == AF_INET){
                // Get NSString from C String
                address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
            }
            
            //如果是IPV6地址
            else if (temp_addr->ifa_addr->sa_family == AF_INET6){
                address = [self formatIPV6Address:((struct sockaddr_in6 *)temp_addr->ifa_addr)->sin6_addr];
                if (address && ![address isEqualToString:@""] && ![address.uppercaseString hasPrefix:@"FE80"]) break;
            }
        }
        
        temp_addr = temp_addr->ifa_next;
    }
    return address;
    */
    return  @"";
}

/**
 *  格式化IPV6
 *
 *  @param ipv6Addr IPV6 字符
 *
 *  @return IPV6 地址
 */
+(NSString *)formatIPV6Address:(struct in6_addr)ipv6Addr{
    /*
    NSString *address = nil;
    
    char dstStr[INET6_ADDRSTRLEN];
    char srcStr[INET6_ADDRSTRLEN];
    memcpy(srcStr, &ipv6Addr, sizeof(struct in6_addr));
    if(inet_ntop(AF_INET6, srcStr, dstStr, INET6_ADDRSTRLEN) != NULL){
        address = [NSString stringWithUTF8String:dstStr];
    }
    
    return address;
     */
    return  @"";
}

+(NSString *)getMacAddress
{
    /*
    int                 mgmtInfoBase[6];
    char                *msgBuffer = NULL;
    size_t              length;
    unsigned char       macAddress[6];
    struct if_msghdr    *interfaceMsgStruct;
    struct sockaddr_dl  *socketStruct;
    NSString            *errorFlag = NULL;
    
    // Setup the management Information Base (mib)
    mgmtInfoBase[0] = CTL_NET;        // Request network subsystem
    mgmtInfoBase[1] = AF_ROUTE;       // Routing table info
    mgmtInfoBase[2] = 0;
    mgmtInfoBase[3] = AF_LINK;        // Request link layer information
    mgmtInfoBase[4] = NET_RT_IFLIST;  // Request all configured interfaces
    
    // With all configured interfaces requested, get handle index
    if ((mgmtInfoBase[5] = if_nametoindex("en0")) == 0)
        errorFlag = @"if_nametoindex failure";
    else
    {
        // Get the size of the data available (store in len)
        if (sysctl(mgmtInfoBase, 6, NULL, &length, NULL, 0) < 0)
            errorFlag = @"sysctl mgmtInfoBase failure";
        else
        {
            // Alloc memory based on above call
            if ((msgBuffer = malloc(length)) == NULL)
                errorFlag = @"buffer allocation failure";
            else
            {
                // Get system information, store in buffer
                if (sysctl(mgmtInfoBase, 6, msgBuffer, &length, NULL, 0) < 0)
                    errorFlag = @"sysctl msgBuffer failure";
            }
        }
    }
    
    // Befor going any further...
    if (errorFlag != NULL)
    {
        NSLog(@"Error: %@", errorFlag);
        return errorFlag;
    }
    
    // Map msgbuffer to interface message structure
    interfaceMsgStruct = (struct if_msghdr *) msgBuffer;
    
    // Map to link-level socket structure
    socketStruct = (struct sockaddr_dl *) (interfaceMsgStruct + 1);
    
    // Copy link layer address data in socket structure to an array
    memcpy(&macAddress, socketStruct->sdl_data + socketStruct->sdl_nlen, 6);
    
    // Read from char array into a string object, into traditional Mac address format
    NSString *macAddressString = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x",
                                  macAddress[0], macAddress[1], macAddress[2],
                                  macAddress[3], macAddress[4], macAddress[5]];
    NSLog(@"Mac Address: %@", macAddressString);
    
    // Release the buffer memory
    free(msgBuffer);
    
    return macAddressString;
     */
    return  @"";
}

/** 根据颜色生成图片 */
+(UIImage *)buttonImageFromColor:(UIColor *)color{
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext(); return img;
}

@end
