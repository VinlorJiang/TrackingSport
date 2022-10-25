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
    
    UILabel *dataLB = [[UILabel alloc] initWithFrame:CGRectMake(kTaskViewLeftSpace, kTaskViewLeftSpace, self.width-kTaskViewLeftSpace, 30)];
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
    
    CGFloat itemW = (self.width - iconIV.right - kTaskViewLeftSpace * 5) / 4;
    _accumulatedView = [[TSTaskHeaderItemView alloc] initWithFrame:CGRectMake(iconIV.right+kTaskViewLeftSpace, iconIV.top, itemW, itemH)];
    _accumulatedView.filedLB.text = @"累计作业数";
    [self addSubview:_accumulatedView];
    
    _completedView = [[TSTaskHeaderItemView alloc] initWithFrame:CGRectMake(_accumulatedView.right + kTaskViewLeftSpace, iconIV.top, itemW, itemH)];
    _completedView.filedLB.text = @"累计完成作业";
    [self addSubview:_completedView];
    
    _underwayView = [[TSTaskHeaderItemView alloc] initWithFrame:CGRectMake(_completedView.right + kTaskViewLeftSpace, iconIV.top, itemW, itemH)];
    _underwayView.filedLB.text = @"进行中作业数";
    [self addSubview:_underwayView];
    
    _finshedRateView = [[TSTaskHeaderItemView alloc] initWithFrame:CGRectMake(_underwayView.right + kTaskViewLeftSpace, iconIV.top, itemW, itemH)];
    _finshedRateView.filedLB.text = @"进行中完成率";
    [self addSubview:_finshedRateView];
    
    UILabel *homework = [UILabel new];
    homework.left = kTaskViewLeftSpace;
    homework.top = iconIV.bottom+kTaskViewLeftSpace;
    homework.height = 30;
    homework.width = 40;
    [self addSubview:homework];
    homework.text = @"作业";
    homework.textColor = BlackColor;
    
    UIButton *assignmentBtn = [[UIButton alloc] initWithFrame:CGRectMake(homework.right, homework.top, 100, 30)];
    assignmentBtn.backgroundColor = KRGBColor(51, 200, 244);
    [assignmentBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [assignmentBtn setTitle:@"布置作业" forState:UIControlStateNormal];
    assignmentBtn.titleLabel.font = [UIFont systemFontOfSize:Kfont18];
    [self addSubview:assignmentBtn];
    [assignmentBtn addTarget:self action:@selector(assignmentClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(kTaskViewLeftSpace, homework.bottom+kTaskViewLeftSpace, self.width - kTaskViewLeftSpace*2, 40)];
    [self addSubview:titleView];
    NSArray *titleArray = @[@"项目",@"班级",@"内容",@"完成率",@"最近",@"状态"];
    for (NSInteger i = 0; i < titleArray.count; i++) {
        CGFloat w = titleView.width / titleArray.count;
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i * w, 0, w, titleView.height)];
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:KRGBColor(51, 200, 244) forState:UIControlStateNormal];
        [btn setBackgroundColor:ClearColor];
        [titleView addSubview:btn];
        
    }
}

- (void)assignmentClick {
    NSLog(@"布置作业");
}

- (void)setModel:(TSTaskHeaderModel *)model {
    _model = model;
    _accumulatedView.valueLB.text = model.accumulatedHomework;
    _completedView.valueLB.text = model.accumulatedCompletedHomework;
    _finshedRateView.valueLB.text = model.underwayFinshedRateHomework;
    _underwayView.valueLB.text = model.underwayHomework;
}
@end
