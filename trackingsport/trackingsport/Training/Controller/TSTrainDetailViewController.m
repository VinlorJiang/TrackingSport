//
//  TSTrainDetailViewController.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/13.
//

#import "TSTrainDetailViewController.h"
#import "CustomKeyboard.h"

@interface TSTrainDetailViewController ()<CustomKeyboardProtocol,UITextFieldDelegate>
@property (strong, nonatomic) UITextField *heightTF;
@end

@implementation TSTrainDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = LightGrayColor;
    [self.view addSubview:self.heightTF];
}

- (UITextField *)heightTF {
    if(!_heightTF) {
        _heightTF = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, KScreenWidth, 300)];
        _heightTF.delegate = self;
        _heightTF.inputView = [CustomKeyboard KeyboardWithTextField:_heightTF delegate:self keyboardType:KeyboardHavePointAmount];
    }
    return _heightTF;
}
- (void)customTextFieldDidChange:(UITextField *)textField {
    TSNSLog(@"customTextFieldDidChange");
}
- (BOOL)textFieldShouldClear:(UITextField *)textField {
    
    return YES;
}
@end
