//
//  TSBaseView.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/12.
//

#import "TSBaseView.h"

@implementation TSBaseView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.backgroundColor = WhiteColor;
    }
    return  self;
}
@end
