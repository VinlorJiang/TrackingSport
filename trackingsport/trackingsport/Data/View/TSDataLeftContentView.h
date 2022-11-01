//
//  TSDataLeftContentView.h
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/31.
//

#import "TSBaseView.h"

NS_ASSUME_NONNULL_BEGIN
@class TSDataLeftContentView;

@protocol TSDataLeftContentViewDelegate <NSObject>

- (void)pageContentView:(TSDataLeftContentView *)pageContentView progress:(CGFloat)progress sourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex;

@end


@interface TSDataLeftContentView : TSBaseView

@property (nonatomic, strong) NSArray <UIViewController *> *childVCs;
@property (nonatomic, strong) UIViewController *parentVC;

@property (nonatomic, weak) id<TSDataLeftContentViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame childViewControllerArrays:(NSArray <UIViewController *>*)childViewControllerArrays parentViewController:(UIViewController *)parentViewController;

- (void)currrentIndex:(NSInteger)currrentIndex;
@end


NS_ASSUME_NONNULL_END
