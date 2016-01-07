//
//  AboutUsViewController.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/1.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "AboutUsViewController.h"
#import "HomeCollectionViewCell2.h"
#import "AboutUsDetailViewController.h"

@interface AboutUsViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSArray *aboutUsArr;
    NSArray *detailHTMLArr;
    
}

@property (nonatomic, strong) UIImageView *aboutImage;
@property (nonatomic, strong) UICollectionView *collectionView;


@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"关于我们";
    
    aboutUsArr = @[@{@"title" : @"公司简介", @"image":@"icon_about_us_gsjs"},
                   @{@"title" : @"企业荣誉", @"image" : @"aboutus_qiyerongyu"},
                   @{@"title" : @"企业文化", @"image" : @"aboutus_qiyewenhua"},
                   @{@"title" : @"发展历程", @"image" : @"aboutus_fazhanlicheng"},
                   @{@"title" : @"精英团队", @"image" : @"aboutus_jingyingteam"},
                   @{@"title" : @"联系我们", @"image" : @"aboutus_lianxiwomen"}];
    
    detailHTMLArr = @[GUANYUWOMEN_GSJJ_HTML,
                      GUANYUWOMEN_QYRY_HTML,
                      GUANYUWOMEN_QYWH_HTML,
                      GUANYUWOMEN_FZLC_HTML,
                      GUANYUWOMEN_JYTD_HTML,
                      GUANYUWOMEN_LXWM_HTML];
    
    
    
    _aboutImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"aboutus_iamge"]];
    _aboutImage.frame = RECT(0, FUSONNAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT * 0.65 - FUSONNAVIGATIONBAR_HEIGHT);
    _aboutImage.contentMode = UIViewContentModeScaleAspectFill;
    _aboutImage.clipsToBounds = NO;
    [self.view addSubview:_aboutImage];
    CGFloat cellwidth = (SCREEN_WIDTH - 20) / 3;
    
    if (isSizeOf_3_5 || isSizeOf_4_0) {
        _aboutImage.contentMode = UIViewContentModeScaleAspectFill; //UIViewContentModeScaleToFill
        _aboutImage.frame = RECT(0, FUSONNAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - FUSONNAVIGATIONBAR_HEIGHT - cellwidth * 2 - 18);
    }else if (isSizeOf_4_7 || isSizeOf_5_5){
        _aboutImage.frame = RECT(0, FUSONNAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - FUSONNAVIGATIONBAR_HEIGHT - cellwidth * 2 - 14);
    }
    
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView.frame = RECT(0, ORIGIN_Y_ADD_SIZE_H(_aboutImage), SCREEN_WIDTH, SCREEN_HEIGHT - SIZE_H(_aboutImage) - FUSONNAVIGATIONBAR_HEIGHT);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y_ADD_SIZE_H(_aboutImage), SCREEN_WIDTH, SCREEN_HEIGHT * 0.35) collectionViewLayout:flowlayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[HomeCollectionViewCell2 class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:_collectionView];
    if (isSizeOf_3_5) {
        _aboutImage.contentMode = UIViewContentModeScaleToFill;
       self.collectionView.frame = RECT(0, ORIGIN_Y_ADD_SIZE_H(_aboutImage), SCREEN_WIDTH, SCREEN_HEIGHT - SIZE_H(_aboutImage) - FUSONNAVIGATIONBAR_HEIGHT);
    }else if (isSizeOf_4_0){
        self.collectionView.frame = RECT(0, ORIGIN_Y_ADD_SIZE_H(_aboutImage), SCREEN_WIDTH, SCREEN_HEIGHT - SIZE_H(_aboutImage) - FUSONNAVIGATIONBAR_HEIGHT);
    }else if (isSizeOf_4_7){
        self.collectionView.frame = RECT(0, ORIGIN_Y_ADD_SIZE_H(_aboutImage), SCREEN_WIDTH, SCREEN_HEIGHT - SIZE_H(_aboutImage) - FUSONNAVIGATIONBAR_HEIGHT);
    }else{
        self.collectionView.frame = RECT(0, ORIGIN_Y_ADD_SIZE_H(_aboutImage), SCREEN_WIDTH, SCREEN_HEIGHT - SIZE_H(_aboutImage) - FUSONNAVIGATIONBAR_HEIGHT);
    }

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
    cell.layer.cornerRadius = 5;
    UIImageView *bg = [[UIImageView alloc] init];
    bg.image = [UIImage imageNamed:@"aboutus_cellbg_bg"];
    cell.backgroundView = bg;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
{
//    if (isSizeOf_5_5) {
//        return CGSizeMake((SCREEN_WIDTH - 45) / 3, SCREEN_HEIGHT * 0.15);
//    }
//    return CGSizeMake((SCREEN_WIDTH - 40) / 3, SCREEN_HEIGHT * 0.15);
    if (isSizeOf_5_5 || isSizeOf_4_7) {
        return CGSizeMake((SCREEN_WIDTH - 45) / 3, (SCREEN_WIDTH - 45) / 3);
    }
    return CGSizeMake((SCREEN_WIDTH - 40) / 3, (SCREEN_WIDTH - 40) / 3);
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WebViewController *aboutUsDetailVC  =[[WebViewController alloc] init];
    aboutUsDetailVC.url = [NSString stringWithFormat:@"%@%@",ADVIMAGE_URL,detailHTMLArr[indexPath.row]];
    aboutUsDetailVC.titleString = aboutUsArr[indexPath.row][@"title"];
    [self.navigationController pushViewController:aboutUsDetailVC animated:YES];
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
