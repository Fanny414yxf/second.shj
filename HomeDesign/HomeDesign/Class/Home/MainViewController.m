//
//  MainViewController.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/12.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "MainViewController.h"

//3种cell
#import "HomeCollectionViewCell1.h"
#import "HomeCollectionViewCell2.h"
#import "HomeCollectionReusableView.h"
#import "HomeCollectionViewCell3.h"
#import "YXFCollectionViewLayout.h"
#import "GSKSectionBackgroundFlowLayout.h"
#import "MainCell1.h"
#import "MainHeaderReusableView.h"

//ViewControllers
#import "AdvertisingViewController.h"
#import "CitiPositioningViewController.h"
#import "AboutUsViewController.h"
#import "LinbaozhuangPlusViewController.h"
#import "IWantOfferViewController.h"
#import "ConstructionSiteViewController.h"
#import "CommonProblemsViewController.h"
#import "ZunXiangJia/ZunXiangJiaViewController.h"
#import "DebiaoGongyi/DebiaoGongyiViewController.h"
#import "QuanQiuGou/GlobalViewController.h"
#import "HopShopingViewController.h"
#import "LinbaoZhuang/LinBaoZhuangViewController.h"
#import "SandiTiyanViewController.h"
#import "FastAppointmentViewController.h"
#import "OnLinePopWebViewController.h"
//view
#import "OnLineOrder.h"
#import "SDCycleScrollView.h"


@interface MainViewController ()<UICollectionViewDataSource, UICollectionViewDelegate,GSKSectionBackgroundFlowLayoutDelegate, ReusableViewDelege, SDCycleScrollViewDelegate>
{
    OnLineOrder *onlineView;
    NSArray *itemNameAndImages;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) UILabel *citiyName;
@property (nonatomic, strong) UIButton *aboutUsBtn;

@end

@implementation MainViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _citiyName.text = [UserInfo shareUserInfo].kCityName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleImage.image = [UIImage imageNamed:@"logo"];
    self.backimage.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetCityName:) name:NOTIFICATION_CITY object:nil];
    
    
    [self userInterface];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI
- (void)userInterface{
    //colletion布局
    itemNameAndImages = @[@{@"title": @"3D体验", @"image" : @"home_3dtiyan"},
                          @{@"title": @"德标工艺", @"image" : @"home_debiaogongyi"},
                          @{@"title": @"全球购", @"image" : @"home_quanqiugou"},
                          @{@"title": @"在建工程", @"image" : @"home_zaijiangongcheng"},
                          @{@"title": @"我要优惠", @"image" : @"home_woyaoyouhui"},
                          @{@"title": @"常见问题", @"image" : @"home_changjianwenti"},
                          @{@"title": @"在线预约", @"image" : @"home_zaixianyuyue"},
                          @{@"title": @"我要报价", @"image" : @"home_woyaobaojia"}];
    self.collectionView.backgroundColor = [RGBColor colorWithHexString:@"#3c3c3c"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"MainCell1" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"MainHeaderReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    //城市按钮
    [self.navigationBarView addSubview:[self cityBtn]];
    //关于我们
    [self.navigationBarView addSubview:self.aboutUsBtn];
}


- (UIView *)cityBtn{
    UIView *city = [[UIView alloc] initWithFrame:RECT(10, 30, 60, 30)];
    city.userInteractionEnabled = YES;
    UIImageView *mapImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"city_map"]];
    mapImage.frame = RECT(0, 7, 10, 15);
    mapImage.contentMode = UIViewContentModeScaleAspectFit;
    [city addSubview:mapImage];
    _citiyName = [[UILabel alloc] initWithFrame:RECT(ORIGIN_X_ADD_SIZE_W(mapImage)+3, 5, 50, 20) textAlignment:NSTextAlignmentLeft font:FONT(12) textColor:[UIColor grayColor]];
//    _citiyName.text = [[NSUserDefaults standardUserDefaults] objectForKey:KCITY];
    _citiyName.text = [UserInfo shareUserInfo].kCityName;
    [city addSubview:_citiyName];
    
    UIButton *cityBtn = [[UIButton alloc] initWithFrame:RECT(0, 0, 60, 30)];
//    city.backgroundColor = [UIColor cyanColor];
    [cityBtn addTarget:self action:@selector(handldCityBtn:) forControlEvents:UIControlEventTouchUpInside];
    [city addSubview:cityBtn];
    return city;
}

- (UIButton *)aboutUsBtn{
    if (_aboutUsBtn == nil) {
        _aboutUsBtn = [[UIButton alloc] init];
        _aboutUsBtn.frame = RECT(SCREEN_WIDTH - 30, 30, 20, 20);
        [_aboutUsBtn setImage:[UIImage imageNamed:@"icon_about_us"] forState:UIControlStateNormal];
        [_aboutUsBtn addTarget:self action:@selector(handleAboutUsBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _aboutUsBtn;
}


#pragma mark - <UICollectionViewDataSource, UICollectionViewDelegate>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    MainCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell setCellInfo:itemNameAndImages[indexPath.row]];
    if (indexPath.row != 0) {
        cell.mageNew.hidden = YES;
    }
    return cell;
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (isSizeOf_4_0) {
        return CGSizeMake(SCREEN_WIDTH / 4.0, SCREEN_SCALE_HEIGHT(71));
    }
    return CGSizeMake(SCREEN_WIDTH / 4.0, SCREEN_SCALE_HEIGHT(75));
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    MainHeaderReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
    reusableView.delegate = self;
    [self reusableProcess:reusableView];
    return reusableView;
}

//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return -0;
}

//返回头headerView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size={SCREEN_WIDTH, SCREEN_SCALE_HEIGHT(450)};
    return size;
}
//****************collectionView事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            SandiTiyanViewController *sanDtiyanVC = [[SandiTiyanViewController alloc] init];
            sanDtiyanVC.url = SANDITIYAN_HTML;
            [self.navigationController pushViewController:sanDtiyanVC animated:YES];
        }
            break;
        case 1:
        {
            DebiaoGongyiViewController *debiaogongyiVC = [[DebiaoGongyiViewController alloc] init];
            debiaogongyiVC.url = DEBIAOGONGYI_HTML;
            [self.navigationController pushViewController:debiaogongyiVC animated:YES];
        }
            break;
        case 2:
        {
            GlobalViewController *globalVC = [[GlobalViewController alloc] init];
            [self.navigationController pushViewController:globalVC animated:YES];
        }
            break;
        case 3:
        {
            ConstructionSiteViewController *constructionSiteVC = [[ConstructionSiteViewController alloc] init];
            [self.navigationController pushViewController:constructionSiteVC animated:YES];
        }
            break;
        case 4:

            
            break;
        case 5:
        {
            CommonProblemsViewController *offerVC = [[CommonProblemsViewController alloc] init];
            [self.navigationController pushViewController:offerVC animated:YES];
        }
            break;
        case 6:
        {
            onlineView = [[OnLineOrder alloc] init];
            [self handleOnLineOrer:onlineView];
            [self.view addSubview:onlineView];
        }
            break;
        case 7:
        {
            IWantOfferViewController *offerVC = [[IWantOfferViewController alloc] init];
            [self.navigationController pushViewController:offerVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

//***********reusableView事件
- (void)reusableProcess:(MainHeaderReusableView*)reusableView
{
    [reusableView handleButton:^(NSInteger tag) {
        
        switch (tag) {
            case ReusableTypeYuanZhuangZhengPin:
            {
                
            }
                break;
            case ReusableTypeZengXiangQuanMian:
            {
                
            }
                break;
            case ReusableType0YanQi:
            {
                
            }
                break;
            case ReusableTypeHuanBaoBuDaBiaoQuanETuiKuan:
            {
                
            }
                break;
            case ReusableTypeLinBaoZhuang:
            {
                LinBaoZhuangViewController *linbaozhuangVC = [[LinBaoZhuangViewController alloc] init];
                linbaozhuangVC.url = LINBAOZHUANG_HTML;
                [self.navigationController pushViewController:linbaozhuangVC animated:YES];
            }
                break;
            case ReusableTypeLinBaoZhuangPLUS:
            {
                LinbaozhuangPlusViewController *linbaozhuangVC = [[LinbaozhuangPlusViewController alloc] init];
                [self.navigationController pushViewController:linbaozhuangVC animated:YES];
            }
                break;
            case ReusableTypeZunXiangJia:
            {
                ZunXiangJiaViewController *zunXiangJiaVC = [[ZunXiangJiaViewController alloc] init];
                zunXiangJiaVC.url = ZUNXIANGJIA_HTML;
                [self.navigationController pushViewController:zunXiangJiaVC animated:YES];
            }
                break;
            case ReusableTypeHaiKuan:
            {
                HopShopingViewController *hopVC = [[HopShopingViewController alloc] init];
                [self.navigationController pushViewController:hopVC animated:YES];
            }
            break;
                
            default:
                break;
        }
    }];
}


#pragma mark - <ReusableViewDelege>
- (void)subViewDelegateMethods
{
    
}


- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;
{
    NSLog(@" 选择了第%ld张图片", (long)index);
    
}


- (BOOL)collectionView:(UICollectionView*)collectionView displaysBackgroundAtSection:(NSUInteger)section;
{
    
    return YES;
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
    [self.navigationController pushViewController:[[AboutUsViewController alloc] init] animated:YES];
}


- (void)handleOnLineOrer:(OnLineOrder *)order
{
    [order handleButton:^(NSInteger tag) {
        switch (tag) {
            case OnLineOrderTel:
            {
                NSLog(@"打电话啊");
            }
                break;
            case OnLineOrderOrder:
            {
                NSLog(@"快速预约");
                FastAppointmentViewController *fastAppointmentVC = [[FastAppointmentViewController alloc] init];
                [self.navigationController pushViewController:fastAppointmentVC animated:YES];
            }
                break;
            case OnLineOrderWeb:
            {
                NSLog(@"在线咨询");
                OnLinePopWebViewController *onLinePopViewVC = [[OnLinePopWebViewController alloc] init];
                onLinePopViewVC.url = ZAIXIANYUYUE_HTML;
                [self.navigationController pushViewController:onLinePopViewVC animated:YES];
            }
                break;
            default:
                break;
        }
        [onlineView removeFromSuperview];
    }];
}

#pragma notification
- (void)resetCityName:(NSNotification *)notification
{
    _citiyName.text = notification.object;
}

@end
