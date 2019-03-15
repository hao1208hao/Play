//
//  ScanQR.h
//  Play
//
//  Created by haohao on 16/7/21.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol scanResultDelegate <NSObject>

-(void)getScanResult:(NSString*)scanResult;

@end

//block 形式
typedef void(^scanResultBlock)(NSString* result);

@interface ScanQR : UIViewController

/** 扫描结果代理 */
@property(nonatomic,weak) id<scanResultDelegate> scanDelegate;

//block
@property(nonatomic,copy) scanResultBlock block;

/**
 *  扫描二维码
 */
-(void)scanQR;
@end
