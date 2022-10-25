//
//  TSTaskViewController.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/12.
//

#import "TSTaskViewController.h"
#import "TSTaskHeaderView.h"
#import "TSTaskHeaderModel.h"
#import "TSTaskCompletedView.h"
#import "TSTaskViewCell.h"

@interface TSTaskViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) TSTaskCompletedView *completedView;
@property (strong, nonatomic) UIImageView *iconIV;
@property (strong, nonatomic) TSTaskHeaderView *headerView;
@property (strong, nonatomic) UITableView *taskTableView;
@end

@implementation TSTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Task";
    
    [self setupUI];
    
    
    [self loaddata];
}

- (void)setupUI {
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.completedView];
    [self.view addSubview:self.taskTableView];
    NSLog(@"");
}


- (void)loaddata {
    TSTaskHeaderModel *model = [TSTaskHeaderModel new];
    model.accumulatedHomework = @"150";
    model.accumulatedCompletedHomework = @"6";
    model.underwayHomework = @"0";
    model.underwayFinshedRateHomework = @"0%";
    _headerView.model = model;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    TSTaskViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[TSTaskViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (TSTaskCompletedView *)completedView {
    if (!_completedView) {
        _completedView = [[TSTaskCompletedView alloc] initWithFrame:CGRectMake(self.headerView.right, 0, kTaskViewLatestCompltedViewW, KScreenHeight)];
    }
    return _completedView;
}

- (TSTaskHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[TSTaskHeaderView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth-KLeftContentViewW-kTaskViewLatestCompltedViewW, 320)];
        
    }
    return _headerView;
}

- (UITableView *)taskTableView {
    if (!_taskTableView) {
        _taskTableView = [[UITableView alloc] initWithFrame:CGRectMake(kTaskViewLeftSpace, _headerView.bottom, _headerView.width - kTaskViewLeftSpace*2, KScreenHeight - _headerView.bottom)];
        _taskTableView.delegate = self;
        _taskTableView.dataSource = self;
        _taskTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _taskTableView;;
}
@end
