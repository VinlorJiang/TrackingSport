//
//  TSHomeViewController.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/12.
//

#import "TSHomeViewController.h"
#import "TSHomeLeftTitleView.h"
#import "TSHomeLeftContentView.h"
#import "TSTrainingViewController.h"
#import "TSDataViewController.h"
#import "TSTaskViewController.h"
#import "TSSettingViewController.h"

@interface TSHomeViewController ()<TSHomeLeftTitleViewDelegate,TSHomeLeftContentViewDelegate>

@property (nonatomic, strong) TSHomeLeftTitleView *titleView;
@property (nonatomic, strong) TSHomeLeftContentView *contentView;

@end

@implementation TSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = GrayColor;
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.contentView];
}


#pragma mark - Navigation



- (TSHomeLeftTitleView *)titleView {
    if (!_titleView) {
        NSArray *titleArray = @[@"训练", @"数据",@"作业",@"设置"];
        NSArray *imageArray = @[@"menu", @"menu",@"menu",@"menu"];
        _titleView = [[TSHomeLeftTitleView alloc] initWithFrame:CGRectMake(0, 0, KLeftContentViewW, KScreenHeight) titleArray:titleArray imageArray:imageArray];
        _titleView.delegate = self;
    }
    
    return _titleView;
}

- (TSHomeLeftContentView *)contentView {
    if (!_contentView) {
        TSTrainingViewController *trainingVc = [TSTrainingViewController new];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:trainingVc];
        TSDataViewController *dataVc = [TSDataViewController new];
        TSTaskViewController *taskVc = [TSTaskViewController new];
        TSSettingViewController *settingVc = [TSSettingViewController new];
//        [mutabArray addObject:<#(nonnull id)#>];
        NSArray *contentVcArray = @[trainingVc, dataVc,taskVc,settingVc];
        _contentView = [[TSHomeLeftContentView alloc] initWithFrame:CGRectMake(KLeftContentViewW, 0, KScreenWidth-KLeftContentViewW, KScreenHeight) childViewControllerArrays:contentVcArray parentViewController:self];
        _contentView.delegate = self;
    }
    return _contentView;
}

#pragma mark - delegate
- (void)pageTitleView:(TSHomeLeftTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    TSNSLog(@"");

    [self.contentView currrentIndex:selectedIndex];
}
- (void)pageContentView:(TSHomeLeftContentView *)pageContentView progress:(CGFloat)progress sourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex {
    TSNSLog(@"");
    [self.titleView titleWithProgress:progress sourceIndex:sourceIndex targetIndex:targetIndex];
}


@end
