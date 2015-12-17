//
//  MainHeaderReusableView.h
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/12.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXFSegmentViwe.h"

@protocol ReusableViewDelege <NSObject>

- (void)subViewDelegateMethods;

@end

@interface MainHeaderReusableView : UICollectionReusableView

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


@property (nonatomic, copy) BlockBtnClick button;
- (void)handleButton:(BlockBtnClick)block;

@property (nonatomic, assign) id <ReusableViewDelege> delegate;

@end
