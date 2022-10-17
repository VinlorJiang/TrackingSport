//
//  AFHTTPSessionManager+TSConfig.h
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/17.
//

#import "AFHTTPSessionManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface AFHTTPSessionManager (TSConfig)

+ (instancetype)ts_createDefaultManager;

+ (instancetype)ts_createImageManager;

+ (instancetype)ts_createJSONManager;

+ (instancetype)ts_getLaunchList;

+ (instancetype)ts_POSImageManager;

@end

NS_ASSUME_NONNULL_END
