//
//  TSDataLeftTitleView.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/31.
//

#import "TSDataLeftTitleView.h"

@interface TSDataLeftTitleView() <UIScrollViewDelegate> {
    
    UIScrollView *_scrollView;
    int _index;// 当前label点击的位置
    NSMutableArray <UILabel *> *_labelArray;
    
    NSArray  *_normalColorArray;
    NSArray *_selectColorArray;
}


@end

@implementation TSDataLeftTitleView

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray {
    self = [super initWithFrame:frame];
    
    if (self) {
        _index = 0;
        _labelArray = [NSMutableArray array];
        self.titleArray = titleArray;
        [self createScrollView];    }
    return  self;
}

- (void)createScrollView {
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:_scrollView];
    NSLog(@"frame:%@--bound:%@",NSStringFromCGRect(self.frame),NSStringFromCGRect(self.bounds));
    _scrollView.scrollEnabled = NO;
    _scrollView.delegate = self;
    [_scrollView setContentSize:CGSizeMake(70, self.frame.size.height)];
    [self createSubView];
}

- (void)createSubView {
    CGFloat w = 120;
    CGFloat h = 40;
    for (int i = 0; i < self.titleArray.count ; i++) {
        
        CGFloat x = w * i;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, w, h)];
        [_scrollView addSubview:label];
        [_labelArray addObject:label];
        label.text = self.titleArray[i];
        label.tag = i;
        label.backgroundColor = ClearColor;
        label.textColor = [UIColor lightGrayColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.userInteractionEnabled = YES;
        label.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
        label.cornerRadius = 20;
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [label addGestureRecognizer:gesture];
    }
    
    UILabel *initLb = _labelArray[_index];
    initLb.backgroundColor = KRGBColor(247, 154, 105);
    initLb.textColor = WhiteColor;
}

- (void)tap:(UITapGestureRecognizer *)gesture {
    
    // 当前点击的label
    UILabel *currentLabel = (UILabel *)gesture.view;
    
    if (currentLabel.tag == _index) {
        return;
    }
    
    UILabel *oldLabel = _labelArray[_index];
    
    currentLabel.textColor = WhiteColor;
    currentLabel.backgroundColor = KRGBColor(247, 154, 105);
    oldLabel.textColor = LightGrayColor;
    oldLabel.backgroundColor = ClearColor;
    
    _index = (int)currentLabel.tag;
    
    if ([self.delegate respondsToSelector:@selector(pageTitleView:selectedIndex:)]) {
        TSNSLog(@"");
        [self.delegate pageTitleView:self selectedIndex:_index];
    }
}

- (void)titleWithProgress:(CGFloat)progress sourceIndex:(int)sourceIndex targetIndex:(int)targetIndex {
    UILabel *sourceLabel = _labelArray[sourceIndex];
    UILabel *targetLabel = _labelArray[targetIndex];

    sourceLabel.textColor = LightGrayColor;
    sourceLabel.backgroundColor = ClearColor;
    targetLabel.textColor = WhiteColor;
    targetLabel.backgroundColor = KRGBColor(247, 154, 105);

    _index = targetIndex;
}
@end

