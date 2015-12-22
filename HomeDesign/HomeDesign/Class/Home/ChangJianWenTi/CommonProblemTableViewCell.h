//
//  CommonProblemTableViewCell.h
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/7.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChangjianWentiModel.h"


@interface CommonProblemTableViewCell : UITableViewCell

@property (nonatomic, assign) CGFloat cellHeight;


- (void)setCellInfo:(ChangjianWentiModel *)info;

@end
