//
//  TSDataLeftTitleView.h
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/31.
//

#import "TSBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@class TSDataLeftTitleView;

@protocol TSDataLeftTitleViewDelegate <NSObject>

- (void)pageTitleView:(TSDataLeftTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex;

@end


@interface TSDataLeftTitleView : TSBaseView

@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, weak) id<TSDataLeftTitleViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray;

- (void)titleWithProgress:(CGFloat)progress sourceIndex:(int)sourceIndex targetIndex:(int)targetIndex;

@end

NS_ASSUME_NONNULL_END
