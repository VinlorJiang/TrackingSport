//
//  TSTrainDetailViewController.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/13.
//

#import "TSTrainDetailViewController.h"
#import "CustomKeyboard.h"
#import "TSTrainClassTableViewCell.h"

#define classBtnW 180


@interface TSTrainDetailViewController ()<CustomKeyboardProtocol,UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITextField *heightTF;
@property (nonatomic,strong) UIButton *tempTypeButton;
@property (strong, nonatomic) NSArray *classDataSource;
@property (strong, nonatomic) UITableView *classTableView;
@property (strong, nonatomic) UIButton *classBtn;
@end

@implementation TSTrainDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = KRGBColor(49, 186, 244);
//    [self.view addSubview:self.heightTF];
    [self setupUI];
    
    [self setTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 设置导航栏背景透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    
}

- (void)setupUI {
    // 1.测试类型
    CGFloat padding = 30;
    CGFloat btnW = classBtnW;
    CGFloat btnH = 100;
    CGFloat btnY = 44*2;
    NSArray *titleArr = @[@"随堂测试",@"标准测试"];
    for (int i = 0; i < titleArr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(padding + (btnW + 20)* i, btnY, btnW, btnH);
        [btn setBackgroundColor:KRGBColor(60, 169, 223)];
//        [btn setTitle:titleArr[i]];
        [btn setTitleColor:WhiteColor forState:UIControlStateNormal];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        btn.tag = 200 + i;
        btn.cornerRadius = 20;
        [btn addTarget:self action:@selector(testTypeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        if (i == 0) {
            
            btn.selected = YES;
            [btn setBackgroundColor:KRGBColor(247, 139, 116)];
            self.tempTypeButton = btn;
        }
    }
    
    // 2.下拉菜单选择
    CGFloat menuBtnH = 50;
    // 2.1 班级
    UILabel *classLB = [[UILabel alloc] initWithFrame:CGRectMake(padding, self.tempTypeButton.bottom + padding, btnW-10, menuBtnH-10)];
    [self.view addSubview:classLB];
    classLB.text = @"班级";
    classLB.textColor = WhiteColor;
    
    UIButton *classBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    classBtn.frame = CGRectMake(classLB.left, classLB.bottom+10, btnW-10, menuBtnH);
    [self.view addSubview:classBtn];
    [classBtn setTitle:@"二年级-1班" forState:UIControlStateNormal];
    [classBtn setBackgroundColor:KRGBColor(30, 113, 164)];
    [classBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [classBtn addTarget:self action:@selector(selectClassBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [classBtn setCornerRadius:16];
    self.classBtn = classBtn;
    classBtn.selected = NO;
    
    // 2.2 模式
    UILabel *kindLB = [[UILabel alloc] initWithFrame:CGRectMake(classLB.right+20, classLB.top, btnW-10, 40)];
    [self.view addSubview:kindLB];
    kindLB.text = @"模式";
    kindLB.textColor = WhiteColor;
    
    UIButton *kindBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    kindBtn.frame = CGRectMake(kindLB.left, kindLB.bottom+10, btnW-10, menuBtnH);
    [self.view addSubview:kindBtn];
    [kindBtn setTitle:@"倒计时" forState:UIControlStateNormal];
    [kindBtn setBackgroundColor:KRGBColor(30, 113, 164)];
    [kindBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [kindBtn addTarget:self action:@selector(kindBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [kindBtn setCornerRadius:16];
    
    // 2.3 选择
    UILabel *selectLB = [[UILabel alloc] initWithFrame:CGRectMake(kindLB.right+20, classLB.top, btnW-10, 40)];
    [self.view addSubview:selectLB];
    selectLB.text = @"选择学生";
    selectLB.textColor = WhiteColor;
    
    UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectBtn.frame = CGRectMake(selectLB.left, selectLB.bottom+10, btnW-10, menuBtnH);
    [self.view addSubview:selectBtn];
    [selectBtn setTitle:@"已选（50人）" forState:UIControlStateNormal];
    [selectBtn setBackgroundColor:KRGBColor(30, 113, 164)];
    [selectBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [selectBtn addTarget:self action:@selector(selectBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [selectBtn setCornerRadius:16];
    
    // 3.组数 蓝牙连接
    UILabel *countLB = [[UILabel alloc] initWithFrame:CGRectMake(classLB.left, classBtn.bottom + padding, 50, 40)];
    [self.view addSubview:countLB];
    countLB.text = @"组数";
    countLB.textColor = WhiteColor;
    
    UIButton *linkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    linkBtn.frame = CGRectMake(countLB.right, classBtn.bottom+padding+5, 70, 30);
    [self.view addSubview:linkBtn];
    [linkBtn setTitle:@"一键连接" forState:UIControlStateNormal];
    [linkBtn setBackgroundColor:WhiteColor];
    [linkBtn setTitleColor:KRGBColor(253, 130, 70) forState:UIControlStateNormal];
    [linkBtn addTarget:self action:@selector(linkBtn) forControlEvents:UIControlEventTouchUpInside];
    [linkBtn setCornerRadius:8];
    [linkBtn.titleLabel setFont:[UIFont systemFontOfSize:Kfont12]];
}

- (void)setTableView {
    
    self.classTableView.left = self.classBtn.left + 3;
    self.classTableView.top = self.classBtn.bottom;
    self.classTableView.size = CGSizeMake(classBtnW-16, 0);
    self.classTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.classTableView];
    
}


#pragma private methods

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.classBtn.selected) {
        self.classBtn.selected = NO;
        [UIView animateWithDuration:0.25 animations:^{
            self.classTableView.height = 0;
        }];
    }
   
}

// 选择班级
- (void)selectClassBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    CGFloat height = 0;
    if (sender.selected) {
        height = self.classDataSource.count * 30;
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.classTableView.height = height;
    }];
}
// 切换模式
- (void)kindBtnClick {
    
}

/// 选择学生
- (void)selectBtnClick {
    
}
// 一键连接
- (void)linkBtn {
    
}

- (void)testTypeBtnClick:(UIButton *)sender {

    // TODO: 逻辑待实现
    NSLog(@"");
    // 1、如果点击的是同一个按钮，就返回
    if (self.tempTypeButton == sender) { return; }
    // 2、如果点击的不是同一个按钮，那么上一个按钮就是非选中状态，修改背景颜色
    [self.tempTypeButton setBackgroundColor:KRGBColor(60, 169, 223)];
    // 3、sender是当前的按钮，切换当前的状态与背景颜色
    sender.selected = YES;
    [sender setBackgroundColor:KRGBColor(247, 139, 116)];
    // 4、修改上一个按钮的状态
    self.tempTypeButton.selected = NO;
    // 5、把当前按钮赋值给零时变量tempTypeButton
    self.tempTypeButton = sender;
    
    if (sender.tag - 200) {
        // tag == 1 标准测试
        NSLog(@"标准测试");
    } else {
        // tag == 0 随堂测试
        NSLog(@"随堂测试");
    }
}




#pragma delegate methods

- (void)customTextFieldDidChange:(UITextField *)textField {
    TSNSLog(@"customTextFieldDidChange");
}
- (BOOL)textFieldShouldClear:(UITextField *)textField {
    
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.classDataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"setCellId";
    TSTrainClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[TSTrainClassTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.classLB.text = self.classDataSource[indexPath.row];
    
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [UIView animateWithDuration:0.25 animations:^{
        self.classBtn.selected = NO;
        [self.classBtn setTitle:self.classDataSource[indexPath.row] forState:UIControlStateNormal];
        tableView.height = 0;
    }];
}

#pragma setter and getter

- (UITextField *)heightTF {
    if(!_heightTF) {
        _heightTF = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, KScreenWidth, 300)];
        _heightTF.delegate = self;
        _heightTF.inputView = [CustomKeyboard KeyboardWithTextField:_heightTF delegate:self keyboardType:KeyboardHavePointAmount];
    }
    return _heightTF;
}

- (UITableView *)classTableView {
    if (!_classTableView) {
        _classTableView = [[UITableView alloc] init];
        _classTableView.delegate = self;
        _classTableView.dataSource = self;
        _classTableView.backgroundColor = WhiteColor;
        _classTableView.cornerRadius = 6;
    }
    return _classTableView;;
}
- (NSArray *)classDataSource {
    if (!_classDataSource) {
        _classDataSource = @[
            @"二年级-1班",
            @"二年级-2班",
            @"二年级-8班",
            @"三年级-1班",
            @"四年级-1班",
            @"五年级-1班",
            @"六年级-1班",
            @"六年级-2班",
            @"初二-迹动班",
            @"初二-1班",
            @"初二-2班",
            @"初二-男3班",
            @"初二-女4班",
            @"初三-1班",
        ];
    }
    return _classDataSource;
}
@end
