//
//  TSTaskHeaderItemView.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/24.
//

#import "TSTaskHeaderItemView.h"

@implementation TSTaskHeaderItemView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = TSBackgroundColor;
        self.cornerRadius = 10;
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    UILabel *filedLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.width, self.height*0.3)];
    filedLB.backgroundColor = ClearColor;
    filedLB.textColor = LightGrayColor;
    filedLB.numberOfLines = 0;
    filedLB.font = [UIFont systemFontOfSize:Kfont14];
    filedLB.textAlignment = NSTextAlignmentCenter;
    _filedLB = filedLB;
    [self addSubview:filedLB];
    
    UILabel *valueLB = [[UILabel alloc] initWithFrame: CGRectMake(0, filedLB.bottom, self.width, self.height*0.7)];
    valueLB.backgroundColor = ClearColor;
    valueLB.textColor = BlackColor;
    valueLB.numberOfLines = 0;
    valueLB.font = [UIFont systemFontOfSize:Kfont18];
    valueLB.textAlignment = NSTextAlignmentCenter;
    _valueLB = valueLB;
    [self addSubview:valueLB];
}
@end
