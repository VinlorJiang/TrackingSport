//
//  UIBarButtonItem+Common.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/11/15.
//

#import "UIBarButtonItem+Common.h"
#import <objc/runtime.h>
static char barButtonItemKey;
static char barButtonItemHaveTitleKey;
static char barButtonItemCustomTitleKey;
static char barButtonItemImageWithTitleKey;

@implementation UIBarButtonItem (Common)

+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title tintColor:(UIColor *)tintColor action:(void (^)(void))action {
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:nil action:nil];
    [barButtonItem setTitleTextAttributes:@{ NSFontAttributeName: KFont(16) } forState:UIControlStateNormal];
    [barButtonItem setAction:@selector(barButtonClick)];
    objc_setAssociatedObject(barButtonItem, &barButtonItemHaveTitleKey, action, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    barButtonItem.tintColor = tintColor ?: [UIColor buttonEnabledColor];
    return barButtonItem;
}

/** button 图片 */
+ (UIBarButtonItem *)barButtonItemWithImageName:(NSString *)imageName highlightedImageName:(NSString *)highlightedImageName action:(void (^)(void))action {
    
    UIButton *button = [[UIButton alloc] init];
    button.respondTime = 0.5;
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];

    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    if (highlightedImageName) {
        [button setBackgroundImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    }
    button.size = button.currentBackgroundImage.size;
    [button addTarget:barButtonItem action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    objc_setAssociatedObject(button, &barButtonItemKey, action, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return barButtonItem;
}
- (void)click:(UIButton *)btn {
    void (^block)(void) = (void (^)(void)) objc_getAssociatedObject(btn, &barButtonItemKey);
    if (block) block();
}
- (void)barButtonClick {
    void (^block)(void) = (void (^)(void)) objc_getAssociatedObject(self, &barButtonItemHaveTitleKey);
    if (block) block();
}

/** button 自定义的文字 */
+ (UIBarButtonItem *)barButtonCustomWithTitle:(NSString *)title tintColor:(UIColor *)tintColor action:(void (^)(void))action {

    CGFloat width = [title getWidthWithFont:16.2];
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, 20)];
    rightButton.respondTime = 0.5;
    objc_setAssociatedObject(rightButton, &barButtonItemCustomTitleKey, action, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    [rightButton addTarget:barButtonItem action:@selector(rightBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.title = title;
    rightButton.titleColor = tintColor ?: [UIColor buttonEnabledColor];
    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16.2];
    rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -5);
    return barButtonItem;
}
- (void)rightBarButtonClick:(UIButton *)btn {
    void (^block)(void) = (void (^)(void)) objc_getAssociatedObject(btn, &barButtonItemCustomTitleKey);
    if (block) block();
}




/** button 自定义带图片带文字 */
+ (UIBarButtonItem *)barButtonItemWithImageName:(NSString *)imageName
                           highlightedImageName:(NSString *)highlightedImageName
                                          title:(NSString *)title
                                         action:(void (^)(void))action {

    UIImage *image = [UIImage imageNamed:imageName];
    UIButton *backgroundView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    backgroundView.respondTime = 0.5;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-5, 0, image.size.width, image.size.height)];
    imageView.image = image;
    imageView.centerY = backgroundView.height / 2;
    [backgroundView addSubview:imageView];

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right + 5, 0, 60 - imageView.width, 25)];
    titleLabel.centerY = backgroundView.height / 2 + 0.6;
    titleLabel.text = title;
    titleLabel.font = KFont(16);
    titleLabel.textColor = [imageName isEqualToString:@"返回_Balance"] ? WhiteColor : [UIColor buttonEnabledColor];
    [backgroundView addSubview:titleLabel];

    objc_setAssociatedObject(backgroundView, &barButtonItemImageWithTitleKey, action, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backgroundView];
    [backgroundView addTarget:barButtonItem action:@selector(BarButtonClickImageWithTitle:) forControlEvents:UIControlEventTouchUpInside];
    return barButtonItem;
}
- (void)BarButtonClickImageWithTitle:(UIButton *)btn {
    void (^block)(void) = (void (^)(void)) objc_getAssociatedObject(btn, &barButtonItemImageWithTitleKey);
    if (block) block();
}
@end

