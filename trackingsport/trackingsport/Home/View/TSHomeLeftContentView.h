//
//  TSHomeLeftContentView.h
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TSHomeLeftContentView;

@protocol TSHomeLeftContentViewDelegate <NSObject>

- (void)pageContentView:(TSHomeLeftContentView *)pageContentView progress:(CGFloat)progress sourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex;

@end


@interface TSHomeLeftContentView : TSBaseView

@property (nonatomic, strong) NSArray <UIViewController *> *childVCs;
@property (nonatomic, strong) UIViewController *parentVC;

@property (nonatomic, weak) id<TSHomeLeftContentViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame childViewControllerArrays:(NSArray <UIViewController *>*)childViewControllerArrays parentViewController:(UIViewController *)parentViewController;

- (void)currrentIndex:(NSInteger)currrentIndex;
@end

NS_ASSUME_NONNULL_END
