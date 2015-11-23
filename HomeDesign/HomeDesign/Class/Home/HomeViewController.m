//
//  HomeViewController.m
//  HomeDesign
//
//  Created by apple on 15/11/13.
//  Copyright (c) 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "HomeViewController.h"
//3种cell
#import "HomeCollectionViewCell1.h"
#import "HomeCollectionViewCell2.h"
#import "HomeCollectionReusableView.h"
#import "HomeCollectionViewCell3.h"
#import "YXFCollectionViewLayout.h"
#import "GSKSectionBackgroundFlowLayout.h"
//ViewControllers
#import "CitiPositioningViewController.h"


@interface HomeViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    NSArray *cell1UIArr;
    NSDictionary *cell3Dic;
    NSArray *cell2UIArr;
}

@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIButton *cityBtn;
@property (nonatomic, strong) UIButton *aboutUsBtn;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleImge.image = [UIImage imageNamed:@"logo"];
    self.backButton.hidden = YES;
    
    
    [self dataSouce];
    [self userInterface];
    
}

- (void)dataSouce{
    cell1UIArr = @[@{@"image" : @"lingbaozhuang", @"title" : @"拎包装", @"detaile" : @"个性定制整装"},
                       @{@"image" : @"lingbaozhaungplus", @"title" : @"拎包装PLUS", @"detaile" : @"群族定制整装"}];
    
    cell2UIArr = @[@{@"title": @"3D体验", @"image" : @"3dtiyan"},
                   @{@"title": @"德标工艺", @"image" : @"debiaogongyi"},
                   @{@"title": @"全球购", @"image" : @"quanqiugou"},
                   @{@"title": @"在建工程", @"image" : @"zaijiangongcheng"},
                   @{@"title": @"我要优惠", @"image" : @"woyaoyouhui"},
                   @{@"title": @"常见问题", @"image" : @"changjianwenti"},
                   @{@"title": @"在线预约", @"image" : @"zaixianyuyue"},
                   @{@"title": @"我要报价", @"image" : @"woyaobaojia"}];
    
    [self.collectionView reloadData];
}

#pragma mark - UI

- (void)userInterface{
    //colletion布局
    [self.view addSubview:self.collectionView];
    
    //城市按钮
    [self.navigationBarView addSubview:self.cityBtn];
    //关于我们
    [self.navigationBarView addSubview:self.aboutUsBtn];

}

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
//        YXFCollectionViewLayout  *flowyout = [[YXFCollectionViewLayout alloc] init];
        UICollectionViewFlowLayout *flowyout = [[UICollectionViewFlowLayout alloc] init];
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:RECT(0, FUSONNAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - 0 - FUSONNAVIGATIONBAR_HEIGHT) collectionViewLayout:flowyout];
       
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        [self.collectionView registerClass:[HomeCollectionViewCell1 class] forCellWithReuseIdentifier:@"cell1"];
        [self.collectionView registerClass:[HomeCollectionViewCell2 class] forCellWithReuseIdentifier:@"cell2"];
        [self.collectionView registerClass:[HomeCollectionViewCell3 class] forCellWithReuseIdentifier:@"cell3"];
        [self.collectionView registerClass:[HomeCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderViewCollectionReusableView"];
        [self.collectionView registerClass:[HomeCollectionReusableView class]
                forSupplementaryViewOfKind:GSKElementKindSectionBackground
                       withReuseIdentifier:NSStringFromClass([HomeCollectionReusableView class])];
    }
   return _collectionView;
}


- (UIButton *)cityBtn{
    if (_cityBtn == nil) {
        _cityBtn = [[UIButton alloc] initWithFrame:RECT(10, 30, 60, 30)];
        [_cityBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cityBtn setTitle:@"城市 ^" forState:UIControlStateNormal];
        [_cityBtn addTarget:self action:@selector(handldCityBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cityBtn;
}

- (UIButton *)aboutUsBtn{
    if (_aboutUsBtn == nil) {
        _aboutUsBtn = [[UIButton alloc] init];
        _aboutUsBtn.frame = RECT(SCREEN_WIDTH - 45, 30, 30, 30);
        [_aboutUsBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _aboutUsBtn.backgroundColor = [UIColor grayColor];
        [_aboutUsBtn addTarget:self action:@selector(handleAboutUsBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _aboutUsBtn;
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    
    NSLog(@"////////////%ld", (long)section);

    if (section == 0) {
        return 2;
    }else if(section == 1){
        return 1;
    }else{
        return 8;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3 ;
}

//配置表头
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld", (long)indexPath.section);
    HomeCollectionReusableView * background;
    if (indexPath.section == 1){
        background = [collectionView dequeueReusableSupplementaryViewOfKind:GSKElementKindSectionBackground withReuseIdentifier:NSStringFromClass([HomeCollectionReusableView class]) forIndexPath:indexPath];
        background.backgroundColor = [RGBColor colorWithHexString:@"#3c3c3c"];
    }else{
        background = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderViewCollectionReusableView" forIndexPath:indexPath];
    }
    return background;
}

//配置每个item
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        HomeCollectionViewCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor blackColor];
        [cell setCellInfo:cell1UIArr[indexPath.row]];
        return cell;
    }else if(indexPath.section == 2){
        HomeCollectionViewCell2 * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor blackColor];
        [cell setCellInfo:cell2UIArr[indexPath.row]];
        return cell;
    }else{
        HomeCollectionViewCell3 * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell3" forIndexPath:indexPath];
        [cell handleButton:^(NSInteger tag) {
            if (tag == 10) {
                NSLog(@"尊享家");
            }else if(tag == 11){
                NSLog(@"---------嗨款---------");
            }
        }];
        return cell;
    }
}


#pragma mark - <UICollectionViewDelegateFlowLayout>
//每个item的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.section == 0) {//装包
        return CGSizeMake((SCREEN_WIDTH - 20) / 2, SCREEN_WIDTH / 5.0);
    }else if (indexPath.section == 1){//嗨款 尊享家
        return CGSizeMake(SCREEN_WIDTH , SCREEN_WIDTH / 5.0);
    }else{//子菜单
        if (isSizeOf_5_5) {
            return CGSizeMake(SCREEN_WIDTH / 5.0, SCREEN_WIDTH / 3.9);
        }
       return CGSizeMake(SCREEN_WIDTH / 5.0, SCREEN_WIDTH / 4.5);
//        return CGSizeMake(SCREEN_WIDTH / 6, SCREEN_WIDTH /4.5);
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


#pragma mark - process 
//城市定位
- (void)handldCityBtn:(UIButton *)sender
{
    [self.navigationController pushViewController:[[CitiPositioningViewController alloc] init] animated:YES];
}
//关于我们
- (void)handleAboutUsBtn:(UIButton *)sender
{
    
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
