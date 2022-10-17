//
//  UITextField+Common.h
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (Common)
@property (nonatomic, assign) NSInteger startDistance; //光标距离开始的位置
@property (nonatomic, assign) NSInteger endDistance;   //光标距离结束的位置
@property (nonatomic, assign) NSInteger currOffset;    //所在位置

@property (nonatomic, assign) BOOL latterIsSpace;        //光标后一位是否是空格
@property (nonatomic, assign) BOOL previousIsSpace;      //光标前一位是否是空格
@property (nonatomic, assign) BOOL lastIsSpace;          //最后一位是否是空格
@property (nonatomic, assign) NSInteger selectedNumbers; //选中的个数
@property (nonatomic, assign) CGFloat duration;
@end
@interface NoPasteTextField : UITextField

@end
NS_ASSUME_NONNULL_END
