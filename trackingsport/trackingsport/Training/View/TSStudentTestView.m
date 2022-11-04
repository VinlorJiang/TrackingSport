//
//  TSStudentTestView.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/13.
//

#import "TSStudentTestView.h"
#import "TSStudentTestCollectionViewCell.h"
#import "TSStudentTestLayout.h"

static NSString *contentCellID = @"ContentCellID";
@interface TSStudentTestView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) NSMutableArray<TSStudentTestModel *>  *datasource;
@end
@implementation TSStudentTestView

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSMutableArray<TSStudentTestModel *> *)dataSource {
    self = [super initWithFrame:frame];
    if(self) {
        self.datasource = dataSource;
        [self setupUI];
    }
    return  self;
}
- (void)setupUI {
    UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
    titleLB.backgroundColor = ClearColor;
    titleLB.text = @"学生体质测试";
    titleLB.textColor = BlackColor;
    titleLB.font = KFont(20);
    [self addSubview:titleLB];
    
    // 上下左右的间距 : sectionInset(left, top, bottom, right)
    TSStudentTestLayout *layout = [[TSStudentTestLayout alloc] init];
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 0.1;
    layout.estimatedItemSize = CGSizeMake((KScreenWidth - 200)/4, 10);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
   
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, titleLB.bottom+15, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.pagingEnabled = NO;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.scrollEnabled = NO;
    collectionView.backgroundColor = WhiteColor;
//    [collectionView registerClass:[TestCollectionViewCell class] forCellWithReuseIdentifier:contentCellID];
    [collectionView registerNib:[UINib nibWithNibName:@"TSStudentTestCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:contentCellID];
    [self addSubview:collectionView];
}
// UICollectionViewCell 个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datasource.count;
}
// Section 个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TSStudentTestCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:contentCellID forIndexPath:indexPath];
    
    cell.testModel = self.datasource[indexPath.row];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if([self.stuTestViewClickDelegate respondsToSelector:@selector(click:index:)]) {
        [self.stuTestViewClickDelegate click:self.datasource[indexPath.row] index:indexPath.row];
    }
}
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(15, 15, 5, 15);//分别为上、左、下、右
//}
@end
