//
//  UIBarButtonItem+AD.h
//  QiandaiPersonalV2
//
//  Created by zhongad on 16/1/5.
//
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (AD)

/**
 *  item(只有图片)
 *
 *  @param icon     普通图片
 *  @param highIcon 高亮图片
 *  @param action   监听方法
 */
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action;

/**
 *  左item(图片 + 标题)
 *
 *  @param icon   图片
 *  @param title  标题
 *  @param action 监听方法
 */

+ (UIBarButtonItem *)leftItemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon title:(NSString *)title target:(id)target action:(SEL)action;

/**
 *  右item(图片 + 标题)
 *
 *  @param icon   图片
 *  @param title  标题
 *  @param action 监听方法
 */

+ (UIBarButtonItem *)rightItemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon title:(NSString *)title target:(id)target action:(SEL)action;

/**
 *  item(只有标题)
 *
 *  @param title  标题
 *  @param action 监听方法
 */
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

/**
 *  返回item(back + 点击事件)
 *
 *  @param action   监听方法
 */
+ (UIBarButtonItem *)itemWithBackTarget:(id)target action:(SEL)action;

/**
 *  返回item(Dismiss)
 */
+ (UIBarButtonItem *)itemWithDismissTarget:(id)target;

/**
 *  返回item(RootViewController)
 */
+ (UIBarButtonItem *)itemToRootTarget:(id)target;

@end
