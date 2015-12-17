//
//  OnLineOrder.h
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/7.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OnLineOrder : UIView

typedef NS_ENUM(NSInteger, OnLineOrderType) {
    OnLineOrderTel = 50,
    OnLineOrderOrder,
    OnLineOrderWeb
};

@property (nonatomic, copy) BlockBtnClick button;

- (void)handleButton:(BlockBtnClick)block;

@end
