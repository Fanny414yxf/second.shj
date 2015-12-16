//
//  YXFFloatMenuView.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/7.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "YXFFloatMenuView.h"
#import "YXFFloatMenuFlowLayout.h"
#import "ItemCollectionViewCell.h"

@interface YXFFloatMenuView ()<UICollectionViewDataSource, UICollectionViewDelegate, FloatMenuViewFlowLayoutDelegate>
{
    NSArray *itemsArr;
}

@property (nonatomic, strong) UICollectionView *contentVeiw;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation YXFFloatMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [RGBColor colorWithHexString:@"#565656"];
    
        [self addSubview:self.contentVeiw];
        [self addSubview:self.pageControl];
    }
    return self;
}

- (UIPageControl *)pageControl
{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] initWithFrame:RECT(0, 0, 60, 30)];
        _pageControl.center = CGPointMake(self.frame.size.width/2, self.frame.size.height - 8);
        _pageControl.numberOfPages = 3;
        _pageControl.currentPageIndicatorTintColor = [RGBColor colorWithHexString:MAINCOLOR_GREEN];
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    }
    
    return _pageControl;
}


//- (void)setItems:(NSArray *)items
//{
//    CGFloat remainder = [items count] % 10;
//    NSInteger pagecontrolPageNumber = [items count]/10;
//    if (remainder != 0) {
//        _pageControl.numberOfPages = pagecontrolPageNumber + 1;
//    }else{
//        _pageControl.numberOfPages = pagecontrolPageNumber;
//    }
//    
//    itemsArr = [NSArray arrayWithArray:items];
//    [self.contentVeiw reloadData];
//}

- (UIScrollView *)contentVeiw
{
    if (_contentVeiw != nil) {
        return _contentVeiw;
    }
    CGFloat width = self.frame.size.width  - 10;
    CGFloat height = self.frame.size.height - 20;
    
    YXFFloatMenuFlowLayout *flowLayout = [[YXFFloatMenuFlowLayout alloc] init];
    flowLayout.delegate = self;
    
    _contentVeiw = [[UICollectionView alloc] initWithFrame:RECT(5, 8, width, height)  collectionViewLayout:flowLayout];
    _contentVeiw.backgroundColor = [RGBColor colorWithHexString:@"565656"];
    _contentVeiw.directionalLockEnabled = YES;
    _contentVeiw.showsHorizontalScrollIndicator = NO;
    _contentVeiw.showsVerticalScrollIndicator = NO;
    _contentVeiw.pagingEnabled = YES;
    _contentVeiw.scrollEnabled = YES;
    [_contentVeiw registerClass:[ItemCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    _contentVeiw.delegate = self;
    _contentVeiw.dataSource = self;
    return _contentVeiw;
}

#pragma mark - <FloatMenuViewFlowLayoutDelegate>
- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout cellCenteredAtIndexPath:(NSIndexPath *)indexPath page:(int)page
{
    self.pageControl.currentPage = page;
}

#pragma mark - <UICollectionViewDataSource, UICollectionViewDelegate>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
//    if (itemsArr != nil) {
//        return itemsArr.count;
//    }
//    return 0;
    
    return 27;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    ItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.itemImageName = [NSString stringWithFormat:@"%@",@"quanqiugou_item2"];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (isSizeOf_3_5) {
        CGFloat with = (SCREEN_WIDTH - 82) / 5;
        return CGSizeMake(with, with);
    }else{
        CGFloat with = (SCREEN_WIDTH - 80) / 5;
        return CGSizeMake(with, with);
    }
}

//每个item边缘间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)sectio
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

//不同行之间的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
{
    return 8.0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.clickItem) {
        self.clickItem(indexPath.row);
    }
}

- (void)clickedItemsAction:(BlockBtnClick)block
{
    self.clickItem = block;
}



@end
