//
//  TSTrainingViewController.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/12.
//

#import "TSTrainingViewController.h"
#import "TSTrainView.h"
#import "TSStudentTestView.h"
#import "TSStudentTestModel.h"
#import "TSTrainDetailViewController.h"

@interface TSTrainingViewController ()<TSStudentTestViewClickDelegate>
@property (strong, nonatomic) TSTrainView *trainView;
@property (strong, nonatomic) TSStudentTestView *stuTestView;
@property (strong, nonatomic) NSMutableArray<TSStudentTestModel *> *dataArray;
@end

@implementation TSTrainingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Training";
    self.view.backgroundColor = WhiteColor;
    [self.view addSubview:self.trainView];
    [self handleEvent];
    [self.view addSubview:self.stuTestView];
    self.stuTestView.stuTestViewClickDelegate = self;
}

- (void)handleEvent {
    __block typeof(self) weakSelf = self;
    self.trainView.trainingTypeBlock = ^(UIButton * _Nonnull type) {
        [weakSelf trainType:type.tag];
    };
}

- (void)trainType:(NSInteger)tag {
    NSLog(@"tag:%ld",(long)tag);
}

#pragma mark - setter and getter

- (TSTrainView *)trainView {
    if(!_trainView) {
        _trainView = [[TSTrainView alloc] initWithFrame:CGRectMake(10, 30, KScreenWidth-70-100, 100) textArray:@[@"协调",@"敏捷",@"力量",@"平衡",@"速度",@"心率"]];
    }
    return _trainView;
}

- (TSStudentTestView *)stuTestView {
    if (!_stuTestView) {
        NSArray *typeArray = @[@"体重指数(BMI)",@"肺活量",@"坐位体前屈",@"1分钟跳绳",@"50米跑",@"50米x8往返跑",@"1000米跑（男）",@"800米跑（女）",@"1分钟仰卧起坐",@"引体向上（男）",@"立定跳远立定跳远立定跳远立定跳远立定跳远立定跳远"];
        NSArray *gradeArray = @[@"全年级",@"全年级",@"全年级",@"小学",@"全年级",@"小学五～六年级",@"初中、高中、大学",@"初中、高中、大学",@"小学三年级～大学四年级",@"初中、高中、大学",@"初中、高中、大学"];
        self.dataArray = @[].mutableCopy;
        for (int i = 0; i < typeArray.count; i++) {
            TSStudentTestModel *model = [TSStudentTestModel new];
            model.typeStr = typeArray[i];
            model.gradeStr = gradeArray[i];
            [self.dataArray addObject:model];
        }
        _stuTestView = [[TSStudentTestView alloc] initWithFrame:CGRectMake(10, 130, KScreenWidth-70-100, KScreenHeight-130) dataSource:self.dataArray];
    }
    return _stuTestView;;
}

#pragma -- delagate
- (void)click:(TSStudentTestModel *)model index:(NSInteger)index {
    NSLog(@"model:%@",model);
    TSTrainDetailViewController *detailVc = [TSTrainDetailViewController new];
    [self.navigationController pushViewController:detailVc animated:YES];
}
@end
