//
//  TSDataViewController.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/12.
//

#import "TSDataViewController.h"
#import "TSDataLeftTitleView.h"
#import "TSDataLeftContentView.h"
#import "TSDataCoordinateViewController.h"
#import "TSDataAgileViewController.h"
#import "TSDataPowerViewController.h"
#import "TSDataBalanceViewController.h"
#import "TSDataSpeedViewController.h"
#import "TSDataHeartRateViewController.h"

@interface TSDataViewController ()<TSDataLeftTitleViewDelegate,TSDataLeftContentViewDelegate>
@property (nonatomic, strong) TSDataLeftTitleView *titleView;
@property (nonatomic, strong) TSDataLeftContentView *contentView;
@end

@implementation TSDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Data";
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.contentView];
}

- (TSDataLeftTitleView *)titleView {
    if (!_titleView) {
        NSArray *titleArray = @[@"协调", @"敏捷",@"力量",@"平衡",@"速度",@"心率"];
        
        _titleView = [[TSDataLeftTitleView alloc] initWithFrame:CGRectMake(kTaskViewLeftSpace, kTaskViewLeftSpace, KScreenWidth-KLeftContentViewW-kTaskViewLeftSpace*2, 40) titleArray:titleArray];
        _titleView.delegate = self;
    }
    
    return _titleView;
}

- (TSDataLeftContentView *)contentView {
    if (!_contentView) {
        TSDataCoordinateViewController *coordinateVc= [TSDataCoordinateViewController new];
        TSDataAgileViewController *agileVc= [TSDataAgileViewController new];
        TSDataPowerViewController *powerVc= [TSDataPowerViewController new];
        TSDataBalanceViewController *balanceVc= [TSDataBalanceViewController new];
        TSDataSpeedViewController *speedVc= [TSDataSpeedViewController new];
        TSDataHeartRateViewController *heartRateVc= [TSDataHeartRateViewController new];
        
        NSArray *contentVcArray = @[coordinateVc,agileVc,powerVc,balanceVc,speedVc,heartRateVc];
        _contentView = [[TSDataLeftContentView alloc] initWithFrame:CGRectMake(kTaskViewLeftSpace, kTaskViewLeftSpace+70, KScreenWidth-KLeftContentViewW-kTaskViewLeftSpace*2, KScreenHeight) childViewControllerArrays:contentVcArray parentViewController:self];
        _contentView.delegate = self;
    }
    return _contentView;
}

#pragma mark - delegate
- (void)pageTitleView:(TSDataLeftTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    TSNSLog(@"");

    [self.contentView currrentIndex:selectedIndex];
}
- (void)pageContentView:(TSDataLeftContentView *)pageContentView progress:(CGFloat)progress sourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex {
    TSNSLog(@"");
    [self.titleView titleWithProgress:progress sourceIndex:sourceIndex targetIndex:targetIndex];
}

@end
