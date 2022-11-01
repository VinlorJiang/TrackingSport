//
//  TSHomeLeftTitleView.h
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TSHomeLeftTitleView;

@protocol TSHomeLeftTitleViewDelegate <NSObject>

- (void)pageTitleView:(TSHomeLeftTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex;

@end


@interface TSHomeLeftTitleView : TSBaseView

@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, weak) id<TSHomeLeftTitleViewDelegate> delegate;


- (instancetype)initWithFrame:(CGRect)frame
                   titleArray:(NSArray *)titleArray
                   imageArray:(NSArray *)imageArray;

- (void)titleWithProgress:(CGFloat)progress sourceIndex:(int)sourceIndex targetIndex:(int)targetIndex;

@end

NS_ASSUME_NONNULL_END
