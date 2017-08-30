//
//  JTLWAuthCode.h
//  jitailianwang
//
//  Created by haohao on 16/10/11.
//  Copyright © 2016年 qiandai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^getAuthCodeBlock)(NSString* codeStr);

@interface QDBAuthCode : UIView

+(instancetype)shareQDBAuthCode;

@property (nonatomic, copy) getAuthCodeBlock authCodeBlock;

- (void)returnAuthCode:(getAuthCodeBlock)block;
-(void)getNewAuthCode;
@end
