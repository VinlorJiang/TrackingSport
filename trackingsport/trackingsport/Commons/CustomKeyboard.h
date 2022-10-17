//
//  CustomKeyboard.h
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CustomKeyboardProtocol <NSObject>
@optional
/** 输入改变  自定义的唯独不响应这个代理 其他代理可以遵循TextField原有代理*/
- (void)customTextFieldDidChange:(UITextField *)textField;
/** 是否响应输出入*/
- (BOOL)responseInputWithTextField:(UITextField *)textField textFieldString:(NSString *)textFieldString;
@end

typedef NS_ENUM(NSInteger, CustomKeyboardType) {
    KeyboardOnlyNumber = 1,
    KeyboardHavePoint,
    KeyboardHavePointAmount,  //金额 .只有1个 .不能开头 .后保留两位  最高10位
    KeyboardOnlyNumberMaxSix, //纯数字6位

    KeyboardNumberWithSpace,  //纯数字带空格 4位空格
    KeyboardNumberWithSpaceX, //纯数字带空格 手机号格式
};
@interface CustomKeyboard : UIView
@property (nonatomic, weak) id<CustomKeyboardProtocol> delegate;
@property (nonatomic, assign) CustomKeyboardType type;

+ (instancetype)KeyboardWithTextField:(UITextField *)textField keyboardType:(CustomKeyboardType)type;
+ (instancetype)KeyboardWithTextField:(UITextField *)textField
                             delegate:(id<CustomKeyboardProtocol>)delegate
                         keyboardType:(CustomKeyboardType)type;
@end
NS_ASSUME_NONNULL_END
