//
//  TSTrainView.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/13.
//

#import "TSTrainView.h"

@interface TSTrainView () {
    NSArray *_textArray;
}

@end

@implementation TSTrainView

- (instancetype)initWithFrame:(CGRect)frame textArray:(NSArray *)textArray{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = LightGrayColor;
        _textArray = [NSArray arrayWithArray:textArray];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
    titleLB.backgroundColor = ClearColor;
    titleLB.text = @"训练";
    titleLB.textColor = BlackColor;
    titleLB.font = KFont(20);
    [self addSubview:titleLB];
    
    CGFloat w = self.frame.size.width / _textArray.count;
    for (int i = 0; i < _textArray.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(w * i, titleLB.bottom+15, w, 40)];
        
        btn.backgroundColor = YellowColor;
        btn.titleLabel.font = KFont(20);
        btn.titleColor = BlackColor;
        [btn setTitle:_textArray[i] forState:UIControlStateNormal];
        [btn setTag:i + 100];
        [self addSubview:btn];
        
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)click:(UIButton *)btn {
    if (self.trainingTypeBlock) {
        self.trainingTypeBlock(btn);
    }
}
@end
