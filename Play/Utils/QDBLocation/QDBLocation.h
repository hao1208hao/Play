//
//  QDBLocation.h
//  qiandaibao_pos
//
//  Created by haohao on 16/5/6.
//  Copyright © 2016年 钱袋宝. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface QDBLocation : CLLocationManager

SingletonH(instance);
/**
 *  开始定位
 */
-(void) startLocationMonitor;
/**
 *  关闭定位
 */
-(void)stopLocation;

/**
 *  获取位置信息
 *
 *  @return 位置信息
 */
-(NSString*)getLocation;

/**
 *  获取经度
 *
 *  @return 返回经度
 */
-(NSString*)getLongitude;

/**
 *  获取纬度
 *
 *  @return 返回纬度
 */
-(NSString*)getLatitude;
@end
