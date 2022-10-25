//
//  TSTaskCompletedView.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/25.
//

#import "TSTaskCompletedView.h"
#import "TSTaskCompletedCell.h"

static NSString *const TaskCompletedCellIdentfier = @"TaskCompletedCellIdentfier";

@interface TSTaskCompletedView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TSTaskCompletedView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(10, 0, self.width, 90)];
    UILabel *completedLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, self.width, 30)];
    completedLB.text = @"最近完成";
    [header addSubview:completedLB];
    
    [self addSubview:header];
    [self addSubview:self.completedTableView];
    [self.completedTableView registerNib:[UINib nibWithNibName:@"TSTaskCompletedCell" bundle:nil] forCellReuseIdentifier:TaskCompletedCellIdentfier];
    self.completedTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.completedTableView.cornerRadius = 20;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 90)];
//    UILabel *completedLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, self.width, 30)];
//    completedLB.text = @"最近完成";
//    [header addSubview:completedLB];
//    return header;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TSTaskCompletedCell *cell = [self.completedTableView dequeueReusableCellWithIdentifier:TaskCompletedCellIdentfier];
    
    return cell;
}

- (UITableView *)completedTableView {
    if (!_completedTableView) {
        _completedTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 90, self.width-40, self.height) style:UITableViewStylePlain];
        _completedTableView.delegate = self;
        _completedTableView.dataSource = self;
    }
    return _completedTableView;
}
@end
