//
//  TSSizeAdaptationTool.h
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/17.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

/*!
 *  @author DT
 *
 *  @brief  根据屏幕等比放大缩小
 */

#pragma mark - 值按320屏幕等比放大缩小
/*!
 *  @author DT
 *
 *  @brief  值按320屏幕等比放大缩小
 *
 *  @param size 原始值
 *
 *  @return 等比放大缩小后的值
 */
//CGFloat adjustsSizeToFitWidth320(CGFloat size);

#pragma mark - 值按480屏幕等比放大缩小
/*!
 *  @author DT
 *
 *  @brief  值按480屏幕等比放大缩小
 *
 *  @param size 原始值
 *
 *  @return 等比放大缩小后的值
 */
CGFloat adjustsSizeToFitWidth480(CGFloat size);

#pragma mark - UIFont按320屏幕等比放大缩小
/*!
 *  @author DT
 *
 *  @brief  按屏幕宽度返回UIFont
 *
 *  @param pix 原始值
 *
 *  @return UIFont
 */
UIFont* adjustsSizeToFitFont(CGFloat pix);

UIFont* adjustsSizeToFitBoldFont(CGFloat pix);

/*!
 *  @author DT
 *
 *  @brief  获取多语言内容
 *
 *  @param str 内容标志
 *
 *  @return 内容
 */
NSString* getLocalizedString(NSString *str);


