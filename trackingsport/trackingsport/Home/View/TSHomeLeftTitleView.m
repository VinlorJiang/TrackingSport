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
    NSMutableArray <UIButton *> *_labelArray;
    
    NSArray  *_normalColorArray;
    NSArray *_selectColorArray;
    NSArray *_imageArray;
}


@end

@implementation TSHomeLeftTitleView

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray imageArray:(NSArray *)imageArray {
    self = [super initWithFrame:frame];
    
    if (self) {
        _index = 0;
        _labelArray = [NSMutableArray array];
        self.titleArray = titleArray;
        _imageArray = imageArray;
        [self createScrollView];
        
    }
    return  self;
}


- (void)createScrollView {
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:_scrollView];
    _scrollView.backgroundColor = KRGBColor(65, 178, 254);
    NSLog(@"frame:%@--bound:%@",NSStringFromCGRect(self.frame),NSStringFromCGRect(self.bounds));
    _scrollView.scrollEnabled = NO;
    _scrollView.delegate = self;
    [_scrollView setContentSize:CGSizeMake(70, self.frame.size.height)];
    [self createSubView];
}

- (void)createSubView {
    CGFloat h = 50;
    CGFloat y ;
    for (int i = 0; i < self.titleArray.count ; i++) {
        
        if (i == 0) {
            y = h * 3;
        } else if ( i > 0 && i < 3) {
            y = y + h * 2;
        } else {
            y = KScreenHeight - h * 1.5;
        }
        NSLog(@"y:%lf",y);
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(5, y, KLeftContentViewW-10, h)];
        [_scrollView addSubview:btn];
        [_labelArray addObject:btn];
        [btn setBackgroundColor:ClearColor];
        [btn setCornerRadius:10];
        [btn setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:WhiteColor];
        [btn setImage:[UIImage imageNamed:_imageArray[i]] forState:UIControlStateNormal];
        [btn setTag:i];
        [btn horizontalCenter_Alignmen_Image:8 title:16];
//        [btn setImageEdgeInsets:UIEdgeInsetsMake(3, 0, 3, 0)];
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIButton *defaultBtn = _labelArray[_index];
    [defaultBtn setBackgroundColor:WhiteColor];
    [defaultBtn setTitleColor:KRGBColor(54, 164, 234)];
}

- (void)btnClick:(UIButton *)button {
    
    // 当前点击的label
    if (button.tag == _index) {
        return;
    }
    
    UIButton *oldBTn = _labelArray[_index];
    [oldBTn setTitleColor:WhiteColor];
    [oldBTn setBackgroundColor:ClearColor];
    [button setTitleColor:KRGBColor(54, 164, 234)];
    [button setBackgroundColor:WhiteColor];
    
    
    _index = (int)button.tag;
    
    if ([self.delegate respondsToSelector:@selector(pageTitleView:selectedIndex:)]) {
        TSNSLog(@"");
        [self.delegate pageTitleView:self selectedIndex:_index];
    }
}



- (void)titleWithProgress:(CGFloat)progress sourceIndex:(int)sourceIndex targetIndex:(int)targetIndex {
    
    UIButton *sourceBtn = _labelArray[sourceIndex];
    UIButton *targetBtn = _labelArray[targetIndex];
    [sourceBtn setTitleColor:WhiteColor];
    [sourceBtn setBackgroundColor:ClearColor];
    [targetBtn setTitleColor:KRGBColor(54, 164, 234)];
    [targetBtn setBackgroundColor:WhiteColor];
    
    _index = targetIndex;
}
@end
