//
//  TSTrainingViewController.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/12.
//

#import "TSTrainingViewController.h"
#import "TSStudentTestView.h"
#import "TSStudentTestModel.h"
#import "TSTrainDetailViewController.h"

@interface TSTrainingViewController ()<TSStudentTestViewClickDelegate>
@property (strong, nonatomic) TSStudentTestView *stuTestView;
@property (strong, nonatomic) NSMutableArray<TSStudentTestModel *> *dataArray;
@end

@implementation TSTrainingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Training";
    self.view.backgroundColor = WhiteColor;
    [self handleEvent];
    [self.view addSubview:self.stuTestView];
    self.stuTestView.stuTestViewClickDelegate = self;
    
    
}


- (void)handleEvent {
    __block typeof(self) weakSelf = self;
    self.stuTestView.trainingTypeBlock = ^(UIButton * _Nonnull type) {
        [weakSelf trainType:type.tag];
    };
}

- (void)trainType:(NSInteger)tag {
    NSLog(@"tag:%ld",(long)tag);
    NSArray *dicArr = @[@"协调训练模式",@"敏捷训练模式",@"力量训练模式",@"平衡训练模式",@"速度训练模式",@"心率训练模式",
    ];
    TSTrainDetailViewController *detailVc = [TSTrainDetailViewController new];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.navigationController pushViewController:detailVc animated:YES];
}

#pragma mark - setter and getter

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
        _stuTestView = [[TSStudentTestView alloc] initWithFrame:CGRectMake(20, 30, KScreenWidth-KLeftContentViewW-20, KScreenHeight-20) textArray:@[@"协调",@"敏捷",@"力量",@"平衡",@"速度",@"心率"] dataSource:self.dataArray];
    }
    return _stuTestView;;
}

#pragma -- delagate
- (void)click:(TSStudentTestModel *)model index:(NSInteger)index {
    NSLog(@"model:%@",model);
    
}
@end
