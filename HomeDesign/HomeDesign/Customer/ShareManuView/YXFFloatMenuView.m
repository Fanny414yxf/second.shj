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

@property (nonatomic, strong) UICollectionView *contentVeiw;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation YXFFloatMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [RGBColor colorWithHexString:@"565656"];
    
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

- (UIScrollView *)contentVeiw
{
    if (_contentVeiw != nil) {
        return _contentVeiw;
    }
    CGFloat width = self.frame.size.width  - 10;
    CGFloat height = self.frame.size.height - 20;
    
    YXFFloatMenuFlowLayout *flowLayout = [[YXFFloatMenuFlowLayout alloc] init];
    flowLayout.delegate = self;
    
    _contentVeiw = [[UICollectionView alloc] initWithFrame:RECT(5, 5, width, height)  collectionViewLayout:flowLayout];
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
    return 27;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    ItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    CGFloat with = (SCREEN_WIDTH - 65) / 5;
    return CGSizeMake(with, with);
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

#pragma mark - <UIPageViewControllerDelegate, UIPageViewControllerDataSource

//- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController;



@end
