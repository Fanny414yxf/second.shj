//
//  ChooseProductCell.h
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/18.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductListMModel.h"


@interface ChooseProductCell : UITableViewCell

- (void)setCellInfo:(ProductListMModel *)info;

@property (nonatomic, copy) BlockBtnClick button;

- (void)handleShowDetailBtn:(BlockBtnClick)block;


@end
