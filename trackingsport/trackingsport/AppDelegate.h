//
//  AppDelegate.h
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/11.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
/** 个人ID */
@property (nonatomic, copy) NSString *accountId;
@property (assign, nonatomic) BOOL isLogin;           /** 是否登陆状态 */
@property (nonatomic, strong) NSString *userProfile;             //头像;
@end

