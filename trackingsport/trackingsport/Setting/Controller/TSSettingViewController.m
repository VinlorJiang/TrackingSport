//
//  TSSettingViewController.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/12.
//

#import "TSSettingViewController.h"
#import "TSSettingHeaderView.h"
#import "TSSettingViewCell.h"


#define KHeaderViewH 150

@interface TSSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) TSSettingHeaderView *headerView;
@end

@implementation TSSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Setting";
    [self.view addSubview:self.tableView];
}

#pragma mark ---- TableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 3;
    } else {
        return 1;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * setCellId = @"setCellId";
    
    TSSettingViewCell * cell = [tableView dequeueReusableCellWithIdentifier:setCellId];
    if (!cell) {
        cell = [[TSSettingViewCell alloc] initWithStyle:UITableViewCellStyleValue1  reuseIdentifier:setCellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = KRGBColor(233, 246, 253);
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.cornerRadius = 12;
    }
    cell.bottomLine.hidden = YES;
    switch (indexPath.section) {
        case 0: {
            cell.textLB.text = @"身份认证";
            cell.detailLB.text = @"明日之星小学";
        }
            break;
        case 1: {
            cell.bottomLine.hidden = NO;
            cell.cornerRadius = 0;
            if (indexPath.row == 0) {
                cell.textLB.text = @"硬件更新";
                [self setRadiusForView:cell byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadiu:CGSizeMake(12, 12)];
            } else if (indexPath.row == 1) {
                cell.textLB.text = @"硬件名称";
                
            } else if (indexPath.row == 2) {
                cell.bottomLine.hidden = YES;
                cell.textLB.text = @"清除队列";
                [self setRadiusForView:cell byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadiu:CGSizeMake(12, 12)];
            }
        }
            break;
        case 2: {
            cell.textLB.text = @"关于我们";
            cell.detailLB.text = @"V 1.5.7";
        }
            break;
        case 3: {
            cell.textLB.text = @"退出登录";
        }
            break;
        default:
            break;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return KHeaderViewH;
    } else if (section == 3)
    {
        return 10;
    } else {
        return 0.01;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) return self.headerView;
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TSNSLog(@"");
}

- (void)setRadiusForView:(UIView *)view  byRoundingCorners:(UIRectCorner)roundCorner cornerRadiu:(CGSize)radius {
    //在此处一定要加个延迟操作，不然整个view是不会显示出来的
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:roundCorner cornerRadii:radius];

        CAShapeLayer *layer1 = [[CAShapeLayer alloc]init];
        layer1.frame = view.bounds;
        layer1.path = path.CGPath;
        view.layer.mask = layer1;
    });
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(30, 100, KScreenWidth-KLeftContentViewW - 60, KScreenHeight-100) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}

- (TSSettingHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[TSSettingHeaderView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth-KLeftContentViewW - 60, KHeaderViewH)];
    }
    return _headerView;
}
@end
