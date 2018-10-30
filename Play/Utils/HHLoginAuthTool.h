//
//  HHLoginAuthTool.h
//  
//
//  Created by haohao on 2018/10/30.
//  Copyright © 2018年 haohao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^getAuthResultBlock)(BOOL result,NSError* error    );

@interface HHLoginAuthTool : NSObject

+(instancetype)shareLoginAuth;

-(void)loginByLocalAuth:(getAuthResultBlock)block;

@end

