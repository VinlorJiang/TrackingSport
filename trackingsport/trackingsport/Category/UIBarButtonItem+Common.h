//
//  UIBarButtonItem+Common.h
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/11/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (Common)
/** UIBarButtonItem 系统的 有键盘出现 系统的会失去响应  */
+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title tintColor:(UIColor *)tintColor action:(void (^)(void))action;

/** button 自定义的 */
+ (UIBarButtonItem *)barButtonCustomWithTitle:(NSString *)title tintColor:(UIColor *)tintColor action:(void (^)(void))action;

/** button 自定义带图片 */
+ (UIBarButtonItem *)barButtonItemWithImageName:(NSString *)imageName
                           highlightedImageName:(NSString *)highlightedImageName
                                         action:(void (^)(void))action;

/** button 自定义带图片带文字 */
+ (UIBarButtonItem *)barButtonItemWithImageName:(NSString *)imageName
                           highlightedImageName:(NSString *)highlightedImageName
                                          title:(NSString *)title
                                         action:(void (^)(void))action;

@end

NS_ASSUME_NONNULL_END
