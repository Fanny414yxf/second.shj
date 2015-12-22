//
//  MainHeaderReusableView.h
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/12.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXFSegmentViwe.h"
#import "SDCycleScrollView.h"

@interface MainHeaderReusableView : UICollectionReusableView<YXFSegmentDelegate, YXFSegmentDataSource, SDCycleScrollViewDelegate>

typedef NS_ENUM(NSInteger, ReusableType) {
    ReusableTypeYuanZhuangZhengPin = 0,           //原装正品
    ReusableTypeZengXiangQuanMian,                //全项增免
    ReusableType0YanQi,                           //0延期
    ReusableTypeHuanBaoBuDaBiaoQuanETuiKuan,      //环保不达标全额退款
    ReusableTypeLinBaoZhuang,                     //拎包装
    ReusableTypeLinBaoZhuangPLUS,                 //林包装PLUS
    ReusableTypeZunXiangJia,                      //尊享家
    ReusableTypeHaiKuan                           //嗨款
};

@property (strong, nonatomic) IBOutlet YXFSegmentViwe *adCycleScrollView;
@property (strong, nonatomic) IBOutlet SDCycleScrollView *adScorll;

@property (nonatomic, copy) BlockBtnClick button;
- (void)handleButton:(BlockBtnClick)block;

@property (nonatomic, strong) NSString *remainingshopnuber;
@property (nonatomic, strong) NSString *h;
@property (nonatomic, strong) NSString *m;
@property (nonatomic, strong) NSString *s;

- (void)setReusableViewInfo:(MainModel *)info;

@property (strong, nonatomic) IBOutlet UILabel *remainingShop;//剩余   套
@property (strong, nonatomic) IBOutlet UILabel *countdown_h;//倒计时  时
@property (strong, nonatomic) IBOutlet UILabel *countdowm_m;//倒计时 秒
@property (strong, nonatomic) IBOutlet UILabel *countdown_s;//倒计时 秒

@end
