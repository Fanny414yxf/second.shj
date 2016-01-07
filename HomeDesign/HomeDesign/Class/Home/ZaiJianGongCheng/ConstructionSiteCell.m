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
@property (nonatomic, strong) UIImageView *browseNumberImg;//浏览眼睛图片
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
        
        UIView *contentView = [[UIView alloc] initWithFrame:RECT(0, 10, SCREEN_WIDTH,145)];
        contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:contentView];
        
        //描述
        _discreptionLabel = [[UILabel alloc] initWithFrame:RECT(10, 12, SCREEN_WIDTH - 90, 20) textAlignment:NSTextAlignmentLeft font:FONT(13) textColor:[UIColor blackColor]];
        _discreptionLabel.text = @"蓝湖国际工地招牌";
        [contentView addSubview:_discreptionLabel];
        
        //类型背景
        _typebgimage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zaijiangongcheng_typegb"]];
        _typebgimage.frame = RECT(SCREEN_WIDTH - 80, 8, 80, 25);
        _typebgimage.contentMode = UIViewContentModeScaleAspectFill;
        [contentView addSubview:_typebgimage];
        
        //类型
        _typeLabel = [[UILabel alloc] initWithFrame:RECT(0, 0, 80, 25) textAlignment:NSTextAlignmentCenter font:FONT(12) textColor:[UIColor whiteColor]];
        _typeLabel.text = @"水电施工";
        [_typebgimage addSubview:_typeLabel];
        
        
       //时间图片
        UIImageView *timeimage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zaijiangngcheng_zhong"]];
        timeimage.frame = RECT(10, 120, 15, 12);
        timeimage.contentMode = UIViewContentModeScaleAspectFit;
        [contentView addSubview:timeimage];
        //时间
        _timeLabel = [[UILabel alloc] initWithFrame:RECT(ORIGIN_X_ADD_SIZE_W(timeimage), ORIGIN_Y(timeimage) - 5, 200, 20) textAlignment:NSTextAlignmentLeft font:FONT(12) textColor:[UIColor blackColor]];
        _timeLabel.text = @"2015-09-28";
        [contentView addSubview:_timeLabel];
        
        //浏览眼睛图片
        _browseNumber = [[UILabel alloc] initWithFrame:RECT(SCREEN_WIDTH - 10, ORIGIN_Y(_timeLabel), 200, 20) textAlignment:NSTextAlignmentRight font:FONT(12) textColor:[UIColor blackColor]];
        _browseNumber.text = @"70人浏览";
        [contentView addSubview:_browseNumber];
        [_browseNumber sizeToFit];
        _browseNumber.frame = RECT(SCREEN_WIDTH - 10 - _browseNumber.frame.size.width, ORIGIN_Y(_timeLabel), _browseNumber.frame.size.width, 20);
        
        
        _browseNumberImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zaijiangngcheng_yanjing"]];
        _browseNumberImg.contentMode = UIViewContentModeScaleAspectFit;
        _browseNumberImg.frame = RECT(SCREEN_WIDTH - 25 - SIZE_W(_browseNumber), ORIGIN_Y(_browseNumber) + 5, 15, 10);
        [contentView addSubview:_browseNumberImg];
        
        
        for (NSInteger i = 0; i < 3; i ++) {
            CGFloat width = (SCREEN_WIDTH - 30) / 3;
            UIImageView *image = [[UIImageView alloc] initWithFrame:RECT(10 + i * (width + 5), ORIGIN_Y_ADD_SIZE_H(_typebgimage) + 18, width, 70)];
            image.tag = 100 + i;
            image.image = [UIImage imageNamed:@"defaultimage"];
            image.contentMode = UIViewContentModeScaleToFill;
            [self.contentView addSubview:image];
        }
    }
    return self;
}


- (void)setCellInfo:(ZaiJianGongChengModel *)info;
{
    _discreptionLabel.text = [NSString stringWithFormat:@"%@", info.title];
    _typeLabel.text = [NSString stringWithFormat:@"%@",info.jindu];
    _timeLabel.text = [TimeFormatter longTimeLongStringWithyyyyMMdd:info.create_time];
    _browseNumber.text = [NSString stringWithFormat:@"%@人浏览",info.view];
    
    //重置图片和标签的frame
    UILabel *label = [[UILabel alloc] initWithFrame:RECT(0, 0, 100, 20) textAlignment:NSTextAlignmentRight font:FONT(12) textColor:[UIColor blackColor]];
    label.text = [NSString stringWithFormat:@"%@人浏览",info.view];
    [label sizeToFit];
    _browseNumberImg.frame = RECT(SCREEN_WIDTH - 15 - 15 - label.frame.size.width, ORIGIN_Y(_browseNumber)+5, 15, 10);
    _browseNumber.frame = RECT(ORIGIN_X_ADD_SIZE_W(_browseNumberImg)+2, ORIGIN_Y(_browseNumber), SIZE_W(label), 20);

    
    if (![info.pictures isEqual:[NSNull null]]  && (info.pictures != nil) && ![info.pictures isEqual:@""] && info.pictures.count != 0) {
        for (NSInteger i = 0; i < [info.pictures count] ; i ++) {
            UIImageView *image = (UIImageView *)[self.contentView viewWithTag:100 + i];
            NSString *url = [NSString stringWithFormat:@"%@", info.pictures[i]];
            if (![url hasPrefix:@"http"]) {
                url = [NSString stringWithFormat:@"%@%@", ADVIMAGE_URL, info.pictures[i]];
            }
            [image sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"defaultimage"]];
        }
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
