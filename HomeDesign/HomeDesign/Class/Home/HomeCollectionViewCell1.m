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
                
        _imageView = [[UIImageView alloc] initWithFrame:RECT(0, 0, frame.size.height - 10, frame.size.height - 10)];
        _imageView.center = self.contentView.center;
        [self.contentView addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top);
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-5);
            make.left.equalTo(self.contentView.mas_left).with.offset(30);
            make.right.equalTo(self.contentView.mas_right).with.offset(-30);
        }];
        
        _label = [[UILabel alloc] init];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = FONT(15);
        [_imageView addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_imageView.mas_left);
            make.right.equalTo(_imageView.mas_right);
            make.top.equalTo(_imageView.mas_centerY).with.offset(-8);
            make.height.mas_equalTo(30);
        }];
        
        _detail = [[UILabel alloc]init];
        _detail.textAlignment = NSTextAlignmentCenter;
        _detail.font = FONT(10);
        _label.textColor = [UIColor orangeColor];
        [_imageView addSubview:_detail];
        [_detail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_imageView.mas_left);
            make.right.equalTo(_imageView.mas_right);
            make.top.equalTo(_imageView.mas_centerY).with.offset(15);
            make.height.mas_equalTo(20);
        }];
    
    }
    return self;
}

- (void)setCellInfo:(NSDictionary*)info;{
    _imageView.image = [UIImage imageNamed:info[@"image"]];
    _label.text = [NSString stringWithFormat:@"%@",info[@"title"]];
    _label.textColor = [UIColor whiteColor];
    _detail.text = [NSString stringWithFormat:@"%@", info[@"detaile"]];
}


@end
