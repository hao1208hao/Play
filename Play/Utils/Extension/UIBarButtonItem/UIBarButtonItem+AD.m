//
//  UIBarButtonItem+AD.m
//  QiandaiPersonalV2
//
//  Created by zhongad on 16/1/5.
//
//

#import "UIBarButtonItem+AD.h"

#define TitleFont @14
#define NavBtnTitleFont [UIFont systemFontOfSize:14]
#define Padding 12

@interface UIBarButtonItem ()

@end

@implementation UIBarButtonItem (AD)

- (instancetype)initWithFrame:(CGRect)frame {
    self = [self initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

/**
 *  字体的基本设置
 */
- (void)setup {
    
}

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action {
    UIButton *button = [self buttonWithIcon:icon highIcon:highIcon target:target action:action];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)leftItemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon title:(NSString *)title target:(id)target action:(SEL)action {
    UIButton *button = [self buttonWithIcon:icon highIcon:highIcon target:target action:action];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -18 * RATIO, 0, 0);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -5 * RATIO, 0, 0);
    // 返回标题所占的尺寸大小
    CGSize textSize = [self sizeWithString:title];
    [button setTitle:title forState:UIControlStateNormal];
    CGFloat buttonW = textSize.width + button.currentImage.size.width;
    CGFloat buttonH = button.currentImage.size.height;
    button.frame = CGRectMake(0, 0, buttonW, buttonH);
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)rightItemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon title:(NSString *)title target:(id)target action:(SEL)action {
    UIButton *button = [self buttonWithIcon:icon highIcon:highIcon target:target action:action];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 5 * RATIO, 0, 0);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 18 * RATIO, 0, 0);

    // 返回标题所占的尺寸大小
    CGSize textSize = [self sizeWithString:title];
    [button setTitle:title forState:UIControlStateNormal];
    CGFloat buttonW = textSize.width + button.currentImage.size.width+25;
    CGFloat buttonH = button.currentImage.size.height;
    button.frame = CGRectMake(0, 0, buttonW, buttonH);
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

/**
 *  返回一个字符串所占的尺寸大小
 *
 *  @param str 字符串
 *  @return size
 */
+ (CGSize)sizeWithString:(NSString *)str {
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:str];
    NSRange range = NSMakeRange(0, attrStr.length);
    NSDictionary *dic = [attrStr attributesAtIndex:0 effectiveRange:&range];   // 获取该段attributedString的属性字典
    // 计算文本的大小
    CGSize size = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) // 用于计算文本绘制时占据的矩形块
                                          options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                                       attributes:dic        // 文字的属性
                                          context:nil].size; // context上下文。包括一些信息，例如如何调整字间距以及缩放。该对象包含的信息将用于文本绘制。该参数可为nil
    return size;
}

/**
 *  通过图片创建一个按钮
 *
 *  @param icon     图片
 *  @param highIcon 高亮图片
 *  @param target   执行者
 *  @param action   点击事件
 *
 *  @return 按钮
 */
+ (UIButton *)buttonWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:GlobalTextHighColor forState:UIControlStateHighlighted];
    button.titleLabel.font = NavBtnTitleFont;
    button.frame = (CGRect){CGPointZero, button.currentImage.size};
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:GlobalTextHighColor forState:UIControlStateHighlighted];
    button.titleLabel.font = NavBtnTitleFont;
    CGSize size = [self sizeWithString:title];
    button.frame = CGRectMake(0, 0, size.width + Padding, size.height);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)itemWithBackTarget:(id)target action:(SEL)action {
    return [self itemWithIcon:@"navBack" highIcon:@"navBack" target:target action:action];
}

+ (UIBarButtonItem *)itemWithDismissTarget:(id)target {
    return [self itemWithIcon:@"navBack" highIcon:@"navBack" target:target action:@selector(backWithDismiss:)];
}

/**
 *  dismiss返回点击事件
 */
- (void)backWithDismiss:(id)target {
    [target dismissViewControllerAnimated:YES completion:^{}];
}

+ (UIBarButtonItem *)itemToRootTarget:(id)target {
    return [self itemWithIcon:@"navBack" highIcon:@"navBack" target:target action:@selector(backWithToRootVC:)];
}

/**
 *  dismiss返回点击事件
 */
- (void)backWithToRootVC:(id)target {
    [target popToRootViewControllerAnimated:YES];
}

@end
