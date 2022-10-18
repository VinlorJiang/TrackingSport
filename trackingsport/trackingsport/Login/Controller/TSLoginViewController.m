//
//  TSLoginViewController.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/12.
//

#import "TSLoginViewController.h"
#import "TSHomeViewController.h"
#import "TSNetWorkManage.h"

#define textViewW 300
#define textfieldH 40
#define tipLabelW 50



@interface TSLoginViewController ()
@property (strong, nonatomic) UILabel *title1LB;
@property (strong, nonatomic) UILabel *title2LB;
@property (strong, nonatomic) UIView *accountView;
@property (strong, nonatomic) UILabel *accountLB;
@property (strong, nonatomic) UITextField *accountTF;
@property (strong, nonatomic) UIView *passwordView;
@property (strong, nonatomic) UILabel *passwordLB;
@property (strong, nonatomic) UITextField *passwordTF;
@property (strong, nonatomic) UIButton *loginBtn;
@end

@implementation TSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = WhiteColor;
    [self setupUI];
    
    [KNotificationCenter addObserver:self
                            selector:@selector(enterBackground:)
                                name:UIApplicationDidEnterBackgroundNotification
                              object:nil];
    
    
    [KNotificationCenter addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [KNotificationCenter addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma private methods
- (void)setupUI {
    UILabel *title1Label = [[UILabel alloc] initWithFrame:CGRectMake(0, 300, KScreenWidth, 30)];
    title1Label.backgroundColor = WhiteColor;
    title1Label.text = @"一起科学训练";
    title1Label.textColor = BlackColor;
    title1Label.numberOfLines = 0;
    title1Label.font = KFont(15);
    title1Label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:title1Label];
    self.title1LB = title1Label;
    
    UILabel *title2Label = [[UILabel alloc] initWithFrame:CGRectMake(0, title1Label.bottom, KScreenWidth, 30)];
    title2Label.backgroundColor = WhiteColor;
    title2Label.text = @"青少年体能评估";;
    title2Label.textColor = BlackColor;
    title2Label.numberOfLines = 0;
    title2Label.font = KFont(16);
    title2Label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:title2Label];
    
    UIView *accountView = [[UIView alloc] initWithFrame:CGRectMake((KScreenWidth-textViewW)*0.5, title2Label.bottom, textViewW, textfieldH)];
    accountView.backgroundColor = YellowColor;
    [self.view addSubview:accountView];
    accountView.layer.cornerRadius = textfieldH * 0.5;
    self.accountView = accountView;
    
    UILabel *accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tipLabelW, textfieldH)];
    accountLabel.backgroundColor = ClearColor;
    accountLabel.text = @"账号";
    accountLabel.textColor = BlackColor;
    accountLabel.numberOfLines = 0;
    accountLabel.font = KFont(15);
    accountLabel.textAlignment = NSTextAlignmentRight;
    [accountView addSubview:accountLabel];
    
    UITextField *accountTextField = [[UITextField alloc] initWithFrame:CGRectMake(accountLabel.right+15, 0, textViewW - tipLabelW - 15, textfieldH)];
    accountTextField.placeholder = @"请输入账号";
    accountTextField.font = KFont(16);
    accountTextField.textColor = BlackColor;
    accountTextField.textAlignment = NSTextAlignmentLeft;
    accountTextField.borderStyle = UITextBorderStyleNone;
    [accountView addSubview:accountTextField];
    
    
    UIView *passwordView = [[UIView alloc] initWithFrame:CGRectMake(accountView.left, accountView.bottom+20, textViewW, textfieldH)];
    passwordView.backgroundColor = RedColor;
    [self.view addSubview:passwordView];
    passwordView.layer.cornerRadius = textfieldH * 0.5;
    self.passwordView = passwordView;
    
    UILabel *passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tipLabelW, textfieldH)];
    passwordLabel.backgroundColor = ClearColor;
    passwordLabel.text = @"密码";
    passwordLabel.textColor = BlackColor;
    passwordLabel.numberOfLines = 0;
    passwordLabel.font = KFont(15);
    passwordLabel.textAlignment = NSTextAlignmentRight;
    [passwordView addSubview:passwordLabel];
    
    UITextField *passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(passwordLabel.right+15, 0,  textViewW - tipLabelW - 15, textfieldH)];
    passwordTextField.placeholder = @"请输入密码";
    passwordTextField.font = KFont(16);
    passwordTextField.textColor = BlackColor;
    passwordTextField.textAlignment = NSTextAlignmentLeft;
    passwordTextField.borderStyle = UITextBorderStyleNone;
    [passwordView addSubview:passwordTextField];
    passwordTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(accountView.left, passwordView.bottom + 20, textViewW, textfieldH)];
    
    loginButton.backgroundColor = BlueColor;
    loginButton.titleLabel.font = KFont(20);
    loginButton.titleLabel.numberOfLines = 0;
    loginButton.layer.cornerRadius = textfieldH * 0.5;
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
//    [loginButton setTitle:<#NSString#> forState:UIControlStateHighlighted];
//    [loginButton setTitle:<#NSString#> forState:UIControlStateSelected];
//    [loginButton setTitle:<#NSString#> forState:UIControlStateDisabled];
    
    [loginButton setTitleColor:WhiteColor forState:UIControlStateNormal];
//    [loginButton setTitleColor:<#UIColor#>forState:UIControlStateHighlighted];
//    [loginButton setTitleColor:<#UIColor#>forState:UIControlStateSelected];
//    [loginButton setTitleColor:<#UIColor#> forState:UIControlStateDisabled];
    
    
    [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    self.loginBtn = loginButton;
    
}

- (void)login {
    TSNSLog(@"");
    UINavigationController *navVc = [[UINavigationController alloc] initWithRootViewController:[TSHomeViewController new]];
//    [KAppDelegate.window.rootViewController presentViewController:[TSRootViewController new] animated:YES completion:nil];
    
    NSDictionary *paramDic = [[NSDictionary alloc] init];
    [[TSNetWorkManage shareManage] loginRequestFromController:self parameters:paramDic success:^(TSNetworkRespose * _Nonnull dataTask, id  _Nonnull response, NSDictionary * _Nonnull loginSaveDictionary) {
        TSNSLog(@"");
    } failure:^(TSNetworkRespose * _Nonnull dataTask, NSError * _Nonnull error) {
        TSNSLog(@"");
        KWindow.rootViewController = [TSHomeViewController new];
    }];
}

#pragma mark ________________________________________________________键盘处理

/** 键盘出现 */
static CGFloat keyboardHeight = 0;
- (void)keyBoardWillShow:(NSNotification *)sender {
    keyboardHeight = MAX([sender.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height, keyboardHeight); //键盘高度
    CGFloat keyBoardY = KScreenHeight - keyboardHeight; //键盘Window中的Y值
    CGFloat pwdBottom = self.passwordView.bottom + 15;
    if (keyBoardY >= pwdBottom) return;
    CGFloat interval = ABS(pwdBottom - keyBoardY);
    [UIView animateWithDuration:0.25 animations:^{
        self.view.top =- interval;
    }];
}
- (void)keyBoardWillHide:(NSNotification *)sender {
    [UIView animateWithDuration:0.25 animations:^{ self.view.top = 0;}];
}

@end
