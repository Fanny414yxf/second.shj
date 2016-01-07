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
#import "GuideViewController.h"
#import "CitiPositioningViewController.h"
#import "AboutUsViewController.h"
#import "ErpriseDynamicViewController.h"
#import "LinbaozhuangPlusViewController.h"
#import "IWantOfferViewController.h"
#import "ConstructionSiteViewController.h"
#import "CommonProblemsViewController.h"
#import "QuanQiuGou/GlobalViewController.h"
#import "HopShopingViewController.h"
#import "FastAppointmentViewController.h"

//view
#import "OnLineOrder.h"
#import "SDCycleScrollView.h"


#import "MainViewModle.h"
#import "MainModel.h"

static UIWindow * __guideWindow = nil;

@interface MainViewController ()<UICollectionViewDataSource, UICollectionViewDelegate,GSKSectionBackgroundFlowLayoutDelegate, SDCycleScrollViewDelegate, UIAlertViewDelegate, GuideViewControllerDelegate>
{
    GuideViewController *guideVC;//引导页
    OnLineOrder *onlineView;     //在线预约
    NSArray *itemNameAndImages;  //collectionview cell datasource
    MainModel *mainModel;        //
    UIButton *aboutusImage;      //关于我们icom
    UIImageView *new_qydtImage;  //企业动态新消息
    UIImageView *new_abus;       //关于我们新消息
    NSArray *bannerUrlStrArr;    //主页banner
    NSArray *cjwtQuestionTypeArr;//常见问题问题分类
    MainHeaderReusableView *reusableView;//collectionview ReusableView
    
    
    BOOL timeEnd;//嗨款倒计时
    NSString *timeStr;
    NSString *end;
    NSInteger nowLong;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) UILabel *citiyName;
@property (nonatomic, strong) UIButton *aboutUsBtn;
@property (nonatomic, strong) UIImageView *aboutsumenubg;
@property (nonatomic, strong) NSTimer *timer;//嗨款倒计时 timer

@end

@implementation MainViewController


- (void)dealloc
{
    [self removeObserver:self forKeyPath:NOTIFICATION_CITY];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [NetWorking netWorkReachability];
    self.view.backgroundColor = [UIColor whiteColor];
    _citiyName.text = @"定位";
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
    self.backimage.hidden = YES;  //主页返回按钮隐藏
    
   //是否显示引导页
    NSString * currentStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"versions"];
    NSString *versionid = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    if (!currentStr  || ![currentStr isEqualToString:versionid]) {
        //当前版本号
        NSDictionary * infoDic = [[NSBundle mainBundle] infoDictionary];
        NSString * current_version = [infoDic objectForKey:@"CFBundleShortVersionString"];
        [[NSUserDefaults standardUserDefaults] setObject:current_version forKey:@"versions"];
        guideVC = [[GuideViewController alloc] init];
        guideVC.delegate = self;
        UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [window makeKeyAndVisible];
        window.hidden = NO;
        [window addSubview:guideVC.view];
        
        __guideWindow = window;
    }

    //定位之后重新请求数据 重置UI
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetCityNameAndRefreshUserInterface:) name:NOTIFICATION_CITY object:nil];
    
    
    [self userInterface];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI
- (void)userInterface{
    //banner datasource
    bannerUrlStrArr = @[@{@"title" : @"原装正品", @"url" : H_YZZP},
                        @{@"title" : @"增项全免", @"url" : H_ZXQM},
                        @{@"title" : @"延期赔付", @"url" : H_YQPF},
                        @{@"title" : @"环保承诺", @"url" : H_YQPF}];

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
    [_collectionView.mj_header beginRefreshing];

    //城市按钮
    [self.navigationBarView addSubview:[self cityBtn]];
    //关于我们
    [self.navigationBarView addSubview:[self aboutusBtn]];
    
    //关于我们弹出View;  默认隐藏
    _aboutsumenubg = [[UIImageView alloc] initWithFrame:RECT(SCREEN_WIDTH - 75, 58, 70, 75)];
    _aboutsumenubg.image = [UIImage imageNamed:@"home_abus2"];
    _aboutsumenubg.userInteractionEnabled = YES;
    _aboutsumenubg.hidden = YES;
    [self.view addSubview:_aboutsumenubg];
    
    //企业动态
    UIButton *enterpriseDynamicBtn = [[UIButton alloc] initWithFrame:RECT(0, 10, SIZE_W(_aboutsumenubg), 30)];
    enterpriseDynamicBtn.titleLabel.font = FONT(12);
    [enterpriseDynamicBtn setTitle:@"企业动态" forState:UIControlStateNormal];
    [enterpriseDynamicBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [enterpriseDynamicBtn addTarget:self action:@selector(showAboutUsOrentErpriseDynamicBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_aboutsumenubg addSubview:enterpriseDynamicBtn];
    
    //企业动态红点
    new_qydtImage = [[UIImageView alloc] initWithFrame:RECT(SIZE_W(enterpriseDynamicBtn) - 10, 5, 5, 5)];
    new_qydtImage.image = [UIImage imageNamed:@"icon_menu_notice_small"];
    new_qydtImage.hidden = aboutusImage.selected;
    [enterpriseDynamicBtn addSubview:new_qydtImage];
    
    //关于我们线
    UIView *line = [[UIView alloc] initWithFrame:RECT(10, 41, 50, 1)];
    line.backgroundColor = [UIColor colorWithHex:0.3 alpha:0.5];
    [_aboutsumenubg addSubview:line];
    
    //关于我们
    UIButton *aboutusBtn = [[UIButton alloc] initWithFrame:RECT(0, 45, SIZE_W(_aboutsumenubg), 30)];
    aboutusBtn.titleLabel.font = FONT(12);
    [aboutusBtn setTitle:@"关于我们" forState:UIControlStateNormal];
    [aboutusBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [aboutusBtn addTarget:self action:@selector(showAboutUsOrentErpriseDynamicBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_aboutsumenubg addSubview:aboutusBtn];
    
}

//城市定位
- (UIView *)cityBtn{
    UIView *city = [[UIView alloc] initWithFrame:RECT(10, 00, 60, 60)];
    city.userInteractionEnabled = YES;
    UIImageView *mapImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"city_map"]];
    mapImage.frame = RECT(0, 37, 10, 15);
    mapImage.contentMode = UIViewContentModeScaleAspectFit;
    [city addSubview:mapImage];
    _citiyName = [[UILabel alloc] initWithFrame:RECT(ORIGIN_X_ADD_SIZE_W(mapImage)+3, 35, 50, 20) textAlignment:NSTextAlignmentLeft font:FONT(12) textColor:[UIColor grayColor]];
    _citiyName.text = @"定位";
    [city addSubview:_citiyName];
    
    UIButton *cityBtn = [[UIButton alloc] initWithFrame:RECT(0, 0, 60, 60)];
    [cityBtn addTarget:self action:@selector(handldCityBtn:) forControlEvents:UIControlEventTouchUpInside];
    [city addSubview:cityBtn];
    return city;
}

//关于我们
- (UIView *)aboutusBtn{
    UIView *aboutus = [[UIView alloc] initWithFrame:RECT(SCREEN_WIDTH - 60, 0, 60, 60)];
    aboutus.userInteractionEnabled = YES;
    
    aboutusImage = [[UIButton alloc] initWithFrame:RECT(27, 25, 25, 30)];
    aboutusImage.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [aboutusImage setImage:[UIImage imageNamed:@"home_aboutus_no"] forState:UIControlStateNormal];
    [aboutusImage setImage:[UIImage imageNamed:@"home_aboutus_new"] forState:UIControlStateSelected];
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
    if ([NetWorking netWorkReachability]) {
        [_collectionView.mj_header endRefreshing];
        return;
    }

    //刷新时关掉timer， 刷新完成 请求成功 重置数据，timer重新启动
    [reusableView.timer invalidate];
    
    MainViewModle *mainViewModel = [[MainViewModle alloc] init];
    [mainViewModel getMianVCDataWithType:4 cityID:[UserInfo shareUserInfo].cityID];//[UserInfo shareUserInfo].cityID
    [mainViewModel setBlockWithReturnBlock:^(id data) {
        [_collectionView.mj_header endRefreshing];
        mainModel = data;
        [self refreshUI:mainModel];
        [self countDownTimeWithModel:mainModel];
    } WithErrorBlock:^(id errorCode) {
        [_collectionView.mj_header endRefreshing];
        _citiyName.text = @"定位";
    } WithFailureBlock:^{
        [_collectionView.mj_header endRefreshing];
        _citiyName.text = @"定位";
        [SVProgressHUD svprogressHUDWithString:@"请检查网络连接"];
    }];
    
    [self inAdvanceRequestForUserforData];
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
    if (isSizeOf_4_0 || isSizeOf_3_5) {
        return CGSizeMake(SCREEN_WIDTH / 4.0, SCREEN_SCALE_HEIGHT(75));
    }else if (isSizeOf_4_7){
       return CGSizeMake(SCREEN_WIDTH / 4.0, SCREEN_SCALE_HEIGHT(88));
    }else{
        return CGSizeMake(SCREEN_WIDTH / 4.0, SCREEN_SCALE_HEIGHT(100));
    }
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
    reusableView.adScorll.delegate = self;
    reusableView.adScorll.autoScrollTimeInterval = 5;
    reusableView.adScorll.placeholderImage = [UIImage imageNamed:@"defaultimage"];
    reusableView.adScorll.hidesForSinglePage = NO;
    reusableView.adScorll.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    reusableView.adScorll.dotColor = [RGBColor colorWithHexString:MAINCOLOR_GREEN];
    [reusableView.adCycleScrollView handleButtonAction:^(NSInteger tag) {
        //banner的点击
        WebViewController *webVC = [[WebViewController alloc] init];
        webVC.url = [NSString stringWithFormat:@"%@%@", ADVIMAGE_URL, bannerUrlStrArr[tag - 100][@"url"]];
        webVC.titleString = [NSString stringWithFormat:@"%@", bannerUrlStrArr[tag - 100][@"title"]];
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
    CGSize size;
    if (isSizeOf_3_5) {
        size = CGSizeMake(SCREEN_WIDTH, SCREEN_SCALE_HEIGHT(450));
    }else if (isSizeOf_4_0) {
        size = CGSizeMake(SCREEN_WIDTH, SCREEN_SCALE_HEIGHT(440));
    }else if (isSizeOf_4_7){
        size = CGSizeMake(SCREEN_WIDTH, SCREEN_SCALE_HEIGHT(420));
    }else{
        size = CGSizeMake(SCREEN_WIDTH, SCREEN_SCALE_HEIGHT(400));
    }
    return size;
}

//****************collectionView事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            WebViewController *sanDtiyanVC = [[WebViewController alloc] init];
            if (mainModel.threeD != [NSNull null]) {
                sanDtiyanVC.url = [NSString stringWithFormat:@"%@%@",ADVIMAGE_URL, mainModel.threeD[@"link_id"]];
            }else{
                sanDtiyanVC.url = @"";
            }
            sanDtiyanVC.info = mainModel.threeD;
            sanDtiyanVC.titleString = @"3D体验";
            [self.navigationController pushViewController:sanDtiyanVC animated:YES];
        }
            break;
        case 1:
        {
            WebViewController *debiaogongyiVC = [[WebViewController alloc] init];
            if (mainModel.debiaogongyi != [NSNull null]) {
                debiaogongyiVC.url = [NSString stringWithFormat:@"%@%@",ADVIMAGE_URL, mainModel.debiaogongyi[@"link_id"]];
            }else{
                debiaogongyiVC.url = @"";
            }
            debiaogongyiVC.info = mainModel.debiaogongyi;
            debiaogongyiVC.titleString = @"德标工艺";
            [self.navigationController pushViewController:debiaogongyiVC animated:YES];
        }
            break;
        case 2:
        {
            WebViewController *sanDtiyanVC = [[WebViewController alloc] init];
            sanDtiyanVC.url = [NSString stringWithFormat:@"%@%@",ADVIMAGE_URL, HOME_GLOBAL];
            sanDtiyanVC.info = mainModel.threeD;
            sanDtiyanVC.titleString = @"全球购";
            [self.navigationController pushViewController:sanDtiyanVC animated:YES];
        }
            break;
        case 3:
        {
            ConstructionSiteViewController *constructionSiteVC = [[ConstructionSiteViewController alloc] init];
            [self.navigationController pushViewController:constructionSiteVC animated:YES];
            if (mainModel.zaijiangongcheng != [NSNull null]) {
                constructionSiteVC.info = mainModel.zaijiangongcheng;
            }else{
                constructionSiteVC.info = nil;
            }
        }
            break;
        case 4:{
            if (mainModel.woyaoyouhui != [NSNull null]) {
                WebViewController *debiaogongyiVC = [[WebViewController alloc] init];
                debiaogongyiVC.url = [NSString stringWithFormat:@"%@%@",ADVIMAGE_URL, mainModel.woyaoyouhui[@"link_id"]];
                debiaogongyiVC.info = mainModel.woyaoyouhui;
                debiaogongyiVC.titleString = @"我要优惠";
                [self.navigationController pushViewController:debiaogongyiVC animated:YES];

            }else{
                [SVProgressHUD svprogressHUDWithString:@"敬请期待"];
            }
        }
            break;
        case 5:
        {
            CommonProblemsViewController *offerVC = [[CommonProblemsViewController alloc] init];

            if (mainModel.changjianwenti != [NSNull null]) {
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
            if (mainModel.zaixianyuyue != [NSNull null]) {
                onlineView.phoneNumber = [NSString stringWithFormat:@"%@",mainModel.zaixianyuyue[@"more"][@"call_number"]];
            }else{
                onlineView.phoneNumber = @"4008-122-100";
            }
            [self handleOnLineOrer:onlineView];
            [self.view addSubview:onlineView];
        }
            break;
        case 7:
        {
            IWantOfferViewController *offerVC = [[IWantOfferViewController alloc] init];

            if (mainModel.woyaobaojia != [NSNull null]) {
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
            case ReusableTypeLinBaoZhuang:
            {
                WebViewController *linbaozhuangVC = [[WebViewController alloc] init];
                if (mainModel.linbaozhuang != [NSNull null]) {
                   linbaozhuangVC.url = [NSString stringWithFormat:@"%@%@",ADVIMAGE_URL,mainModel.linbaozhuang[@"link_id"]];
                }else{
                    linbaozhuangVC.url = @"";
                }
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
                if (mainModel.zunxiangjia != [NSNull null]) {
                    zunXiangJiaVC.url = [NSString stringWithFormat:@"%@%@",ADVIMAGE_URL,mainModel.zunxiangjia[@"link_id"]];
                }else{
                    zunXiangJiaVC.url = @"";
                }

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
    if (![mainModel.advs isEqual:[NSNull null]] && mainModel.advs != nil) {
        NSArray *linkidArr = [NSArray arrayWithArray:mainModel.advs];
        NSString *linkStr ;
        linkStr = [NSString stringWithFormat:@"%@",linkidArr[index][@"link_id"]];
        if (![linkStr hasPrefix:@"http"]) {
            linkStr = [NSString stringWithFormat:@"%@%@", ADVIMAGE_URL, linkidArr[index][@"link_id"]];
        }
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


#pragma mark - <GuideViewControllerDelegate>
- (void)removeGuideWindow
{
    __guideWindow.hidden = YES;
    __guideWindow = nil;
}

- (void)pageControlSetPage:(UIPageControl *)control{
    guideVC.scrollView.contentOffset = CGPointMake((control.currentPage) * SCREEN_WIDTH, 0);
}


#pragma mark  <UIAlertViewDelegate>
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (buttonIndex == 0) {
        [alertView removeFromSuperview];
    }else{
        NSString *phoneNumber = [NSString stringWithFormat:@"%@",mainModel.zaixianyuyue[@"more"][@"call_number"]];
        if (([phoneNumber isEqual:@"(null)"]) || (phoneNumber == nil)) {
            phoneNumber = @"4008122100";
        }
        [UserInfo shareUserInfo].phoneNumber = phoneNumber;
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNumber]]];
    }
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

//关于我们 或 企业动态
- (void)showAboutUsOrentErpriseDynamicBtn:(UIButton *)sender
{
    aboutusImage.selected = NO;
    new_qydtImage.hidden = YES;
    [[NSUserDefaults standardUserDefaults] setObject:mainModel.news[@"id"] forKey:NEWS];
    
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



//在线预约
- (void)handleOnLineOrer:(OnLineOrder *)order
{
    NSString *phoneNumber = [UserInfo shareUserInfo].phoneNumber;
    if (([phoneNumber isEqual:@"(null)"]) || (phoneNumber == nil)) {
        phoneNumber = @"4008-122-100";
    }
       [order handleButton:^(NSInteger tag) {
        switch (tag) {
            case OnLineOrderTel:
            {
                NSString *tip = [NSString stringWithFormat:@"是否拨打%@", phoneNumber];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:tip delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定 ", nil];
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
                onLinePopViewVC.url = [UserInfo shareUserInfo].zaixianzixunLink;
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


#pragma notificatio  定位成功后进行请求 重置定位城市 resetCityName
- (void)resetCityNameAndRefreshUserInterface:(NSNotification *)notification
{
    if (notification.object == nil) {
        //定位失败
        _citiyName.text = @"定位";
        if ([NetWorking netWorkReachability]) {
            [_collectionView.mj_header endRefreshing];
            [SVProgressHUD svprogressHUDWithString:@"请检查网络连接"];
            return;
        }
        
        MainViewModle *mainViewModel = [[MainViewModle alloc] init];
        [mainViewModel getMianVCDataWithType:4 cityID:[UserInfo shareUserInfo].cityID];
        [mainViewModel setBlockWithReturnBlock:^(id data) {
            mainModel = data;
            [self refreshUI:mainModel];
            [self countDownTimeWithModel:mainModel];
        } WithErrorBlock:^(id errorCode) {
            [self.collectionView.mj_header endRefreshing];
        } WithFailureBlock:^{
            [self.collectionView.mj_header endRefreshing];
            [SVProgressHUD svprogressHUDWithString:@"请检查网络连接"];
        }];
 
    }else{
        
        //定位成功
        _citiyName.text = notification.object;
        if ([NetWorking netWorkReachability]) {
            [_collectionView.mj_header endRefreshing];
            [SVProgressHUD svprogressHUDWithString:@"请检查网络连接"];
            return;
        }
        
        MainViewModle *mainViewModel = [[MainViewModle alloc] init];
        [mainViewModel getMianVCDataWithType:4 cityID:[UserInfo shareUserInfo].cityID];
        [mainViewModel setBlockWithReturnBlock:^(id data) {
            mainModel = data;
            [self refreshUI:mainModel];
            [self countDownTimeWithModel:mainModel];
        } WithErrorBlock:^(id errorCode) {
            [self.collectionView.mj_header endRefreshing];
        } WithFailureBlock:^{
            [self.collectionView.mj_header endRefreshing];
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
        [UserInfo shareUserInfo].zaixianzixunLink = [NSString stringWithFormat:@"%@", data[@"data"]];
        
    } errorCode:^(id errorCode) {} fail:^{}];
    
    NSMutableDictionary *changjianWentiTypeDidc = [NSMutableDictionary dictionary];
    [changjianWentiTypeDidc setObject:@"6" forKey:@"type"];
    [changjianWentiTypeDidc setObject:cityid forKey:@"id"];
    
    [NetWorking GetRequeastWithURL:BASE_URL paramDic:changjianWentiTypeDidc success:^(id data) {
        cjwtQuestionTypeArr = [NSArray arrayWithArray:data[@"data"]];
        
    } errorCode:^(id errorCode) {} fail:^{}];
    
}

/**
 *  定位后重置UI
 *
 */
- (void)refreshUI:(MainModel *)model
{
    
    [_collectionView reloadData];
    
     [self.collectionView.mj_header endRefreshing];
    
    NSString *newstring = [[NSUserDefaults standardUserDefaults] objectForKey:NEWS];
    BOOL news;
    if (([mainModel.news[@"id"] integerValue] > 0 && ![mainModel.news[@"id"] isEqualToString:newstring]) || (newstring == nil) ) {
        news = YES;
    }else{
        news = NO;
    }
    aboutusImage.selected = news;
    new_qydtImage.hidden = !news;
    
    NSString *phoneNumber;
    NSString *zaixinayuyueString;
    phoneNumber = [NSString stringWithFormat:@"%@",mainModel.zaixianyuyue[@"more"][@"call_number"]];
    zaixinayuyueString = [NSString stringWithFormat:@"%@", mainModel.zaixianyuyue[@"more"][@"online"]];
    if ((mainModel.zaixianyuyue != [NSNull null]) && (mainModel.zaixianyuyue != nil)) {
        if (([phoneNumber length] < 11) && ![phoneNumber isEqual:@"(null)"]) {
            NSString *pre = [phoneNumber substringToIndex:4];
            NSString *zhong = [phoneNumber substringWithRange:NSMakeRange(4, 3)];
            NSString *wei = [phoneNumber substringFromIndex:[phoneNumber length] - 3];
            phoneNumber = [NSString stringWithFormat:@"%@-%@-%@",pre, zhong, wei];
        }
    }else{
        phoneNumber = @"4008122100";
        zaixinayuyueString = @"http://www17.53kf.com/webCompany.php?arg=9006234&style=2";
    }
    [UserInfo shareUserInfo].phoneNumber = phoneNumber;
    [UserInfo shareUserInfo].zaixianzixunLink = zaixinayuyueString;
}


- (void)nn
{
    [(UILabel *)[self.view viewWithTag:111111] removeFromSuperview];
}


- (void)countDownTimeWithModel:(MainModel *)model
{
    if ([model.haikuan isEqual:[NSNull null]] || [model.haikuan isEqual:nil]) {
        timeEnd = YES;
        [_timer invalidate];
        
    }else{
        NSDictionary *dic = (NSDictionary *)model.haikuan;
        NSString *count = dic[@"count"];
       end = [NSString stringWithFormat:@"%d",[dic[@"endtime"] integerValue]];
        nowLong = [end integerValue];
        timeStr = [TimeFormatter longTimeLongString:end];
        if ([end integerValue] > 0) {
            timeEnd = NO;
            
            _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(intervalFromLastDate:toTheDate:) userInfo:@{@"key":@"value"} repeats:YES];
            
        }else{
            timeEnd = YES;
            [_timer invalidate];
            [UserInfo shareUserInfo].haikuan_day = @"00";
            [UserInfo shareUserInfo].haikuan_hour = @"00";
            [UserInfo shareUserInfo].haikuan_min = @"00";
            [UserInfo shareUserInfo].haikuan_second = @"00";
            return;
        }
   }
}


#pragma mark - 嗨款倒计时
- (NSString *)intervalFromLastDate:(NSString *)dateString1  toTheDate:(NSString *) dateString2
{
    if (timeEnd) {
        
        [_timer invalidate];
    }
    
    NSString *nowtime = [TimeFormatter dateFormatterWithDate_yyyyMMdd_HHmmss:[NSDate date]];
    NSArray *timeArray1=[nowtime componentsSeparatedByString:@"."];
    dateString1=[timeArray1 objectAtIndex:0];
    
    NSArray *timeArray2=[timeStr componentsSeparatedByString:@"."];
    dateString2=[timeArray2 objectAtIndex:0];
    
    //    NSLog(@"%@.....%@",dateString1,dateString2);
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *d1=[date dateFromString:dateString1];
    
    NSTimeInterval late1=[d1 timeIntervalSince1970]*1;
    
    NSDate *d2=[date dateFromString:dateString2];
    
    NSTimeInterval late2=[d2 timeIntervalSince1970]*1;
    
    NSTimeInterval cha=late2-late1;
    
    NSString *timeString=@"";
    NSString *day=@"";
    NSString *house=@"";
    NSString *min=@"";
    NSString *sen=@"";
    
    
    sen = [NSString stringWithFormat:@"%d", (int)cha%60];
    //        min = [min substringToIndex:min.length-7];
    //    秒
    sen=[NSString stringWithFormat:@"%@", sen];
    if ([sen integerValue] < 10) {
        sen = [NSString stringWithFormat:@"0%@",sen];
    }
    
    min = [NSString stringWithFormat:@"%d", (int)cha/60%60];
    //        min = [min substringToIndex:min.length-7];
    //    分
    min=[NSString stringWithFormat:@"%@", min];
    if ([min integerValue] < 10) {
        min = [NSString stringWithFormat:@"0%@",min];
    }
    
    
    NSInteger minSec = 60;
    NSInteger hoursSec = minSec * 60;
    NSInteger daySec = hoursSec * 24;
    NSInteger countDays = nowLong / daySec ;
    NSInteger countHours = (nowLong % daySec) / hoursSec;
    
    //自己算   时
    house = [NSString stringWithFormat:@"%ld", (long)countHours];
    if (countHours < 10) {
        house = [NSString stringWithFormat:@"0%ld", (long)countHours];
    }
    //自己算   天
    day = [NSString stringWithFormat:@"%ld", (long)countDays];
    if (countDays < 10) {
        day = [NSString stringWithFormat:@"0%ld", (long)countDays];
    }
    
    if (countDays != 0  || [sen integerValue] != 0  || [min integerValue] != 0 || [house integerValue] != 0) {
        [UserInfo shareUserInfo].haikuan_day = [NSString stringWithFormat:@"%@", day];
        if (countDays > 99) {
            [UserInfo shareUserInfo].haikuan_day = @"99";
        }
        [UserInfo shareUserInfo].haikuan_hour = [NSString stringWithFormat:@"%@", house];
        
        [UserInfo shareUserInfo].haikuan_min = [NSString stringWithFormat:@"%@", min];
        
        [UserInfo shareUserInfo].haikuan_second = [NSString stringWithFormat:@"%@", sen];
        
    }else{
        [_timer invalidate];
        [UserInfo shareUserInfo].haikuan_day = @"00";
        [UserInfo shareUserInfo].haikuan_hour = @"00";
        [UserInfo shareUserInfo].haikuan_min = @"00";
        [UserInfo shareUserInfo].haikuan_second = @"00";
        
    }
    
    
     nowLong --;
    //    LxPrintf(@"%ld-----%@-----%@-----%@", (long)day, house, min, sen);
    timeString=[NSString stringWithFormat:@"%@:%@:%@",house,min,sen];
    
    return timeString;
}


@end
