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
        self.contentView.layer.cornerRadius = 5;
        self.contentView.backgroundColor = [RGBColor colorWithHexString:@"#3c3c3c"];
        _itemImage = [[UIImageView alloc] initWithFrame:RECT((frame.size.width - 20)/4, 2, frame.size.width - 20, frame.size.width - 20)];
        _itemImage.center = CGPointMake(frame.size.width / 2, (2 + frame.size.width - 20)/2);
        _itemImage.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_itemImage];
        [_itemImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY).with.offset(-7);
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.height.and.width.mas_equalTo(SCREEN_SCALE_WIDTH(50));
        }];
        
        _titilelab = [[UILabel alloc] initWithFrame:RECT(0, frame.size.height - 30, frame.size.width, SCREEN_SCALE_HEIGHT(20))];
        _titilelab.font =FONT(SCREEN_SCALE_WIDTH(13));
        _titilelab.textColor = [UIColor whiteColor];
        _titilelab.textAlignment = NSTextAlignmentCenter;
        _titilelab.text = @"3D体验";
        [self.contentView addSubview:_titilelab];
    }
    return self;
}

- (void)setCellInfo:(NSDictionary *)info;
{
    _itemImage.image = [UIImage imageNamed:info[@"image"]];
    _titilelab.text = [NSString stringWithFormat:@"%@", info[@"title"]];
}

@end
