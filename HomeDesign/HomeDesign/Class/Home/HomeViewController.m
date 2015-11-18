//
//  HomeViewController.m
//  HomeDesign
//
//  Created by apple on 15/11/13.
//  Copyright (c) 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCollectionViewCell1.h"
#import "HomeCollectionViewCell2.h"
#import "HomeCollectionReusableView.h"

@interface HomeViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *adImageView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    __weak typeof (self)weakSelf = self;
    
    NSLog(@"%f  %f", SCREEN_WIDTH, SCREEN_HEIGHT);
    
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf.view);
        make.top.mas_equalTo(FUSONNAVIGATIONBAR_HEIGHT);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(SCREEN_HEIGHT - FUSONNAVIGATIONBAR_HEIGHT - 240);
        make.bottom.equalTo(weakSelf.view.mas_bottom);
    }];
    
}
//
- (UIScrollView *)contentScrollView{
    if (_contentScrollView == nil) {
        _contentScrollView = [[UIScrollView alloc] initWithFrame:RECT(0, FUSONNAVIGATIONBAR_HEIGHT, SCREEN_WIDTH ,SCREEN_HEIGHT - FUSONNAVIGATIONBAR_HEIGHT)];
        if (SCREEN_HEIGHT < 736) {
            _contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 736);
        }else{
            _contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
        }
        _contentScrollView.delegate = self;
    }
    return _contentScrollView;
}

- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowyout = [[UICollectionViewFlowLayout alloc] init];
        flowyout.itemSize = CGSizeMake(SCREEN_WIDTH, 0);
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:RECT(0, 300, SCREEN_WIDTH, SCREEN_HEIGHT - 0 - FUSONNAVIGATIONBAR_HEIGHT) collectionViewLayout:flowyout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        [self.collectionView registerClass:[HomeCollectionViewCell1 class] forCellWithReuseIdentifier:@"cell1"];
        [self.collectionView registerClass:[HomeCollectionViewCell2 class] forCellWithReuseIdentifier:@"cell2"];
        [self.collectionView registerClass:[HomeCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderViewCollectionReusableView"];
    }
   return _collectionView;
}



#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    if (section == 0) {
        return 4;
    }else{
        return 8;
    }
}
//配置表头
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;{
    HomeCollectionReusableView * reusableVeiw = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderViewCollectionReusableView" forIndexPath:indexPath];
    reusableVeiw.backgroundColor = [UIColor whiteColor];
    return reusableVeiw;
}
//配置每个item
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        HomeCollectionViewCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
        return cell;
    }else{
        HomeCollectionViewCell2 * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
        UIView *backgroundView = [[UIView alloc] init];
        backgroundView.backgroundColor = [RGBColor colorWithHexString:@"#3c3c3c"];
        cell.backgroundView = backgroundView;
        return cell;
    }
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
//每个item的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.section == 0) {
        
        return CGSizeMake(SCREEN_WIDTH / 2.2, SCREEN_WIDTH / 5.0);
    }else {
        return CGSizeMake(SCREEN_WIDTH / 5, SCREEN_WIDTH / 4.5);
    }
}
//每个item边缘间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;{
    return UIEdgeInsetsMake(10, 5, 3, 5);
}

//同一行之间的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;{
    
    return 10.0;
}
/*
 *设定页眉的尺寸
 *返回头headerView的大小,根据滚动方向不同，header和footer的width和height中只有一个会起作用
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
      return CGSizeMake(SCREEN_WIDTH, 240);
    }
    return CGSizeMake(0, 0);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
