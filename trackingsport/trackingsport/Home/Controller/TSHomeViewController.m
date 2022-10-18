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
        
        _titleView = [[TSHomeLeftTitleView alloc] initWithFrame:CGRectMake(0, 0, KLeftContentViewW, KScreenHeight) titleArray:titleArray];
        _titleView.delegate = self;
    }
    
    return _titleView;
}

- (TSHomeLeftContentView *)contentView {
    if (!_contentView) {
//        NSMutableArray *mutabArray = [NSMutableArray array];
//        for (int i = 0; i < 4; i++) {
//            int R = arc4random() % 255;
//            UIViewController *vc = [[UIViewController alloc] init];
//            vc.view.backgroundColor = [UIColor colorWithRed:R /255.0 green:R/255.0 blue:R/255.0 alpha:1.0];
//
////            vc.view.backgroundColor = [UIColor redColor];
//            [mutabArray addObject:vc];
//        }
        
        TSTrainingViewController *trainingVc = [TSTrainingViewController new];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:trainingVc];
        TSDataViewController *dataVc = [TSDataViewController new];
        TSTaskViewController *taskVc = [TSTaskViewController new];
        TSSettingViewController *settingVc = [TSSettingViewController new];
//        [mutabArray addObject:<#(nonnull id)#>];
        NSArray *contentVcArray = @[nav, dataVc,taskVc,settingVc];
        _contentView = [[TSHomeLeftContentView alloc] initWithFrame:CGRectMake(KLeftContentViewW, 0, KScreenWidth, KScreenHeight) childViewControllerArrays:contentVcArray parentViewController:self];
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
