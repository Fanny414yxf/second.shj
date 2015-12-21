//
//  HotShopTableViewCell.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/9.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "HotShopTableViewCell.h"


@implementation HotShopTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *contentView = [[UIView alloc] initWithFrame:self.bounds];
        contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:contentView];
        
        _shopName = [[UILabel alloc] initWithFrame:RECT(0, 0, SCREEN_WIDTH / 2, 20) textAlignment:NSTextAlignmentCenter font:FONT(12) textColor:[RGBColor colorWithHexString:MAINCOLOR_GREEN]];
        [contentView addSubview:_shopName];
        
        _shopImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"linbaozhuangplus_header"]];
        _shopImage.frame = RECT(0, 5, SCREEN_WIDTH, 200);
        _shopImage.contentMode = UIViewContentModeScaleAspectFill;
        [contentView addSubview:_shopImage];
        
        _discreptionBg = [[UIView alloc] initWithFrame:RECT(0, ORIGIN_Y_ADD_SIZE_H(_shopImage), SCREEN_WIDTH, 40)];
        _discreptionBg.backgroundColor = [RGBColor colorWithHexString:MAINCOLOR_GREEN];
        [contentView addSubview:_discreptionBg];
        
        _shopDiscreptionLabel = [[UILabel alloc] initWithFrame:RECT(20, 0, SCREEN_WIDTH - 20, 40) textAlignment:NSTextAlignmentLeft font:FONT(14) textColor:[UIColor whiteColor]];
        _shopDiscreptionLabel.text = @"5周年珍藏版， 黄金性价比飙升";
        [_discreptionBg addSubview:_shopDiscreptionLabel];
        
        _flagbg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"haikuan_flgbg"]];
        _flagbg.frame = RECT(SCREEN_WIDTH - 70, 20, 70, 30);
        _flagbg.contentMode = UIViewContentModeScaleAspectFill;
        [contentView addSubview:_flagbg];
    }
    return self;
}

- (void)setCellInfo:(HaikuanModel *)model
{
    
    _shopName.text = model.title;
    NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ADVIMAGE_URL,model.cover_id]];
    [_shopImage sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"defaultimage"]];
    _shopDiscreptionLabel.text = [NSString stringWithFormat:@"%@", model.title];
    UIView *flag = [self overdueOrCountDown:model.endtime];
    [_flagbg addSubview:flag];
    
}


- (UIView *)overdueOrCountDown:(NSString *)endtime
{
    NSArray *arr = @[@"0", @"0", @":", @"1", @"2", @":", @"4", @"6"];
    
    //endtime 为负数为已过期  否则开始倒计时
    if ([endtime integerValue] > 0) {
       _flagbg.frame = RECT(SCREEN_WIDTH - 100, 20, 100, 30);
        UIView *timmebg = [[UIView alloc] initWithFrame:RECT(10, 7.5, 60, 15)];
        timmebg.backgroundColor = [UIColor clearColor];
        for (NSInteger i = 0; i < 8; i ++) {
            _discreptionBg.backgroundColor = [RGBColor colorWithHexString:@"#e0e0e0"];
            UILabel *time = [[UILabel alloc] initWithFrame:RECT(10 + i * 11, 7.5, 10, 15) textAlignment:NSTextAlignmentCenter font:FONT(12) textColor:[UIColor whiteColor]];//RECT(10 + i * 11, 7.5, 10, 15)
            time.text = [NSString stringWithFormat:@"%@", arr[i]];
            if (i == 2 || i == 5) {
                time.backgroundColor = [UIColor clearColor];
            }else{
                time.backgroundColor = [RGBColor colorWithHexString:MAINCOLOR_GREEN];
            }
            [_flagbg addSubview:time];
        }
        return timmebg;
    }else{
        UILabel *label = [[UILabel alloc] initWithFrame:RECT(0, 0, 80, 30) textAlignment:NSTextAlignmentCenter font:FONT(12) textColor:[UIColor whiteColor]];
        label.text = @"已过期";

        return label;
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
