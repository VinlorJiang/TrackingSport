//
//  TSModeSelectView.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/11/17.
//

#import "TSModeSelectView.h"

@interface TSModeSelectView ()


@end

@implementation TSModeSelectView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.backgroundColor = KRGBColor(49, 186, 244);
        [self setupUI];
    }
    return  self;
}
- (void)setupUI {
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 160, 40)];
    [self addSubview:backBtn];
//    [backBtn setTitle:self.title forState:UIControlStateNormal];
    [backBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [backBtn setBackgroundColor:ClearColor];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.backBtn = backBtn;
}

- (void)back {
    if (self.backBlock) {
        self.backBlock();
    }
}
@end
