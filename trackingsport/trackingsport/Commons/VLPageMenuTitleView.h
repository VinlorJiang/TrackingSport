//
//  VLPageMenuTitleView.h
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class VLPageMenuTitleView;

@protocol VLPageMenuTitleViewDelegate <NSObject>

- (void)pageTitleView:(VLPageMenuTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex;

@end

@interface VLPageMenuTitleView : UIView

/// 是否是水平布局，如果为true，则水平；否则，垂直布局
@property (assign, nonatomic) BOOL isHorizontalLayout;

/// 是否有底部横线
@property (assign, nonatomic) BOOL isHasBottomLine;

@property (nonatomic, strong) NSArray *imageNameArray;

@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, weak) id<VLPageMenuTitleViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame
                isHorizontalLayout:(BOOL)isHorizontalLayout
                isHasBottomLine:(BOOL)isHasBottomLine
                menuTitleArray:(NSArray *)titleArray;
                

- (void)titleWithProgress:(CGFloat)progress sourceIndex:(int)sourceIndex targetIndex:(int)targetIndex;

@end

NS_ASSUME_NONNULL_END
