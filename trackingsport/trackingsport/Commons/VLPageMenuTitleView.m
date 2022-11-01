//
//  VLPageMenuTitleView.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/31.
//

#import "VLPageMenuTitleView.h"

#define kBottomLineH 1


@interface VLPageMenuTitleView ()<UIScrollViewDelegate> {
    
    UIScrollView *_scrollView;
    UIView *_bottomLine;
    UIView *_scrollLine;
    int _index;// 当前label点击的位置
    NSMutableArray <UIButton *> *_btnArray;
    
//    UIColor *_normalColorArray;
//    UIColor *_selectColorArray;
    NSArray  *_normalColorArray;
    NSArray *_selectColorArray;
}



@end



@implementation VLPageMenuTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        _index = 0;
        _btnArray = [NSMutableArray array];
        self.isHasBottomLine = YES;
        self.isHorizontalLayout = YES;
//        self.titleArray = titleArray;
        
        _normalColorArray = @[@85, @85, @85];
        _selectColorArray = @[@255, @128, @0];
        
        [self createScrollView];
    }
    
    return self;
}

- (void)createScrollView {
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:_scrollView];
    _scrollView.backgroundColor = [UIColor whiteColor];
    NSLog(@"frame:%@--bound:%@",NSStringFromCGRect(self.frame),NSStringFromCGRect(self.bounds));
    
//    _scrollView.showsHorizontalScrollIndicator = YES;
//    _scrollView.showsVerticalScrollIndicator = NO;
//    _scrollView.alwaysBounceVertical = NO;
//    _scrollView.bounces = NO;
//    _scrollView.scrollsToTop = NO;
//    _scrollView.alwaysBounceHorizontal = YES;
    _scrollView.delegate = self;
    [_scrollView setContentSize:CGSizeMake(_scrollView.frame.size.width, -70)];
    [self createSubView];
    
    
}

- (void)createSubView {
    
    if (self.isHorizontalLayout) {
        CGFloat w = self.frame.size.width / self.titleArray.count;
        CGFloat h = self.frame.size.height - kBottomLineH;
        for (int i = 0; i < self.titleArray.count ; i++) {
            
            CGFloat x = w * i;
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(x, -64, w, h)];
            [_scrollView addSubview:btn];
            [_btnArray addObject:btn];
            [btn setTitle:self.titleArray[i] forState:UIControlStateNormal];
            [btn setTag:i];
            [btn setTitleColor:[UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
}
- (void)setupBottomLineAndScrollLine {
    
    _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - kBottomLineH, self.frame.size.width, kBottomLineH)];
    [self addSubview:_bottomLine];
    _bottomLine.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *firstBtn = _btnArray[0];
    [firstBtn setTitleColor:[UIColor colorWithRed:255/255.0 green:128/255.0 blue:0/255.0 alpha:1.0]];
    
    _scrollLine = [[UIView alloc] initWithFrame:CGRectMake(firstBtn.frame.origin.x, -22, firstBtn.frame.size.width, 2)];
    _scrollLine.backgroundColor = [UIColor orangeColor];
    [_scrollView addSubview:_scrollLine];
    
}
- (void)btnClick:(UITapGestureRecognizer *)gesture {
    
    // 当前点击的label
    UIButton *currentBtn = (UIButton *)gesture.view;
    
    if (currentBtn.tag == _index) {
        return;
    }
    
    UIButton *oldBtn = _btnArray[_index];
    [currentBtn setTitleColor:[UIColor colorWithRed:255/255.0 green:128/255.0 blue:0/255.0 alpha:1.0]];
    [oldBtn setTitleColor:[UIColor colorWithRed:255/255.0 green:128/255.0 blue:0/255.0 alpha:1.0]];
    
    _index = (int)currentBtn.tag;
    
    CGFloat labelX = _index * _scrollLine.frame.size.width;
    
    [UIView animateWithDuration:0.15 animations:^{
        CGRect temp = _scrollLine.frame;
        temp.origin.x = labelX;
        _scrollLine.frame = temp;
    }];
    
    if ([self.delegate respondsToSelector:@selector(pageTitleView:selectedIndex:)]) {
        [self.delegate pageTitleView:self selectedIndex:_index];
    }
}
#pragma mark - public methods
- (void)titleWithProgress:(CGFloat)progress sourceIndex:(int)sourceIndex targetIndex:(int)targetIndex {
    
    UIButton *sourceBtn = _btnArray[sourceIndex];
    UIButton *targetBtn = _btnArray[targetIndex];
    
    CGFloat moveTotalX = sourceBtn.frame.origin.x - sourceBtn.frame.origin.x;
    CGFloat moveX = moveTotalX * progress;
    CGRect temp = _scrollLine.frame;
    temp.origin.x = sourceBtn.frame.origin.x + moveX;
    _scrollLine.frame = temp;
    
//    _normalColorArray = @[@85, @85, @85];
//    _selectColorArray = @[@255, @128, @0];
    
    CGFloat colorDeltaR = [_selectColorArray[0] integerValue] - [_normalColorArray[0] integerValue];
    CGFloat colorDeltaG = [_selectColorArray[1] integerValue] - [_normalColorArray[1] integerValue];
    CGFloat colorDeltaB = [_selectColorArray[2] integerValue] - [_normalColorArray[2] integerValue];
    
    [sourceBtn setTitleColor:[UIColor colorWithRed:([_selectColorArray[0] floatValue] - colorDeltaR * progress)/255.0 green:([_selectColorArray[1] floatValue] - colorDeltaG * progress)/255.0 blue:([_selectColorArray[2] floatValue] - colorDeltaB * progress)/255.0 alpha:1.0]];
    [targetBtn setTitleColor:[UIColor colorWithRed:([_normalColorArray[0] floatValue] + colorDeltaR * progress)/255.0 green:([_normalColorArray[1] floatValue] + colorDeltaG * progress)/255.0 blue:([_normalColorArray[2] floatValue] + colorDeltaB * progress)/255.0 alpha:1.0]];
    
//    sourceLabel.textColor = [UIColor redColor];
//    targetLabel.textColor = _selectColorArray;
//
    _index = targetIndex;
}

- (void)setIsHasBottomLine:(BOOL)isHasBottomLine {
    _isHasBottomLine = isHasBottomLine;
    if (_isHasBottomLine) {
        [self setupBottomLineAndScrollLine];
    }
}

- (void)setIsHorizontalLayout:(BOOL)isHorizontalLayout {
    
}
@end
