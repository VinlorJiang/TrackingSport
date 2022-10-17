//
//  CustomKeyboard.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/14.
//

#import "CustomKeyboard.h"
#import "UITextField+Common.h"

@interface CustomKeyboard () {
    UITextField *_textField;
    NSArray *_array;
    NSTimer *_timer;
    BOOL _isCleaning;
    NSInteger _maxNumber; //最大位数
}
@end

@implementation CustomKeyboard
+ (instancetype)KeyboardWithTextField:(UITextField *)textField keyboardType:(CustomKeyboardType)type {
    return [self KeyboardWithTextField:textField delegate:nil keyboardType:type];
}
+ (instancetype)KeyboardWithTextField:(UITextField *)textField
                             delegate:(id<CustomKeyboardProtocol>)delegate
                         keyboardType:(CustomKeyboardType)type {

    CGFloat height = (KScreenWidth > 400) ? 226 : 216;
    CustomKeyboard *keyboard = [[CustomKeyboard alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, height) textField:textField keyboardType:type];
    keyboard.delegate = delegate;
    return keyboard;
}
- (instancetype)initWithFrame:(CGRect)frame textField:(UITextField *)textField keyboardType:(CustomKeyboardType)type {

    if (self = [super initWithFrame:frame]) {
        _maxNumber = 10;
        _type = type;
        _textField = textField;
        _array = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @".", @"0", @"12"];
        self.backgroundColor = WhiteColor;
        [self addNumber];
    }
    return self;
}
- (void)addNumber {

    CGFloat width = KScreenWidth / 3;
    CGFloat height = 216 / 4;

    NSString *name = nil;
    if (KScreenWidth == 320) name = @"kb5s";
    if (KScreenWidth == 375) name = @"kb6s";
    if (KScreenWidth > 400) {
        name = @"kb6p";
        height = 229 / 4;
    }

    //左
    for (int i = 0; i < 4; i ++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0., height * i, width - 2, height)];
        btn.tag = i * 3 + 1;
        [self addSubview:btn];

        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@%zd", name,btn.tag]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@%zd_se",name, btn.tag]] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];

        if ((self.type == KeyboardOnlyNumber | self.type == KeyboardOnlyNumberMaxSix | self.type == KeyboardNumberWithSpace)
            && (i == 3)) {
            [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_no", name]] forState:UIControlStateNormal];
            btn.userInteractionEnabled = NO;
        }
    }
    
    //中
    for (int i = 0; i < 4; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(width - 2, height *i, width + 4, height)];
        btn.tag = i * 3 + 2;
        [self addSubview:btn];
        
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@%zd", name,btn.tag]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@%zd_se",name, btn.tag]] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    //右
    for (int i = 0; i < 4; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(width * 2 + 2, height * i, width - 2, height)];
        btn.tag = i * 3 + 3;
        [self addSubview:btn];
        
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@%zd", name,btn.tag]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@%zd_se",name, btn.tag]] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 3) [btn addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown];
    }

    CALayer *layer = [CALayer layerWithFrame:CGRectMake(width - 2, 0, 0.4, (KScreenWidth == 414) ? 226 : 216)];
    layer.backgroundColor = KRGBColor(125, 125, 125).CGColor;
    [self.layer addSublayer:layer];

    CALayer *layerS = [CALayer layerWithFrame:CGRectMake(width - 2 + width + 4, 0, 0.44, (KScreenWidth == 414) ? 226 : 216)];
    layerS.backgroundColor = KRGBColor(125, 125, 125).CGColor;
    [self.layer addSublayer:layerS];
}


/** 键盘点击效果 */
- (void)buttonClick:(UIButton *)btn {

    _isCleaning = NO;
    [_timer invalidate];
    _timer = nil;

    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(automaticClean) object:nil];
    if (btn.tag == 10 && (_type == KeyboardOnlyNumber ||
                          _type == KeyboardOnlyNumberMaxSix ||
                          _type == KeyboardNumberWithSpace ||
                          _type == KeyboardNumberWithSpaceX))  return; //数字键盘不响应
    if (_textField.text.length == 0 && btn.tag == 12) return;
    
    /** 是否响应代理 */
    if (self.delegate && [self.delegate respondsToSelector:@selector(responseInputWithTextField:textFieldString:)]) {
        if (btn.tag != 10 && btn.tag != 12) {
            NSString *textFieldString = [_textField.text stringByAppendingString:_array[btn.tag - 1]];
            BOOL isResponse = [self.delegate responseInputWithTextField:_textField textFieldString:textFieldString];
            if (isResponse == NO) return;
        }
    }

    if (self.type == KeyboardHavePointAmount) {//金额限制
        NSRange range = [_textField.text rangeOfString:@"."];
        BOOL isHavePoint = range.location != NSNotFound ? YES : NO;
        if (isHavePoint) _maxNumber = range.location + 3;//第10位是.默认在加两位
        else _maxNumber = 10;
        
        if (btn.tag == 10 && ((_textField.text.length == 0) | isHavePoint)) return;  //.开头或已经有点
        if (_textField.text.length >= _maxNumber && btn.tag != 12) return;           //大于10位只能删除
        if ((range.location == _textField.text.length - 3) && btn.tag != 12) return; //小数点后只能两位
    }
    if (self.type == KeyboardOnlyNumberMaxSix && _textField.text.length >= 6 && btn.tag != 12) return; /** 6位限制 */

    /** 输入 */
    if (btn.tag == 12) { // 12删除
        NSInteger selectNumber = _textField.selectedNumbers; //目前选中的个数
        NSInteger startOffset = _textField.startDistance;    //光标开始位置
        NSInteger endDistance = _textField.endDistance;      //光标距离末尾
      
        if (self.type == KeyboardHavePointAmount && [_textField.text isEqualToString:@"0."]) {
            _textField.text = @"";
        } else {
            if (startOffset == 0 && selectNumber == 0) return; //光标在最前面(只删除一个)
            if (endDistance == 0) {//光标在最后面
                _textField.text = [_textField.text substringToIndex:_textField.text.length - (selectNumber ?: 1)];
                if (_textField.lastIsSpace) _textField.text = [_textField.text substringToIndex:_textField.text.length - 1];
            } else { //光标在中间
                @try {
                    if (selectNumber == 0) {//删除1个
                        NSInteger currOffset = (startOffset - 1);
                        NSMutableString *mutableString = [NSMutableString stringWithString:_textField.text ?: @""];
                        NSInteger number = 1;
                        NSInteger offset = currOffset;
                        if (_textField.previousIsSpace) {
                            number = 2;
                            offset = (startOffset - 2) ?: 0;
                        }
                        [mutableString deleteCharactersInRange:NSMakeRange(offset, number)]; //删除
                        NSString *newString = mutableString.copy;
                        _textField.text = newString;
                        if (_type == KeyboardNumberWithSpace) _textField.text = [TSHelper FourTextSpaces:newString.removeSpace];
                        if (_type == KeyboardNumberWithSpaceX) {
                            _textField.text = [TSHelper PhoneTextSpaces:_textField.text.removeSpace number:11];
                        }
                        [_textField setCurrOffset:offset]; //光标位置设置

                    } else { //删除多个
                        NSInteger row = (_textField.previousIsSpace ? 1 : 0);
                        NSMutableString *mutableString = [NSMutableString stringWithString:_textField.text ?: @""];
                        [mutableString deleteCharactersInRange:NSMakeRange(startOffset, selectNumber)];
                        NSString *newString = mutableString.copy;
                        _textField.text = newString;
                        if (_type == KeyboardNumberWithSpace) _textField.text = [TSHelper FourTextSpaces:newString.removeSpace];
                        if (_type == KeyboardNumberWithSpaceX) {
                            _textField.text = [TSHelper PhoneTextSpaces:_textField.text.removeSpace number:11];
                        }
                        [_textField setCurrOffset:startOffset - row];
                    }
                }@catch (NSException *exception) {} @finally {}
            }
        }

    } else { //插入

        NSInteger selectNumber = _textField.selectedNumbers;    //目前选中的个数
        NSInteger startOffset = _textField.startDistance;       //光标开始位置
        BOOL latterIsSpace = _textField.latterIsSpace;          //后一位是否是空格
        NSString *currString = _array[btn.tag - 1];             //要加的字
        NSRange range = NSMakeRange(startOffset, selectNumber); //更换区间
        NSString *newStrings = nil;

        // 1-11添加
        if (_textField.endDistance == 0 && selectNumber == 0) { //光标在最后面
            _textField.text = [_textField.text stringByAppendingString:_array[btn.tag - 1]];
            if (_type == KeyboardNumberWithSpace) _textField.text = [TSHelper FourTextSpaces:_textField.text.removeSpace];
            if (_type == KeyboardNumberWithSpaceX) _textField.text = [TSHelper PhoneTextSpaces:_textField.text.removeSpace number:11];
        } else {
            @try {
                if (selectNumber == 0) { //无选中的情况下增加
                    NSMutableString *mutableString = [NSMutableString stringWithString:_textField.text ?: @""];
                    [mutableString insertString:currString atIndex:startOffset];
                    newStrings = mutableString.copy;
                    _textField.text = newStrings;
                    if (_type == KeyboardNumberWithSpace) _textField.text = [TSHelper FourTextSpaces:newStrings.removeSpace];
                    if (_type == KeyboardNumberWithSpaceX) {
                        _textField.text = [TSHelper PhoneTextSpaces:_textField.text.removeSpace number:11];
                    }
                    [_textField setCurrOffset:startOffset + 1 + latterIsSpace];

                } else { //有选中的情况下替换
                    newStrings = [_textField.text stringByReplacingCharactersInRange:range withString:currString];
                    _textField.text = newStrings;
                    if (_type == KeyboardNumberWithSpace) _textField.text = [TSHelper FourTextSpaces:newStrings.removeSpace];
                    if (_type == KeyboardNumberWithSpaceX) {
                        _textField.text = [TSHelper PhoneTextSpaces:_textField.text.removeSpace number:11];
                    }
                    [_textField setCurrOffset:startOffset + 1];
                }
            }@catch (NSException *exception) { TSNSLog(@"崩溃")} @finally {}
        }
        
        if ([_textField.text isEqualToString:@"0"] && self.type == KeyboardHavePointAmount) {
            _textField.text = @"0.";
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(customTextFieldDidChange:)]) {
        [self.delegate customTextFieldDidChange:_textField];
    }
}
/** 按下 */
- (void)touchDown {
    if (KeyboardOnlyNumberMaxSix == _type) return;//6位数字不支持长按
    [self performSelector:@selector(automaticClean) withObject:nil afterDelay:0.35];
}
/** 自动清除 */
- (void)automaticClean {
    _isCleaning = YES;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(cleaning) userInfo:nil repeats:YES];
}
/** 正在清除 */
- (void)cleaning {
    if (!_isCleaning) return;

    if (!_textField.text.isAble){
        [_timer invalidate];
        _timer = nil;
        if (self.delegate && [self.delegate respondsToSelector:@selector(customTextFieldDidChange:)]) {
            [self.delegate customTextFieldDidChange:_textField];
        }
        return;
    }
    _textField.text = [_textField.text substringToIndex:_textField.text.length - 1];
}

@end

