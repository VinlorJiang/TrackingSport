//
//  TSHomeLeftTitleView.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/12.
//

#import "TSHomeLeftTitleView.h"

@interface TSHomeLeftTitleView() <UIScrollViewDelegate> {
    
    UIScrollView *_scrollView;
    int _index;// 当前label点击的位置
    NSMutableArray <UILabel *> *_labelArray;
    
    NSArray  *_normalColorArray;
    NSArray *_selectColorArray;
}


@end

@implementation TSHomeLeftTitleView

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray {
    self = [super initWithFrame:frame];
    
    if (self) {
        _index = 0;
        _labelArray = [NSMutableArray array];
        self.titleArray = titleArray;
        [self createScrollView];
        self.backgroundColor = [UIColor redColor];
    }
    return  self;
}

- (void)createScrollView {
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:_scrollView];
    _scrollView.backgroundColor = [UIColor whiteColor];
    NSLog(@"frame:%@--bound:%@",NSStringFromCGRect(self.frame),NSStringFromCGRect(self.bounds));
    _scrollView.scrollEnabled = NO;
    _scrollView.delegate = self;
    [_scrollView setContentSize:CGSizeMake(70, self.frame.size.height)];
    [self createSubView];
}

- (void)createSubView {
    CGFloat h = self.frame.size.height / self.titleArray.count;
    CGFloat w = 70;
    for (int i = 0; i < self.titleArray.count ; i++) {
        
        CGFloat y = h * i;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, y, w, h)];
        [_scrollView addSubview:label];
        [_labelArray addObject:label];
        label.text = self.titleArray[i];
        label.tag = i;
        
        label.textColor = [UIColor redColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [label addGestureRecognizer:gesture];
    }
}

- (void)tap:(UITapGestureRecognizer *)gesture {
    
    // 当前点击的label
    UILabel *currentLabel = (UILabel *)gesture.view;
    
    if (currentLabel.tag == _index) {
        return;
    }
    
    UILabel *oldLabel = _labelArray[_index];
    
    currentLabel.textColor = [UIColor colorWithRed:255/255.0 green:128/255.0 blue:0/255.0 alpha:1.0];
    oldLabel.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0];
    
    _index = (int)currentLabel.tag;
    
    if ([self.delegate respondsToSelector:@selector(pageTitleView:selectedIndex:)]) {
        TSNSLog(@"");
        [self.delegate pageTitleView:self selectedIndex:_index];
    }
}



- (void)titleWithProgress:(CGFloat)progress sourceIndex:(int)sourceIndex targetIndex:(int)targetIndex {
    
}
@end
