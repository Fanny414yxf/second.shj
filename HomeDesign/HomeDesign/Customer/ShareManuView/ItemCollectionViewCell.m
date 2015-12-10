//
//  ItemCollectionViewCell.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/7.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "ItemCollectionViewCell.h"

@implementation ItemCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:RECT(1, 1, SIZE_W(self) - 2, SIZE_H(self) - 2)];
        imageview.image = [UIImage imageNamed:@"quanqiugou_item2"];
        [self.contentView addSubview:imageview];
    }
    return self;
}


@end
