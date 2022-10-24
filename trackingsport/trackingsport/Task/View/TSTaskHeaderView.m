//
//  TSTaskHeaderView.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/24.
//

#import "TSTaskHeaderView.h"
#import "TSTaskHeaderModel.h"
#import "TSTaskHeaderItemView.h"

@interface TSTaskHeaderView () {
    UILabel *dataLB;/// 数据
    UIImageView *_iconIV;
    TSTaskHeaderItemView *_accumulatedView;/// 累计
    TSTaskHeaderItemView *_completedView;/// 累计完成
    TSTaskHeaderItemView *_underwayView;/// 进行中
    TSTaskHeaderItemView *_finshedRateView;/// 进行中完成率
    
}

@end

@implementation TSTaskHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    
    UILabel *dataLB = [[UILabel alloc] initWithFrame:CGRectMake(kTaskViewLeftSpace, kTaskViewLeftSpace, self.height, 30)];
    dataLB.backgroundColor = ClearColor;
    dataLB.text = @"数据";
    dataLB.textColor = BlackColor;
    dataLB.numberOfLines = 0;
    dataLB.font = [UIFont boldSystemFontOfSize:Kfont18];
    [self addSubview:dataLB];
    
    CGFloat itemH = 100;
    
    UIImageView *iconIV = [[UIImageView alloc] initWithFrame:CGRectMake(kTaskViewLeftSpace, dataLB.bottom+kTaskViewLeftSpace, 80, itemH)];
    iconIV.image = [UIImage imageNamed:@"默认头像"];
    [self addSubview:iconIV];
    
    CGFloat itemleftSpace = kTaskViewLeftSpace * 0.7;
    CGFloat itemW = (self.width - iconIV.width - iconIV.left - itemleftSpace * 4) / 4;
    _accumulatedView = [[TSTaskHeaderItemView alloc] initWithFrame:CGRectMake(iconIV.right+10, iconIV.top, itemW, itemH)];
    _accumulatedView.filedLB.text = @"累计作业数";
    [self addSubview:_accumulatedView];
    
    _completedView = [[TSTaskHeaderItemView alloc] initWithFrame:CGRectMake(_accumulatedView.right + itemleftSpace, iconIV.top, itemW, itemH)];
    _completedView.filedLB.text = @"累计完成作业";
    [self addSubview:_completedView];
    
    _underwayView = [[TSTaskHeaderItemView alloc] initWithFrame:CGRectMake(_completedView.right + itemleftSpace, iconIV.top, itemW, itemH)];
    _underwayView.filedLB.text = @"进行中作业数";
    [self addSubview:_underwayView];
    
    _finshedRateView = [[TSTaskHeaderItemView alloc] initWithFrame:CGRectMake(_underwayView.right + itemleftSpace, iconIV.top, itemW, itemH)];
    _finshedRateView.filedLB.text = @"进行中完成率";
    [self addSubview:_finshedRateView];
    
}

- (void)setModel:(TSTaskHeaderModel *)model {
    _model = model;
    _accumulatedView.valueLB.text = model.accumulatedHomework;
    _completedView.valueLB.text = model.accumulatedCompletedHomework;
    _finshedRateView.valueLB.text = model.underwayFinshedRateHomework;
    _underwayView.valueLB.text = model.underwayHomework;
}
@end
