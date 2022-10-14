//
//  NSDictionary+Common.h
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (Common)
@property (nonatomic, assign) BOOL success;
@property (nonatomic, assign, readonly) BOOL isAble;
/**
 *  转字符串
 *
 *  @return <#return value description#>
 */
- (NSString *)JSONRepresentation;

- (NSData *)conversionData;

@end

@interface NSMutableDictionary (Common)

- (void)setValue:(NSString *)value key:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
