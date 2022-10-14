//
//  NSDictionary+Common.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/12.
//

#import "NSDictionary+Common.h"

@implementation NSDictionary (Common)
@dynamic success;
- (NSString *)JSONRepresentation {
    NSData *data = [self conversionData];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSData *)conversionData {
    return [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];
}
- (BOOL)success {
    return [[self objectForKey:@"status"] isEqualToString:@"0"];
}
@end

@implementation NSMutableDictionary (Common)

- (void)setValue:(NSString *)value key:(NSString *)key {
    if (value) {
        self[key] = value;
    }
}

+ (void)load {
    
    Class NSDictionaryI = NSClassFromString(@"__NSDictionaryI");
    Class NSDictionaryM = NSClassFromString(@"__NSDictionaryM");

    [NSDictionaryI swizzleInstanceMethod:@selector(setObject:forKey:) with:@selector(safeSetObject:forKey:)];
    [NSDictionaryM swizzleInstanceMethod:@selector(setObject:forKey:) with:@selector(safeSetObject:forKey:)];

    [NSDictionaryI swizzleInstanceMethod:@selector(objectForKey:) with:@selector(safeObjectForKey:)];
    [NSDictionaryM swizzleInstanceMethod:@selector(objectForKey:) with:@selector(safeObjectForKey:)];
}
- (void)safeSetObject:(id)anObject forKey:(id)aKey {
    if (aKey == nil || anObject == nil) {
        NSLog(@"__________________________________________________字典插入对象为空");
        NSLog(@"__________________________________________________字典插入对象为空");
        NSLog(@"__________________________________________________字典插入对象为空");
        __NSLog(@"键名 key === %@", aKey);
        return;
    }
    [self safeSetObject:anObject forKey:aKey];
}
- (nullable id)safeObjectForKey:(NSString *)anAttribute {
    id object = [self safeObjectForKey:anAttribute];
    if (object == [NSNull null]) return nil;
    return object;
}
- (BOOL)isAble {
    return (self && [self isKindOfClass:[NSDictionary class]]);
}
@end
