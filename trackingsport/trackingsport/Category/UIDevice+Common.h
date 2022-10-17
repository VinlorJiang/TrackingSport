//
//  UIDevice+Common.h
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (Common)
+ (NSString *)currentplatformName;

+ (double)systemVersion;

- (BOOL)isSimulator;
@end

NS_ASSUME_NONNULL_END
