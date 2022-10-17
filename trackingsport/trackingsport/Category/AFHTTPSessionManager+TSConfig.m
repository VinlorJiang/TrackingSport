//
//  AFHTTPSessionManager+TSConfig.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/17.
//

#import "AFHTTPSessionManager+TSConfig.h"


 static NSString *const KURLString = @"https://www.baidu.com/";    //  正常的环境


 @implementation AFHTTPSessionManager (TSConfig)

 + (instancetype)ts_createDefaultManager {
     NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
     AFHTTPSessionManager *manager =
     [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:KURLString] sessionConfiguration:configuration];
     manager.responseSerializer.acceptableContentTypes =
     [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
#if DEBUG
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
#endif
    [manager.requestSerializer setTimeoutInterval:30];
    return manager;
}

+ (instancetype)ts_createImageManager {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:KURLString]];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"image/png", nil];
#if DEBUG
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
#endif
    [manager.requestSerializer setTimeoutInterval:30];
    return manager;
}

+ (instancetype)ts_POSImageManager {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:KURLString]];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/plain",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         nil];
#if DEBUG
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
#endif
    [manager.requestSerializer setTimeoutInterval:180];
    return manager;
}

+ (instancetype)ts_createJSONManager {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:KURLString]];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
#if DEBUG
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
#endif
    [manager.requestSerializer setTimeoutInterval:30];
    return manager;
}

+ (instancetype)ts_getLaunchList {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:KURLString]];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
#if DEBUG
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
#endif
    [manager.requestSerializer setTimeoutInterval:2];
    return manager;
}

@end

