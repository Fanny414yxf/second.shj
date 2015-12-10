//
//  ConstructionSiteCell.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/4.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "ConstructionSiteCell.h"

@interface ConstructionSiteCell ()
{
    CGFloat image_with;
    CGFloat image_height;
}

@property (nonatomic, strong) UILabel *discreptionLabel;//描述
@property (nonatomic, strong) UILabel *timeLabel;//时间
@property (nonatomic, strong) UIImageView *typebgimage;//类型背景
@property (nonatomic, strong) UILabel *typeLabel;//类型
@property (nonatomic, strong) UILabel *browseNumber;//浏览数量
@property (nonatomic, strong) UIImageView *image1;
@property (nonatomic, strong) UIImageView *image2;
@property (nonatomic, strong) UIImageView *image3;

@end

@implementation ConstructionSiteCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        
        image_with = (SCREEN_WIDTH - 40)/3;
        image_height = 80;
        
        UIView *contentView = [[UIView alloc] initWithFrame:RECT(0, 0, SCREEN_WIDTH,160)];
        contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:contentView];
        
        //描述
        _discreptionLabel = [[UILabel alloc] initWithFrame:RECT(10, 12, 200, 20) textAlignment:NSTextAlignmentLeft font:FONT(12) textColor:[UIColor blackColor]];
        _discreptionLabel.text = @"蓝湖国际工地招牌";
        [contentView addSubview:_discreptionLabel];
        
        //类型背景
        _typebgimage = [[UIImageView alloc] initWithFrame:RECT(SCREEN_WIDTH - 100, 8, 100, 30)];
        _typebgimage.image = [UIImage imageNamed:@"image"];
        _typebgimage.backgroundColor = [UIColor greenColor];
        [contentView addSubview:_typebgimage];
        
        //类型
        _typeLabel = [[UILabel alloc] initWithFrame:RECT(0, 0, 100, 25) textAlignment:NSTextAlignmentCenter font:FONT(12) textColor:[UIColor blackColor]];
        _typeLabel.text = @"水电施工";
        [_typebgimage addSubview:_typeLabel];
        
        
       //时间图片
        UIButton *timeimage = [[UIButton alloc] initWithFrame:RECT(10, 120, 15, 12)];
        [timeimage setImage:[UIImage imageNamed:@"zaijiangngcheng_zhong"] forState:UIControlStateNormal];
        [contentView addSubview:timeimage];
        //时间
        _timeLabel = [[UILabel alloc] initWithFrame:RECT(ORIGIN_X_ADD_SIZE_W(timeimage), ORIGIN_Y(timeimage) - 5, 200, 20) textAlignment:NSTextAlignmentLeft font:FONT(12) textColor:[UIColor blackColor]];
        _timeLabel.text = @"2015-09-28";
        [contentView addSubview:_timeLabel];
        //浏览眼睛图片
        UIButton *browseNumberImg = [[UIButton alloc] initWithFrame:RECT(SCREEN_WIDTH - 120, 120, 15, 10)];
        [browseNumberImg setImage:[UIImage imageNamed:@"zaijiangngcheng_yanjing"] forState:UIControlStateNormal];
        [contentView addSubview:browseNumberImg];
        //浏览数量
        _browseNumber = [[UILabel alloc] initWithFrame:RECT(ORIGIN_X_ADD_SIZE_W(browseNumberImg), ORIGIN_Y(browseNumberImg) - 5, 200, 20) textAlignment:NSTextAlignmentLeft font:FONT(12) textColor:[UIColor blackColor]];
        _browseNumber.text = @"70人浏览";
        [contentView addSubview:_browseNumber];
        
        
        for (NSInteger i = 0; i < 3; i ++) {
            CGFloat width = (SCREEN_WIDTH - 30) / 3;
            UIImageView *image = [[UIImageView alloc] initWithFrame:RECT(10 + i * (width + 5), ORIGIN_Y_ADD_SIZE_H(_discreptionLabel) + 8, width, 70)];
            image.image = [UIImage imageNamed:@""];
            image.backgroundColor = [UIColor colorWithHue: ( arc4random() % 256 / 256.0 ) saturation:(arc4random() % 255 / 256.0) brightness: ( arc4random() % 256 / 256.0 ) alpha:1];
            [self.contentView addSubview:image];
        }
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
