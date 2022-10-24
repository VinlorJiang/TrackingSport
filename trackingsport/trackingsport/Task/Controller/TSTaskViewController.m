//
//  TSTaskViewController.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/12.
//

#import "TSTaskViewController.h"
#import "TSTaskHeaderView.h"
#import "TSTaskHeaderModel.h"

@interface TSTaskViewController ()
@property (strong, nonatomic) UIImageView *iconIV;
@property (strong, nonatomic) TSTaskHeaderView *headerView;
@end

@implementation TSTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Task";
    [self.view addSubview:self.headerView];
    
    [self loaddata];
}

- (void)loaddata {
    TSTaskHeaderModel *model = [TSTaskHeaderModel new];
    model.accumulatedHomework = @"150";
    model.accumulatedCompletedHomework = @"6";
    model.underwayHomework = @"0";
    model.underwayFinshedRateHomework = @"0%";
    _headerView.model = model;
}

- (TSTaskHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[TSTaskHeaderView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth-KLeftContentViewW - kTaskViewLeftSpace - kTaskViewLatestCompltedViewW, 120)];
        
    }
    return _headerView;
}

@end
