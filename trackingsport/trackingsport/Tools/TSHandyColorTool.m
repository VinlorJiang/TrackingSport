//
//  TSHandyColorTool.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/17.
//

#import "TSHandyColorTool.h"
#import <mach/mach.h>
#import"sys/utsname.h"



UIColor* color_rgb(NSInteger r, NSInteger g, NSInteger b)
{
    return color_rgba(r, g, b, 1.f);
}

UIColor* color_rgba(NSInteger r, NSInteger g, NSInteger b, CGFloat a)
{
    return [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a];
}


UIColor* color_black()
{
    return color_black_alpha(1.f);
}

UIColor* color_black_alpha(CGFloat alpha)
{
    return [[UIColor blackColor] colorWithAlphaComponent:alpha];
}

UIColor* color_gray()
{
    return color_gray_alpha(1.f);
}

UIColor* color_gray_toback()
{
    return color_gray_alpha(0.1f);
}

UIColor* color_gray_alpha(CGFloat alpha)
{
    return [[UIColor grayColor] colorWithAlphaComponent:alpha];
}

UIColor* color_white()
{
    return color_white_alpha(1.f);
}

UIColor* color_white_alpha(CGFloat alpha)
{
    return [[UIColor whiteColor] colorWithAlphaComponent:alpha];
}

UIColor* color_clear()
{
    return [UIColor clearColor];
}

UIColor* color_hex(NSString* hex)
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) return [UIColor clearColor];
    
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor clearColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return color_rgb(r, g, b);
}

UIColor* color_hex_alpha(NSString* hex, CGFloat aaa )
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) return [UIColor clearColor];
    
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor clearColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return color_rgba(r, g, b, aaa);
}


//1.6.3+
/**
 *  六种颜色规范
 *
 *  @return <#return value description#>
 */


// 选择的蓝色
UIColor* color_lightBlue(){
    return color_hex(@"#00aaeb");
}
// 下一步按钮的背景红色
UIColor* color_red(){
    return color_hex(@"#e64346");
}
//  正常字体的颜色
UIColor* color_custemGray(){
    return color_hex(@"#5f6d78");
}

// 部分按钮的绿色
UIColor* color_green(){
    return color_hex(@"#0bc046");
}
//  弹框选择按钮文字的蓝色
UIColor* color_blue(){
    return color_hex(@"#0069f3");
}
//  引导、未填写信息、未选择按钮、分割线的浅灰色
UIColor* color_lightGray(){
    return color_hex(@"#c2c8cc");
}

/**
 *  2.0.0版本的字体颜色
 *
 *  @param size
 *
 *  @return
 */
// 下标的蓝色
UIColor* color_FirstView(){
    return color_hex(@"#20a0e6");
}

UIColor* color_selectBlue(){
    return color_hex(@"#26abf4");
}
// 首页按钮字体灰色
UIColor *color_525252() {
    return color_hex(@"#525252");
}
// 灰色字体
UIColor *color_A0A0A0() {
    return color_hex(@"#A0A0A0");
}
// 纯白色
UIColor *color_FFFFFF() {
    return color_hex(@"#FFFFFF");
}
// 分割线灰色
UIColor *color_E6E6E6() {
    return color_hex(@"#E6E6E6");
}
// 右按钮白色
UIColor *color_FEFEFE() {
    return color_hex(@"#FEFEFE");
}
// 首页背景颜色
UIColor *color_F5F5F5() {
    return color_hex(@"#F5F5F5");
}
// 背景颜色 灰色
UIColor *color_F4F4F9() {
    return color_hex(@"#F4F4F9");
}
// 字体颜色 黑色
UIColor *color_383838() {
    return color_hex(@"#383838");
}

UIFont* font_sys(CGFloat size) {
    return adjustsSizeToFitFont(size);
}

UIFont* font_bold(CGFloat size) {
    return adjustsSizeToFitBoldFont(size);
}

UIImage* image_name(NSString* name) {
    return [UIImage imageNamed:name];
}

UIImage* image_color(UIColor* color) {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

NSString *string_i(int x) {
    return [NSString stringWithFormat:@"%d",x];
}

NSString *string_l(long x) {
    return [NSString stringWithFormat:@"%ld",x];
}

NSString *string_f(float x) {
    return [NSString stringWithFormat:@"%f",x];
}

NSString* string_format(NSString* string, ...) {
    //提取不定参数比塞进集合里面
    NSMutableArray* arrays = [NSMutableArray array];
    va_list arguments;
    id eachObject;
    if (string) {
        [arrays addObject:string];
        va_start(arguments, string);
        
        while ((eachObject = va_arg(arguments, id))) {
            [arrays addObject:eachObject];
        }
    }
    va_end(arguments);
    
    NSString *results = @"";
    
    for (NSString* string in arrays) {
        results = [results stringByAppendingString:string];
    }
    
    return results;
}

BOOL string_equal(NSString* string1, NSString* string2) {
    return [string1 isEqualToString:string2];
}

void notification_post(NSString* name, id object) {
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:object];
}

void notification_add(id observer, SEL selector, NSString* name, id object) {
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:name object:object];
}

void notification_remove(id observer, NSString* name, id object) {
    [[NSNotificationCenter defaultCenter] removeObserver:observer name:name object:object];
}

NSIndexPath* indexPath_row_section(NSInteger row, NSInteger section) {
    return [NSIndexPath indexPathForRow:row inSection:section];
}

NSArray* Array() {
    return [NSArray new];
}

NSMutableArray* MutableArray() {
    return [NSMutableArray new];
}

NSDictionary* Dictionary() {
    return [NSDictionary new];
}

NSMutableDictionary* MutableDictionary() {
    return [NSMutableDictionary new];
}

CGFloat sys_screen_width() {
    return [UIScreen mainScreen].bounds.size.width;
}

CGFloat sys_screen_height() {
    return [UIScreen mainScreen].bounds.size.height;
}

CGFloat sys_total_disk_space() {
    //苹果的计量是1000而不是1024！！
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [[fattributes objectForKey:NSFileSystemSize] floatValue ]/ 1000.0f / 1000.0f / 1000.0f;
}

CGFloat sys_free_disk_space() {
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [[fattributes objectForKey:NSFileSystemFreeSize] floatValue ]/ 1000.0 / 1000.0 ;
}

CGFloat sys_available_memory() {
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(),
                                               HOST_VM_INFO,
                                               (host_info_t)&vmStats,
                                               &infoCount);
    
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    
    return ((vm_page_size *vmStats.free_count) / 1000.0) / 1000.0;
}

CGFloat sys_used_memory() {
    if ( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad ) {
        return YES;
    }
    return NO;
}

NSString* sys_name() {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *displayName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    if (displayName == nil || [displayName isEqualToString:@""]) {
        return [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey];
    }
    return displayName;
}

NSString* sys_project_name() {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey];
}

NSString* sys_bundle_name() {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleNameKey];
}

NSString* sys_identifier() {
    return [[NSBundle mainBundle] bundleIdentifier];
}

NSString* sys_version() {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return  [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

NSString* sys_build() {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return  [infoDictionary objectForKey:@"CFBundleVersion"];
}

NSString* sys_current_device_information() {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6Plus";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    
    if ([platform isEqualToString:@"i386"])      return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"Simulator";
    return platform;
}

NSString* sys_device_name() {
    return [[UIDevice currentDevice] name];
}

NSString* sys_device_system_name() {
    return [[UIDevice currentDevice] systemName];
}

NSString* sys_device_version() {
    return [[UIDevice currentDevice] systemVersion];
}

NSString* sys_device_model() {
    return [[UIDevice currentDevice] model];
}

NSString* sys_device_language() {
    return [[NSLocale preferredLanguages] objectAtIndex:0];
}

NSString* sys_device_country() {
    return [[NSLocale currentLocale] localeIdentifier];
}

CGFloat sys_device_size() {
    int width = [UIScreen mainScreen].bounds.size.width;
    int height = [UIScreen mainScreen].bounds.size.height;
    if (width == 320 && height == 480) {
        return 3.5;
    }else if (width == 320 && height == 568){
        return 4.0;
    }else if (width == 375 && height == 667){
        return 4.7;
    }else if (width == 414 && height == 736){
        return 5.5;
    }
    return -1;
}

BOOL sys_isIOSX(CGFloat versoin) {
    return  ([[[UIDevice currentDevice]systemVersion] floatValue] >= versoin);
}

BOOL sys_isIOS8() {
    return  sys_isIOSX(8.0);
}

BOOL sys_isIOS7() {
    return  sys_isIOSX(7.0);
}

UIView* View() {
    return [[UIView alloc] init];
}

UIView* View_Rect(CGFloat x, CGFloat y, CGFloat width, CGFloat height) {
    return [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
}

UILabel* Label() {
    return [UILabel new];
}

UILabel* Label_Rect(CGFloat x, CGFloat y, CGFloat width, CGFloat height) {
    return [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
}

UIButton* Button() {
    return [UIButton new];
}

UIButton* Button_Rect(CGFloat x, CGFloat y, CGFloat width, CGFloat height) {
    return [[UIButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
}

UITableView* TableView(id<UITableViewDataSource> dataSoure, id<UITableViewDelegate> delegate) {
    return TableView_Rect(0, 0, 0, 0, dataSoure, delegate);
}

UITableView* TableView_Rect(CGFloat x, CGFloat y, CGFloat width, CGFloat height,id<UITableViewDataSource> dataSoure, id<UITableViewDelegate> delegate) {
    UITableView *tableView = [UITableView new];
    tableView.frame = CGRectMake(x, y, width, height);
    tableView.dataSource = dataSoure;
    tableView.delegate = delegate;
    
    return tableView;
}


