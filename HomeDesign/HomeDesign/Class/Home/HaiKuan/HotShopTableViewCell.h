//
//  HotShopTableViewCell.h
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/9.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HaikuanModel.h"

@interface HotShopTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *shopName;
@property (nonatomic, strong) UIImageView *shopImage;
@property (nonatomic, strong) UILabel *shopDiscreptionLabel;
@property (nonatomic, strong) UIView *discreptionBg;
@property (nonatomic, strong) UIImageView *flagbg;

- (void)setCellInfo:(HaikuanModel *)model;

@end
