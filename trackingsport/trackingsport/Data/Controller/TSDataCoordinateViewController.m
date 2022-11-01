//
//  TSDataCoordinateViewController.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/31.
//

#import "TSDataCoordinateViewController.h"
#import "TSDataCollectionViewCell.h"
#import "TSDataModel.h"

#define kCellMargin 10       // cell间距
static NSString *contentCellID = @"ContentCellID";
@interface TSDataCoordinateViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) NSMutableArray<TSDataModel *> *datasource;
@end

@implementation TSDataCoordinateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"TSDataCoordinateViewController");
    
    [self setupUI];
}

- (void)setupUI {
    
    CGFloat fatherViewW = KScreenWidth-KLeftContentViewW-kTaskViewLeftSpace*2;
    CGFloat cellH = 150;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = kCellMargin;
    layout.minimumInteritemSpacing = kCellMargin;
    layout.estimatedItemSize = CGSizeMake((fatherViewW - kCellMargin*3)/4.0, cellH);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, fatherViewW, KScreenHeight-kTaskViewLeftSpace*3) collectionViewLayout:layout];
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.pagingEnabled = NO;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.scrollEnabled = NO;
    [collectionView registerClass:[TSDataCollectionViewCell class] forCellWithReuseIdentifier:contentCellID];
    [self.view addSubview:collectionView];
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
    TSDataCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:contentCellID forIndexPath:indexPath];
    
    cell.model = self.datasource[indexPath.row];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (NSArray<TSDataModel *> *)datasource {
    if (!_datasource) {
        _datasource = @[].mutableCopy;
        for (int i = 0; i < 10; i++) {
            TSDataModel *model = [TSDataModel new];
            model.timeStr = @"2022-09-28 12:09-12:10";
            model.tyepeStr = @"随堂测试-倒计时";
            model.gradeStr = @"五年级-1班";
            model.numberStr = @"2人";
            [_datasource addObject:model];
        }
    }
    return _datasource;
}
@end
