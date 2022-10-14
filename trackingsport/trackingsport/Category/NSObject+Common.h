//
//  NSObject+Common.h
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/12.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Common)
/** GCD定时器 */
- (dispatch_source_t)startTimingWithInterval:(float)interval backBlock:(BOOL (^)())block;

/** runtime替换方法 */
+ (BOOL)swizzleClassMethod:(SEL)originalSel with:(SEL)newSel;    //类方法
+ (BOOL)swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel; //对象方法

/** runtime获取所有属性 */
+ (NSArray *)getFropertys;


/** 绑定 */
- (void)setAssociateValue:(nullable id)value withKey:(void *)key;
- (void)setAssociateWeakValue:(nullable id)value withKey:(void *)key;

/** 获取 */
- (nullable id)getAssociatedValueForKey:(void *)key;

/** kvo block*/
- (void)addObserverBlockForKeyPath:(NSString *)keyPath block:(void (^)(id _Nonnull obj, id _Nonnull oldVal, id _Nonnull newVal))block;
- (void)removeObserverBlocksForKeyPath:(NSString *)keyPath;
- (void)removeObserverBlocks;

//解归档 需实现归档协议
- (BOOL)archiverWithPath:(NSString *)path;
+ (instancetype)unArchiverWithPath:(NSString *)path;

//储存(获取)头像
+ (BOOL)storageImageWithUserProfileImage:(UIImage *)userProfileImage;
+ (NSString *)getProfileImageWithInputString:(NSString *)InputString;
@end

NS_ASSUME_NONNULL_END
