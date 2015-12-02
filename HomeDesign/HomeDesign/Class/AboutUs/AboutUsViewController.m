//
//  AboutUsViewController.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/1.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "AboutUsViewController.h"
#import "HomeCollectionViewCell2.h"

@interface AboutUsViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSArray *aboutUsArr;
}

@property (nonatomic, strong) UIImageView *aboutImage;
@property (nonatomic, strong) UICollectionView *collectionView;


@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    aboutUsArr = @[@{@"title" : @"公司简介", @"image":@"aboutus_gongsijianjie"},
                   @{@"title" : @"企业荣誉", @"image" : @"aboutus_qiyerongyu"},
                   @{@"title" : @"企业文化", @"image" : @"aboutus_qiyewenhua"},
                   @{@"title" : @"发展历程", @"image" : @"aboutus_fazhanlicheng"},
                   @{@"title" : @"精英团队", @"image" : @"aboutus_jingyingteam"},
                   @{@"title" : @"联系我们", @"image" : @"aboutus_lianxiwomen"}];
    
    _aboutImage = [[UIImageView alloc] initWithFrame:RECT(0, FUSONNAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT * 0.65)];
    _aboutImage.image = [UIImage imageNamed:@"aboutus_iamge"];
    [self.view addSubview:_aboutImage];
    
    
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT * 0.65, SCREEN_WIDTH, SCREEN_HEIGHT * 0.35) collectionViewLayout:flowlayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[HomeCollectionViewCell2 class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:_collectionView];
    
}

#pragma mark - <UICollectionViewDataSource, UICollectionViewDelegate>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCollectionViewCell2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell setCellInfo:aboutUsArr[indexPath.row]];
    cell.backgroundColor = [UIColor orangeColor];
    UIImageView *bg = [[UIImageView alloc] init];
    bg.image = [UIImage imageNamed:@"aboutus_cellbg_bg"];
    cell.backgroundView = bg;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    if (isSizeOf_5_5) {
        return CGSizeMake((SCREEN_WIDTH - 45) / 3, SCREEN_HEIGHT * 0.15);
    }
    return CGSizeMake((SCREEN_WIDTH - 40) / 3, SCREEN_HEIGHT * 0.15);
}

//同一行之间的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;{
    //******************************************************************
    if (section == 2) {
        return 0;
    }
    return 10.0;
}


//每个item边缘间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;{
       return UIEdgeInsetsMake(10, 10, 10, 10);
}

//不同行之间的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
{
      return 10.0;
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
