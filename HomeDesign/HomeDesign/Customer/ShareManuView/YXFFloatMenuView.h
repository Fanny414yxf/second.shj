//
//  YXFFloatMenuView.h
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/7.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalModel.h"


@interface YXFFloatMenuView : UIView

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, copy) BlockBtnClick clickItem;

- (void)clickedItemsAction:(BlockBtnClick)block;

@end
