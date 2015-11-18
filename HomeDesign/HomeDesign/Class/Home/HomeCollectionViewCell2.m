//
//  HomeCollectionViewCell2.m
//  HomeDesign
//
//  Created by apple on 15/11/13.
//  Copyright (c) 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "HomeCollectionViewCell2.h"

@implementation HomeCollectionViewCell2

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor cyanColor];
       
        _itemImage = [[UIImageView alloc] initWithFrame:RECT(5, 2, frame.size.width - 10, 50)];
        _itemImage.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:_itemImage];
        
        _titilelab = [[UILabel alloc] initWithFrame:RECT(0, frame.size.height - 20, frame.size.width, 20)];
        _titilelab.font =FONT(12);
        _titilelab.textColor = [UIColor whiteColor];
        _titilelab.textAlignment = NSTextAlignmentCenter;
        _titilelab.text = @"3D体验";
        [self.contentView addSubview:_titilelab];
        
    }
    return self;
}

@end
