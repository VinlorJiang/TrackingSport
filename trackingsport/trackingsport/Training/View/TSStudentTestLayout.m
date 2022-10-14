//
//  TSStudentTestLayout.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/13.
//

#import "TSStudentTestLayout.h"

@implementation TSStudentTestLayout
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {

    CGPoint mostRecentOffset = CGPointZero;
    CGRect cvBounds = self.collectionView.bounds;
    CGFloat halfWidth = cvBounds.size.width * 0.5;
    CGFloat offsetAdjustment = MAXFLOAT;
    CGFloat horizontalCenterX = proposedContentOffset.x + (self.collectionView.bounds.size.width / 2.0);
    
    NSArray *tempArray = [super layoutAttributesForElementsInRect:cvBounds];
    NSArray *attributesForVisibleCells = [[NSArray alloc]initWithArray:tempArray copyItems:YES];

    UICollectionViewLayoutAttributes *candidateAttributes;
    if (attributesForVisibleCells.count > 0) {
        for (UICollectionViewLayoutAttributes *attributes in attributesForVisibleCells) {
        
            if(ABS(attributes.center.x - horizontalCenterX) < ABS(offsetAdjustment)) {
                offsetAdjustment = attributes.center.x - horizontalCenterX;
            }
            
            if (attributes.representedElementCategory != UICollectionElementCategoryCell) {
                continue;
            }
            
            if ((attributes.center.x == 0) || (attributes.center.x > (self.collectionView.contentOffset.x + halfWidth) && velocity.x < 0)) {
                continue;
            }
            
            candidateAttributes = attributes;
        }
        
        if (velocity.x == 0) {
            return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
        } else
            return CGPointMake(candidateAttributes.center.x - halfWidth, proposedContentOffset.y);
    }
    mostRecentOffset = [super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];
    
    return mostRecentOffset;

}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    

    NSMutableArray *attributes = [[super layoutAttributesForElementsInRect:rect] mutableCopy];

        //注意起始值
        for(NSInteger i = 1; i < [attributes count]; i++){
            UICollectionViewLayoutAttributes *currentLayoutAttributes = attributes[i];
            UICollectionViewLayoutAttributes *prevLayoutAttributes = attributes[i - 1];
            NSInteger prevorigin = CGRectGetMaxX(prevLayoutAttributes.frame);
            NSInteger curIndex = currentLayoutAttributes.indexPath.section;
            NSInteger preIndex = prevLayoutAttributes.indexPath.section;
            if (curIndex != preIndex) { //如果是分组进行跳过
                continue;
            }
            if(prevorigin + 10 + currentLayoutAttributes.frame.size.width < self.collectionViewContentSize.width-20){
                CGRect frame = currentLayoutAttributes.frame;
                frame.origin.x = prevorigin + 10;
                currentLayoutAttributes.frame = frame;
            }
        }

        return attributes;
    
}
//解决ios8上自动布局的问题
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}


@end
