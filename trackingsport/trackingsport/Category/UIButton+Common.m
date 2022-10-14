//
//  UIButton+CommonClass.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/12.
//

#import "UIButton+Common.h"
#import <objc/runtime.h>

@interface UIButton ()
@property (nonatomic, assign) BOOL touching;
@property (nonatomic, copy) NSString *originalTitle;
@end
static char TouchUpInsideKey;
static char topNameKey;
static char bottomNameKey;
static char leftNameKey;
static char rightNameKey;

@implementation UIButton (Common)

+ (void)load {
    [self swizzleInstanceMethod:@selector(sendAction:to:forEvent:) with:@selector(dp__sendAction:to:forEvent:)];
}
- (void)blockWithControlEventTouchUpInsideWithBlock:(void (^)(void))block {
    objc_setAssociatedObject(self, &TouchUpInsideKey, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addTarget:self action:@selector(callActionBlock:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)callActionBlock:(id)sender {
    void (^buttonBlock)(void) = (void (^)(void)) objc_getAssociatedObject(self, &TouchUpInsideKey);
    if (buttonBlock) buttonBlock();
}
// 设置图片字体上下对齐
- (void)alineImageAndTitle:(CGFloat)space {
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGSize textSize = [self.titleLabel.text sizeWithAttributes:@{ NSFontAttributeName: self.titleLabel.font }];

    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + space);
    self.imageEdgeInsets = UIEdgeInsetsMake(-(totalHeight - imageSize.height), 0.0, 0.0, -titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width, -(totalHeight - titleSize.height), 0);
}
//左图右字
- (void)horizontalCenterTitleAndImage:(CGFloat)space {
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width, 0.0, imageSize.width + space / 2);
    titleSize = self.titleLabel.frame.size;
    self.imageEdgeInsets = UIEdgeInsetsMake(0.0, titleSize.width + space / 2, 0.0, -titleSize.width);
}

- (void)horizontalCenter_Alignmen_Image:(CGFloat)space contentHorizontalAlignment:(UIControlContentHorizontalAlignment)Alignment {
    if (Alignment == UIControlContentHorizontalAlignmentCenter) {
    } else if (Alignment == UIControlContentHorizontalAlignmentLeft) {
        self.imageEdgeInsets = UIEdgeInsetsMake(0.0, space, 0.0, 0);
    } else if (Alignment == UIControlContentHorizontalAlignmentRight) {
        self.imageEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, space);
    } else if (Alignment == UIControlContentHorizontalAlignmentFill) {
        self.imageEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, space, 0);
    }
    self.contentHorizontalAlignment = Alignment;
}

- (void)horizontalCenter_Alignmen_Image:(CGFloat)space title:(CGFloat)T_space {
    self.imageEdgeInsets = UIEdgeInsetsMake(0.0, space, 0.0, 0);
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, space + T_space, 0.0, -30.0);
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
}

//扩大点击
- (void)setEnlargeEdgeWithTop:(CGFloat)top left:(CGFloat)left right:(CGFloat)right bottom:(CGFloat)bottom {
    objc_setAssociatedObject(self, &topNameKey, @(top), OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, @(right), OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, @(bottom), OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, @(left), OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (CGRect)enlargedRect {
    NSNumber *topEdge = objc_getAssociatedObject(self, &topNameKey);
    NSNumber *rightEdge = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber *bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber *leftEdge = objc_getAssociatedObject(self, &leftNameKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge) {
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue, self.bounds.origin.y - topEdge.floatValue, self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    } else
        return self.bounds;
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect rect = [self enlargedRect];
    if (CGRectEqualToRect(rect, self.bounds)) {
        return [super hitTest:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? self : nil;
}

- (void)setHighlightColor {
    [self addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)touchDown:(UIButton *)btn {
    if (btn.alpha < 1) return;
    btn.backgroundColor = KRGBAColor(217, 217, 217, 0.9);
}
- (void)touchUpInside:(UIButton *)btn  {
    if (btn.alpha < 1)return;
    [UIView animateWithDuration:0.4 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        btn.alpha = 0;
    } completion:^(BOOL finished) {
        btn.backgroundColor = WhiteColor;
        btn.alpha = 1;
    }];
}
- (void)setTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
}
- (NSString *)title {
    return self.titleLabel.text;
}
- (void)setTitleColor:(UIColor *)titleColor {
    [self setTitleColor:titleColor forState:UIControlStateNormal];
}
- (UIColor *)titleColor {
    return self.titleLabel.textColor;
}
- (void)setRespondTime:(CGFloat)respondTime {
    [self setAssociateValue:@(respondTime) withKey:@selector(respondTime)];
}
- (CGFloat)respondTime {
    return [[self getAssociatedValueForKey:_cmd] floatValue];
}
- (void)setTouching:(BOOL)touching {
    [self setAssociateValue:@(touching) withKey:@selector(touching)];
}
- (BOOL)touching {
    return [[self getAssociatedValueForKey:_cmd] boolValue];
}
- (void)dp__sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {

    if (self.touching && self.respondTime > 0) {
        NSLog(@"button暂时不能点击");
        return;
    }
    if (self.respondTime > 0 && self.respondTime) {
        self.touching = YES;
        Kdispatch_after_main_queue(self.respondTime, ^{self.touching = NO;});
    }
    [self dp__sendAction:action to:target forEvent:event];
}

- (void)setIsRequestting:(BOOL)isRequestting {
    if (isRequestting) {
        self.originalTitle = self.title;
        self.title = @"";
        self.userInteractionEnabled = NO;
        UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 200, self.height)];
        activity.backgroundColor = ClearColor;
        activity.tag = 10000;
        activity.center = CGPointMake(self.width / 2, self.height / 2);
        [activity startAnimating];
        [self addSubview:activity];
        [self setAssociateValue:@YES withKey:@selector(isRequestting)];
    } else {
        UIActivityIndicatorView *activity = [self viewWithTag:10000];
        [activity removeFromSuperview];
        if (self.originalTitle) self.title = self.originalTitle;
        Kdispatch_after_main_queue(0.75, ^{
            self.userInteractionEnabled = YES;
            [self setAssociateValue:@NO withKey:@selector(isRequestting)];
        });
    }
}
- (BOOL)isRequestting {
    return [[self getAssociatedValueForKey:_cmd] boolValue];
}
- (void)setOriginalTitle:(NSString *)originalTitle {
    [self setAssociateValue:originalTitle withKey:@selector(originalTitle)];
}
- (NSString *)originalTitle {
    return [self getAssociatedValueForKey:_cmd];
}
@end
@implementation UIControl (Common)

- (void)blockWithControlEventTouchUpInsideWithBlock:(void (^)(void))block {
    objc_setAssociatedObject(self, &TouchUpInsideKey, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addTarget:self action:@selector(callActionBlock:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)callActionBlock:(id)sender {
    void (^buttonBlock)(void) = (void (^)(void)) objc_getAssociatedObject(self, &TouchUpInsideKey);
    if (buttonBlock) buttonBlock();
}
@end
