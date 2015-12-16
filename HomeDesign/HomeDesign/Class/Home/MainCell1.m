//
//  MainCell1.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/12.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "MainCell1.h"

@implementation MainCell1

- (void)setCellInfo:(NSDictionary *)info
{
    self.itemImageName.image = [UIImage imageNamed:info[@"image"]];
    self.itemName.text = [NSString stringWithFormat:@"%@", info[@"title"]];
}

- (void)awakeFromNib {
    // Initialization code
}

@end
