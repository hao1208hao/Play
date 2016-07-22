//
//  HYKeyboard.h
//  UnionPay
//   SDKVersion 1.1 last update 2015-12-02
//  Created by liuzhen on 2012-02-24.
//  Copyright 2012 com.secneo.www. All rights reserved.
//

#import <UIKit/UIKit.h>


//======================================================================================================================================================================================================
//
typedef enum _HYKeyboardType
{
    /**显示安全键盘类型默认值 */
	HYKeyboardTypeNone = 0,
    /**安全键盘数字输入类型 */
	HYKeyboardTypeNumber = 1 << 0,
    /**安全键盘字母输入类型 */
	HYKeyboardTypeLetter = 1 << 1,
    /**安全键盘符号输入类型 */
	HYKeyboardTypeSymbol = 1 << 2
}HYKeyboardType;

//======================================================================================================================================================================================================
//

@protocol HYKeyboardDelegate <NSObject>
/**安全键盘点击确定回调方法,输入的内容以NSArray返回
 @textField 传入的宿主输入框对象
 @arrayText安全键盘输入的内容，NSString单个对象的Array
 */
-(void)inputOverWithTextField:(UITextField*)textField inputArrayText:(NSArray*)arrayText;
/**安全键盘点击确定回调方法,输入的内容以NSString返回
 @textField 传入的宿主输入框对象
 @text安全键盘输入的内容，NSString
 */
-(void)inputOverWithTextField:(UITextField*)textField inputText:(NSString*)text;

@end

@interface HYKeyboard : UIViewController

/**弹出安全键盘的宿主控制器*/
@property (nonatomic, assign) UIViewController * hostViewController;
/**弹出安全键盘的宿主输入框*/
@property (nonatomic, assign) UITextField * hostTextField;
/**背景提示*/
@property (nonatomic, copy)   NSString * stringPlaceholder;

/**是否输入内容加密*/
@property (nonatomic, assign) BOOL secure;
/**hostTextField输入框同步更新，用*填充*/
@property (nonatomic, assign) BOOL synthesize;
/**是否清空输入框内容*/
@property (nonatomic, assign) BOOL shouldClear;
/**输入框输入的最大长度*/
@property (nonatomic, assign) int intMaxLength;
/**安全键盘输入类型*/
@property (nonatomic, assign) HYKeyboardType keyboardType;
/**已有的内容NSArray保存*/
@property (nonatomic, retain) NSMutableArray * arrayText;
/**已有的内容，必须在设置secure之后调用*/
@property (nonatomic, retain) NSString * contentText;

/**安全键盘事件回调，必须实现HYKeyboardDelegate内的其中一个*/
@property (nonatomic, retain) id<HYKeyboardDelegate> keyboardDelegate;

/**是否设置按钮无按压和动画效果*/
@property (nonatomic, assign) BOOL btnPressAnimation;

/**是否设置按钮随机变化*/
@property (nonatomic, assign) BOOL btnrRandomChange;

/**是否显示密码明文动画*/
@property (nonatomic, assign) BOOL shouldTextAnimation;

/**更新安全键盘输入类型*/
- (void)shouldRefresh:(HYKeyboardType)type;

@end










