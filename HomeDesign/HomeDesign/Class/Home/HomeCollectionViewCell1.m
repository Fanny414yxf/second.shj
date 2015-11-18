//
//  HomeCollectionViewCell1.m
//  HomeDesign
//
//  Created by apple on 15/11/13.
//  Copyright (c) 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "HomeCollectionViewCell1.h"

@implementation HomeCollectionViewCell1

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
      
        self.contentView.backgroundColor = [RGBColor colorWithHexString:@"#3c3c3c"];
        self.contentView.layer.cornerRadius = 10;
        
        _hotImage = [[UIImageView alloc] initWithFrame:RECT(frame.size.width - 20, 0, 20, 20)];
        _hotImage.image = [UIImage imageNamed:@""];
        [self.contentView addSubview:_hotImage];
        [_hotImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX);
        }];
        
        _imageView = [[UIImageView alloc] initWithFrame:RECT(0, 0, frame.size.height - 10, frame.size.height - 10)];
        _imageView.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:_imageView];
    }
    return self;
}

@end
