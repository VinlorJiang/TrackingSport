//
//  UITextField+Common.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/17.
//

#import "UITextField+Common.h"

@implementation UITextField (Common)
@dynamic startDistance;
@dynamic endDistance;
@dynamic latterIsSpace;
@dynamic previousIsSpace;
@dynamic lastIsSpace;
@dynamic selectedNumbers;
@dynamic currOffset;

//光标距离末尾
- (NSInteger)endDistance {
    NSInteger end = [self offsetFromPosition:self.endOfDocument toPosition:self.selectedTextRange.end];
    if (end > 0) end = 0;
    if (ABS(end) > self.text.length) end = self.text.length;
    return end;
}
//光标距离开头
- (NSInteger)startDistance {
    NSInteger start = [self offsetFromPosition:self.beginningOfDocument toPosition:self.selectedTextRange.start];
    if (start < 0) start = 0;
    if (start > self.text.length) start = self.text.length;
    return start;
}
//选中了多少个
- (NSInteger)selectedNumbers {
    NSInteger selected = [self offsetFromPosition:self.selectedTextRange.start toPosition:self.selectedTextRange.end];
    if (selected < 0) selected = 0;
    return selected;
}
//设置光标位置
- (void)setCurrOffset:(NSInteger)currOffset {
    UITextPosition *beginning = self.beginningOfDocument;
    UITextPosition *startPosition = [self positionFromPosition:beginning offset:currOffset];
    UITextPosition *endPosition = [self positionFromPosition:beginning offset:currOffset];
    UITextRange *selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}
//光标后一位是否是空格
- (BOOL)latterIsSpace {
    if (self.text.isAble == NO) return NO;
    if (self.startDistance >= self.text.length) return NO;
    NSString *string = [self.text substringWithRange:NSMakeRange(self.startDistance, 1)];
    TSNSLog(string);
    return [string isEqualToString:@" "];
}
//光标前一位是否是空格
- (BOOL)previousIsSpace {
    if (self.text.isAble == NO) return NO;
    NSString *string = [self.text substringWithRange:NSMakeRange(self.startDistance - 1, 1)];
    TSNSLog(string);
    return [string isEqualToString:@" "];
}
//最后一位是否是空格
- (BOOL)lastIsSpace {
    if (self.text.isAble == NO) return NO;
    NSString *string = [self.text substringWithRange:NSMakeRange(self.text.length -1 ?: 0, 1)];
    TSNSLog(string);
    return [string isEqualToString:@" "];
}
- (CGFloat)duration {
    if (self.isFirstResponder) return 0.2;
    return 0;
}
@end

@implementation NoPasteTextField
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController) {
        [UIMenuController sharedMenuController].menuVisible = NO;
        return NO;
    }

    if (action == @selector(paste:)) return NO;     //禁止粘贴
    if (action == @selector(select:)) return NO;    //禁止选择
    if (action == @selector(selectAll:)) return NO; //禁止全选
    return [super canPerformAction:action withSender:sender];
}
@end
