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
@property (strong, nonatomic) NSArray *textArray;

@end
@implementation TSStudentTestView

- (instancetype)initWithFrame:(CGRect)frame
                    textArray:(NSArray *)textArray
                   dataSource:(NSMutableArray<TSStudentTestModel *> *)dataSource {
    self = [super initWithFrame:frame];
    if(self) {
        self.datasource = dataSource;
        self.textArray = textArray;
        [self setupUI];
    }
    return  self;
}
- (void)setupUI {
    
    CGFloat fatherViewW = KScreenWidth-KLeftContentViewW*2-20;
    
    UIButton *nameBtn = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth - KLeftContentViewW - 160 - 20, 10, 160, 50)];
    [nameBtn setTitle:@"马小师" forState:UIControlStateNormal];
    [nameBtn setTitleColor:BlackColor forState:UIControlStateNormal];
    UIImage *image = [UIImage imageNamed:@"menu"];
    [nameBtn setImage:image forState:UIControlStateNormal];
    [nameBtn horizontalCenterTitleAndImage:4];
    nameBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:nameBtn];
    
    UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(0, nameBtn.bottom, fatherViewW, 30)];
    titleLB.backgroundColor = ClearColor;
    titleLB.text = @"训练";
    titleLB.textColor = BlackColor;
    titleLB.font = KFont(20);
    [self addSubview:titleLB];
    
    CGFloat w = fatherViewW / self.textArray.count;
    
    for (int i = 0; i < self.textArray.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(w * i, titleLB.bottom+15, w, 100)];
        
        btn.titleLabel.font = KFont(20);
        btn.titleColor = BlackColor;
        [btn setTitle:self.textArray[i] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
//        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
//        btn.imageView.backgroundColor = [UIColor redColor];
        [btn setTag:i + 100];
        [btn alineImageAndTitle:10];
        [self addSubview:btn];
        
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UILabel *testLB = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLB.bottom + 140, self.frame.size.width, 30)];
    testLB.backgroundColor = ClearColor;
    testLB.text = @"学生体质测试";
    testLB.textColor = BlackColor;
    testLB.font = KFont(20);
    [self addSubview:testLB];
    
    // 上下左右的间距 : sectionInset(left, top, bottom, right)
    TSStudentTestLayout *layout = [[TSStudentTestLayout alloc] init];
    layout.minimumLineSpacing = 20;
    layout.minimumInteritemSpacing = 20;
    layout.estimatedItemSize = CGSizeMake((KScreenWidth - 200)/4, 10);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
   
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, testLB.bottom+15, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
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
    
    if (indexPath.row < 4) {
        cell.backgroundColor = KRGBColor(240, 250, 255);
        cell.typeLB.textColor = KRGBColor(0, 133, 251);
    } else if (indexPath.row < 8 && indexPath.row > 3) {
        cell.backgroundColor = KRGBColor(255, 245, 245);
        cell.typeLB.textColor = KRGBColor(252, 79, 84);
    } else if (indexPath.row > 7 && indexPath.row < self.datasource.count - 1) {
        cell.backgroundColor = KRGBColor(255, 250, 245);
        cell.typeLB.textColor = KRGBColor(248, 138, 40);
    } else if (indexPath.row == self.datasource.count - 1) {
        cell.backgroundColor = KRGBColor(251, 245, 255);
        cell.typeLB.textColor = KRGBColor(130, 38, 215);
    }
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if([self.stuTestViewClickDelegate respondsToSelector:@selector(click:index:)]) {
        [self.stuTestViewClickDelegate click:self.datasource[indexPath.row] index:indexPath.row];
    }
}


- (void)click:(UIButton *)btn {
    if (self.trainingTypeBlock) {
        self.trainingTypeBlock(btn);
    }
}
@end
