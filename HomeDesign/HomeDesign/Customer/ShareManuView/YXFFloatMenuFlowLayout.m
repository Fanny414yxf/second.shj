//
//  YXFFloatMenuFlowLayout.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/8.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "YXFFloatMenuFlowLayout.h"

@implementation YXFFloatMenuFlowLayout

 - (void)prepareLayout
{
    [super prepareLayout];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
//        CGFloat width = (SCREEN_WIDTH - 120) / 5.0;
        CGFloat width =  (SCREEN_WIDTH - 82) / 5;
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.sectionInset = UIEdgeInsetsZero;
        self.itemSize = CGSizeMake(width, width);
        self.minimumLineSpacing = 5;
        self.minimumInteritemSpacing = 5;
    }
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        if (CGRectIntersectsRect(attribute.frame, rect)){
            if (visibleRect.origin.x == 0) {
                [self.delegate collectionView:self.collectionView layout:self cellCenteredAtIndexPath:attribute.indexPath page:0];
            }else{
               //除法取整 取余数
                div_t x = div(visibleRect.origin.x, visibleRect.size.width);
                if (x.quot > 0 && x.rem > 0) {
                    [self.delegate collectionView:self.collectionView layout:self cellCenteredAtIndexPath:attribute.indexPath page:x.quot + 1];
                }
                if (x.quot > 0 && x.rem == 0) {
                    [self.delegate collectionView:self.collectionView layout:self cellCenteredAtIndexPath:attribute.indexPath page:x.quot];
                }
            }
        }
    }
    return attributes;
}

@end
