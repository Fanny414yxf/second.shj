//
//  MainViewController.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/12.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "MainViewController.h"

//3种cell
#import "HomeCollectionViewCell2.h"
#import "YXFCollectionViewLayout.h"
#import "GSKSectionBackgroundFlowLayout.h"
#import "MainCell1.h"
#import "MainHeaderReusableView.h"

//ViewControllers
#import "CitiPositioningViewController.h"
#import "AboutUsViewController.h"
#import "ErpriseDynamicViewController.h"
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

#import "MainViewModle.h"
#import "MainModel.h"


@interface MainViewController ()<UICollectionViewDataSource, UICollectionViewDelegate,GSKSectionBackgroundFlowLayoutDelegate, SDCycleScrollViewDelegate, UIAlertViewDelegate>
{
    OnLineOrder *onlineView;
    NSArray *itemNameAndImages;
    MainModel *mainModel;

    NSArray *cjwtQuestionTypeArr;//常见问题问题分类
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) UILabel *citiyName;
@property (nonatomic, strong) UIButton *aboutUsBtn;
@property (nonatomic, strong) UIImageView *aboutsumenubg;

@end

@implementation MainViewController


- (void)dealloc
{
    [self removeObserver:self forKeyPath:NOTIFICATION_CITY];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    _citiyName.text = @"定位中";
    if (![[UserInfo shareUserInfo].currentCityName isEqualToString:@"(null"]) {
        _citiyName.text = [UserInfo shareUserInfo].currentCityName;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _aboutsumenubg.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleImage.image = [UIImage imageNamed:@"logo"];
    self.backimage.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetCityNameAndRefreshUserInterface:) name:NOTIFICATION_CITY object:nil];
    
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
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:@"MainCell1" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"MainHeaderReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(dropDownRefresh)];
    header.lastUpdatedTimeLabel.hidden = YES;
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(dropDownRefresh)];

    //城市按钮
    [self.navigationBarView addSubview:[self cityBtn]];
    //关于我们
    [self.navigationBarView addSubview:[self aboutusBtn]];
    
    [self.collectionView.mj_header beginRefreshing];
    
    _aboutsumenubg = [[UIImageView alloc] initWithFrame:RECT(SCREEN_WIDTH - 75, 58, 70, 75)];
    _aboutsumenubg.image = [UIImage imageNamed:@"home_abus2"];
    _aboutsumenubg.userInteractionEnabled = YES;
    _aboutsumenubg.hidden = YES;
    [self.view addSubview:_aboutsumenubg];
    
    UIButton *enterpriseDynamicBtn = [[UIButton alloc] initWithFrame:RECT(0, 10, SIZE_W(_aboutsumenubg), 30)];
    enterpriseDynamicBtn.titleLabel.font = FONT(12);
    [enterpriseDynamicBtn setTitle:@"企业动态" forState:UIControlStateNormal];
    [enterpriseDynamicBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [enterpriseDynamicBtn addTarget:self action:@selector(showAboutUsOrentErpriseDynamicBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_aboutsumenubg addSubview:enterpriseDynamicBtn];
    
    UIView *line = [[UIView alloc] initWithFrame:RECT(10, 41, 50, 1)];
    line.backgroundColor = [UIColor colorWithHex:0.3 alpha:0.5];
    [_aboutsumenubg addSubview:line];
    
    UIButton *aboutusBtn = [[UIButton alloc] initWithFrame:RECT(0, 45, SIZE_W(_aboutsumenubg), 30)];
    aboutusBtn.titleLabel.font = FONT(12);
    [aboutusBtn setTitle:@"关于我们" forState:UIControlStateNormal];
    [aboutusBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [aboutusBtn addTarget:self action:@selector(showAboutUsOrentErpriseDynamicBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_aboutsumenubg addSubview:aboutusBtn];

}


- (UIView *)cityBtn{
    UIView *city = [[UIView alloc] initWithFrame:RECT(10, 00, 60, 60)];
    city.userInteractionEnabled = YES;
    UIImageView *mapImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"city_map"]];
    mapImage.frame = RECT(0, 37, 10, 15);
    mapImage.contentMode = UIViewContentModeScaleAspectFit;
    [city addSubview:mapImage];
    _citiyName = [[UILabel alloc] initWithFrame:RECT(ORIGIN_X_ADD_SIZE_W(mapImage)+3, 35, 50, 20) textAlignment:NSTextAlignmentLeft font:FONT(12) textColor:[UIColor grayColor]];
    _citiyName.text = @"定位中";
    [city addSubview:_citiyName];
    
    UIButton *cityBtn = [[UIButton alloc] initWithFrame:RECT(0, 0, 60, 60)];
    [cityBtn addTarget:self action:@selector(handldCityBtn:) forControlEvents:UIControlEventTouchUpInside];
    [city addSubview:cityBtn];
    return city;
}


- (UIView *)aboutusBtn{
    UIView *aboutus = [[UIView alloc] initWithFrame:RECT(SCREEN_WIDTH - 60, 0, 60, 60)];
    aboutus.userInteractionEnabled = YES;
    
    UIImageView *aboutusImage = [[UIImageView alloc] initWithFrame:RECT(30, 30, 20, 20)];
    aboutusImage.image = [UIImage imageNamed:@"home_abus1"];
    [aboutus addSubview:aboutusImage];
    
    UIButton *button = [[UIButton alloc] init];
    button.frame = RECT(0, 0, 60, 60);
    [button addTarget:self action:@selector(handleAboutUsBtn:) forControlEvents:UIControlEventTouchUpInside];
    [aboutus addSubview:button];
    return aboutus;
}


//下拉刷新
- (void)dropDownRefresh
{
    MainViewModle *mainViewModel = [[MainViewModle alloc] init];
    [mainViewModel getMianVCDataWithType:4 cityID:[UserInfo shareUserInfo].cityID];
    [mainViewModel setBlockWithReturnBlock:^(id data) {
        mainModel = data;
        [self refreshUI:mainModel];
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
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
    indexPath.row == 0 ? (cell.mageNew.hidden = NO) : (cell.mageNew.hidden = YES);
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
    reusableView.adScorll.delegate = self;
    [reusableView.adCycleScrollView handleButtonAction:^(NSInteger tag) {
        WebViewController *webVC = [[WebViewController alloc] init];
        webVC.url = @"http://www.baidu.com/";
        [self.navigationController pushViewController:webVC animated:YES];
    }];
    [reusableView setReusableViewInfo:mainModel];
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
            WebViewController *sanDtiyanVC = [[WebViewController alloc] init];
            sanDtiyanVC.url = [NSString stringWithFormat:@"%@%@",URL_TEST, SANDITIYAN_HTML];
            sanDtiyanVC.info = mainModel.threeD;
            sanDtiyanVC.titleString = @"3D体验";
            [self.navigationController pushViewController:sanDtiyanVC animated:YES];
        }
            break;
        case 1:
        {
            WebViewController *debiaogongyiVC = [[WebViewController alloc] init];
            debiaogongyiVC.url = [NSString stringWithFormat:@"%@%@",URL_TEST, DEBIAOGONGYI_HTML];
            debiaogongyiVC.info = mainModel.debiaogongyi;
            debiaogongyiVC.titleString = @"德标工艺";
            [self.navigationController pushViewController:debiaogongyiVC animated:YES];
        }
            break;
        case 2:
        {
            GlobalViewController *globalVC = [[GlobalViewController alloc] init];
            if (![mainModel.changjianwenti isEqual:[NSNull null]]) {
                globalVC.info = mainModel.changjianwenti;
            }else{
                globalVC.info = nil;
            }
             [self.navigationController pushViewController:globalVC animated:YES];
        }
            break;
        case 3:
        {
            ConstructionSiteViewController *constructionSiteVC = [[ConstructionSiteViewController alloc] init];
            [self.navigationController pushViewController:constructionSiteVC animated:YES];
            if (![mainModel.changjianwenti isEqual:[NSNull null]]) {
                constructionSiteVC.info = mainModel.zaijiangongcheng;
            }else{
                constructionSiteVC.info = nil;
            }
        }
            break;
        case 4:{
            if (![mainModel.woyaobaojia isEqual:[NSNull null]]) {
                
            }else{
                [SVProgressHUD svprogressHUDWithString:@"敬请期待"];
            }
        }
            break;
        case 5:
        {
            CommonProblemsViewController *offerVC = [[CommonProblemsViewController alloc] init];

            if (![mainModel.changjianwenti isEqual:[NSNull null]]) {
                offerVC.info = mainModel.changjianwenti;
                offerVC.questionTypeArr = cjwtQuestionTypeArr;
            }else{
                offerVC.info = nil;
            }
            [self.navigationController pushViewController:offerVC animated:YES];

        }
            break;
        case 6:
        {
            onlineView = [[OnLineOrder alloc] init];
            [self handleOnLineOrer:onlineView];
            [self.view addSubview:onlineView];
//            if (![mainModel.zaixianyuyue isEqual:[NSNull null]]) {
//               
//            }else{
//               [SVProgressHUD svprogressHUDWithString:@"敬请期待"];
//            }
        }
            break;
        case 7:
        {
            IWantOfferViewController *offerVC = [[IWantOfferViewController alloc] init];

            if (![mainModel.woyaobaojia isEqual:[NSNull null]]) {
                offerVC.info = mainModel.woyaobaojia;
            }else{
                offerVC.info = nil;
            }
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
                WebViewController *linbaozhuangVC = [[WebViewController alloc] init];
                linbaozhuangVC.url = [NSString stringWithFormat:@"%@%@",URL_TEST,LINBAOZHUANG_HTML];
                linbaozhuangVC.titleString = @"拎包装";
                if (![mainModel.linbaozhuang isEqual:[NSNull null]]) {
                    linbaozhuangVC.info = mainModel.linbaozhuang;
                }else{
                    linbaozhuangVC.info = nil;
                }
                [self.navigationController pushViewController:linbaozhuangVC animated:YES];
            }
                break;
            case ReusableTypeLinBaoZhuangPLUS:
            {
                LinbaozhuangPlusViewController *linbaozhuangVC = [[LinbaozhuangPlusViewController alloc] init];

                if (![mainModel.linbaozhuangPLUS isEqual:[NSNull null]]) {
                    linbaozhuangVC.info = mainModel.linbaozhuangPLUS;
                }else{
                   linbaozhuangVC.info = nil;
                }
                [self.navigationController pushViewController:linbaozhuangVC animated:YES];
            }
                break;
            case ReusableTypeZunXiangJia:
            {
                WebViewController *zunXiangJiaVC = [[WebViewController alloc] init];
                zunXiangJiaVC.titleString = @"尊享家";
                zunXiangJiaVC.url = [NSString stringWithFormat:@"%@%@",URL_TEST,ZUNXIANGJIA_HTML];

                if (![mainModel.zunxiangjia isEqual:[NSNull null]]) {
                    zunXiangJiaVC.info = mainModel.zunxiangjia;

                }else{
                    zunXiangJiaVC.info = nil;
                }
                [self.navigationController pushViewController:zunXiangJiaVC animated:YES];
            }
                break;
            case ReusableTypeHaiKuan:
            {
                HopShopingViewController *hopVC = [[HopShopingViewController alloc] init];

                if (![mainModel.haikuan isEqual:[NSNull null]]) {
                    hopVC.info = mainModel.haikuan;
                }else{
                    hopVC.info = nil;
                }
                [self.navigationController pushViewController:hopVC animated:YES];

            }
            break;
            default:
                break;
        }
    }];
}


#pragma mark - <SDCycleScrollViewDelegate>
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;
{
    NSLog(@" 选择了第%ld张图片", (long)index);
    if (![mainModel.advs isEqual:[NSNull null]]) {
        NSArray *linkidArr = [NSArray arrayWithArray:mainModel.advs];
        NSString *linkStr = [NSString stringWithFormat:@"%@",linkidArr[index][@"link_id"]];
        WebViewController *webViewVC = [[WebViewController alloc] init];
        webViewVC.url = linkStr;
        webViewVC.titleString = linkidArr[index][@"title"];
        [self.navigationController pushViewController:webViewVC animated:YES];
    }

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
    sender.selected = !sender.selected;
    if (sender.selected) {
        _aboutsumenubg.hidden = NO;
    }else{
        _aboutsumenubg.hidden = YES;
    }
}

- (void)showAboutUsOrentErpriseDynamicBtn:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"企业动态"]) {
        ErpriseDynamicViewController *erpriseDynamicVC = [[ErpriseDynamicViewController alloc] init];
        erpriseDynamicVC.info = mainModel.qiyedongtai;
        [self.navigationController pushViewController:erpriseDynamicVC animated:YES];
    }else{
        AboutUsViewController *aboutUsVC = [[AboutUsViewController alloc] init];
        aboutUsVC.info = mainModel.aboutus;
        [self.navigationController pushViewController:aboutUsVC animated:YES];
    }
}


- (void)handleOnLineOrer:(OnLineOrder *)order
{
    [order handleButton:^(NSInteger tag) {
        switch (tag) {
            case OnLineOrderTel:
            {
                NSLog(@"打电话啊");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否拨打4008-122-100" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定 ", nil];
                alert.delegate = self;
                [alert show];
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
                WebViewController *onLinePopViewVC = [[WebViewController alloc] init];
                onLinePopViewVC.url = [UserInfo shareUserInfo].onLineContractURL;//ZAIXIANYUYUE_HTML
                onLinePopViewVC.titleString = @"在线咨询";
                [self.navigationController pushViewController:onLinePopViewVC animated:YES];
            }
                break;
            default:
                break;
        }
        [onlineView removeFromSuperview];
    }];
}

#pragma mark  <UIAlertViewDelegate>
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (buttonIndex == 0) {
        [alertView removeFromSuperview];
    }else{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:4008122100"]];
    }
}


#pragma notificatio  定位成功后进行请求 重置定位城市 resetCityName
- (void)resetCityNameAndRefreshUserInterface:(NSNotification *)notification
{
    if (notification.object == nil) {
        //定位失败
        _citiyName.text = @"定位中";
        
        MainViewModle *mainViewModel = [[MainViewModle alloc] init];
        [mainViewModel getMianVCDataWithType:4 cityID:[UserInfo shareUserInfo].cityID];
        [mainViewModel setBlockWithReturnBlock:^(id data) {
            mainModel = data;
            [self refreshUI:mainModel];
        } WithErrorBlock:^(id errorCode) {
            
        } WithFailureBlock:^{
            
        }];
 
    }else{
        
        //定位成功
        _citiyName.text = notification.object;
        
        MainViewModle *mainViewModel = [[MainViewModle alloc] init];
        [mainViewModel getMianVCDataWithType:4 cityID:[UserInfo shareUserInfo].cityID];
        [mainViewModel setBlockWithReturnBlock:^(id data) {
            mainModel = data;
            [self refreshUI:mainModel];
        } WithErrorBlock:^(id errorCode) {
            
        } WithFailureBlock:^{
            
        }];

    }
    
    [_collectionView reloadData];
    
    [self inAdvanceRequestForUserforData];
}

/**
 *  提前请求-----------获取所在城市的咨询链接  常见问题的问答分类ID
 */
- (void)inAdvanceRequestForUserforData
{
    NSString *cityid = [NSString stringWithFormat:@"%ld",(long)[UserInfo shareUserInfo].cityID];
    //获取所在城市咨询链接
    NSMutableDictionary *cityLinkDidc = [NSMutableDictionary dictionary];
    [cityLinkDidc setObject:@"5" forKey:@"type"];
    [cityLinkDidc setObject:cityid forKey:@"id"];
    
    [NetWorking GetRequeastWithURL:BASE_URL paramDic:cityLinkDidc success:^(id data) {
        [UserInfo shareUserInfo].onLineContractURL = data[@"data"];
    } errorCode:^(id errorCode) {} fail:^{}];
    
    
    NSMutableDictionary *changjianWentiTypeDidc = [NSMutableDictionary dictionary];
    [changjianWentiTypeDidc setObject:@"6" forKey:@"type"];
    [changjianWentiTypeDidc setObject:cityid forKey:@"id"];
    
    [NetWorking GetRequeastWithURL:BASE_URL paramDic:changjianWentiTypeDidc success:^(id data) {
        cjwtQuestionTypeArr = [NSArray arrayWithArray:data[@"data"]];
        
    } errorCode:^(id errorCode) {} fail:^{}];
    
}

- (void)refreshUI:(MainModel *)model
{
    [self.collectionView reloadData];
     [self.collectionView.mj_header endRefreshing];
}


- (void)nn
{
    [(UILabel *)[self.view viewWithTag:111111] removeFromSuperview];
}

@end
