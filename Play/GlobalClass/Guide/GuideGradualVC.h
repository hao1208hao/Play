//
//  GuideGradualVC.h
//  Play
//
//  Created by haohao on 2019/3/19.
//  Copyright © 2019 haohao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DidSelectedEnter)();


NS_ASSUME_NONNULL_BEGIN

@interface GuideGradualVC : UIViewController
 
@property (nonatomic, copy) DidSelectedEnter didSelectedEnter;

//普通引导页
- (id)initWithCoverImageNames:(NSArray*)coverNames;


//2组图片
- (id)initWithCoverImageNames:(NSArray*)coverNames backgroundImageNames:(NSArray*)bgNames;

//2组图片带按钮
- (id)initWithCoverImageNames:(NSArray*)coverNames backgroundImageNames:(NSArray*)bgNames button:(UIButton*)button;

 

@end

NS_ASSUME_NONNULL_END
