//
//  HotShopTableViewCell.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/9.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "HotShopTableViewCell.h"

@interface HotShopTableViewCell ()
{
    
    UIView *timeContentView;//时间
    UILabel *flagLabel;//已过期
    UILabel *dayLabel;
    UILabel *hourLabel;
    UILabel *minLabel;
    UILabel *secondLabel;
    
    NSString *endtiemStr;
    NSInteger nowLong;//结束时间的long值
    
    BOOL timeEnd;//嗨款
}

@property (nonatomic, strong) HaikuanModel *model;


@end

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
        
        _discreptionBg.backgroundColor = [RGBColor colorWithHexString:@"#e0e0e0"];

        
        _flagbg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"haikuan_flgbg"]];
        _flagbg.frame = RECT(SCREEN_WIDTH - 100, 20, 100, 30);
        _flagbg.contentMode = UIViewContentModeScaleToFill;
        [contentView addSubview:_flagbg];
        
        timeContentView = [[UIView alloc] initWithFrame:RECT(0, 0, 100, 30)];
        timeContentView.hidden = NO;
        [_flagbg addSubview:timeContentView];

        for (NSInteger i = 0; i < 4; i ++) {
            
            UIImageView *timebg = [[UIImageView alloc] initWithFrame:RECT(10 + i * 22 , 8, 17, 14)];
            timebg.image = [UIImage imageNamed:@"home_shijianbcg"];
            [timeContentView addSubview:timebg];
            
            UILabel *time = [[UILabel alloc] initWithFrame:RECT(0, 0, 18, 15) textAlignment:NSTextAlignmentCenter font:FONT(12) textColor:[UIColor whiteColor]];
            time.text = @"00";
            [timebg addSubview:time];
            
            UILabel *maohao = [[UILabel alloc] initWithFrame:RECT(28 + i * 22, 8, 2, 15) textAlignment:NSTextAlignmentCenter font:FONT(12) textColor:[UIColor whiteColor]];
            maohao.text = @":";
            if (i == 0) {
                dayLabel = time;
            }
            if ( i == 1) {
                hourLabel = time;
            }
            if (i == 2) {
                minLabel = time;
            }
            if ( i == 3) {
                secondLabel = time;
                maohao.hidden = YES;
            }
        
            [timeContentView addSubview:maohao];
        }
        
        
        flagLabel = [[UILabel alloc] initWithFrame:RECT(0, 0, 70, 30) textAlignment:NSTextAlignmentCenter font:FONT(12) textColor:[UIColor whiteColor]];
        flagLabel.text = @"已过期";
        flagLabel.hidden = YES;
        [_flagbg addSubview:flagLabel];
        
    }

    return self;
}

- (void)setCellInfo:(HaikuanModel *)model
{
    _shopName.text = model.title;
    NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ADVIMAGE_URL,model.cover_id]];
    [_shopImage sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"defaultimage"]];
    _shopDiscreptionLabel.text = [NSString stringWithFormat:@"%@", model.title];
    _model = model;
    endtiemStr = [TimeFormatter longTimeLongString:_model.endtime];
    nowLong = [model.endtime integerValue];
    if ([_model.endtime integerValue] > 0) {
        _flagbg.frame = RECT(SCREEN_WIDTH - 100, 20, 100, 30);
        flagLabel.hidden = YES;
        timeContentView.hidden = NO;
        timeEnd = NO;
         [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(contDownTimeWithHfenmiaoTimerFireMethod:) userInfo:nil repeats:YES];

        _discreptionBg.backgroundColor = [RGBColor colorWithHexString:MAINCOLOR_GREEN];
    }else{
        _flagbg.frame = RECT(SCREEN_WIDTH - 80, 20, 80, 30);
        flagLabel.hidden = NO;
        timeContentView.hidden = YES;
        timeEnd = YES;
        _shopDiscreptionLabel.textColor = [UIColor blackColor];
        _discreptionBg.backgroundColor = [RGBColor colorWithHexString:@"#e0e0e0"];
    }
}


#pragma mark - 嗨款倒计时
/**
 *  嗨款倒计时
 *
 *  @param dateString1 当前时间
 *  @param dateString2 结束时间
 *
 *  @return 剩余 时分秒
 */
- (void)contDownTimeWithHfenmiaoTimerFireMethod:(NSTimer *)timer{
    
    if (timeEnd) {
        [timer invalidate];
        return;
    }
        dayLabel.text = [UserInfo shareUserInfo].haikuan_day;
        hourLabel.text = [UserInfo shareUserInfo].haikuan_hour;
        minLabel.text = [UserInfo shareUserInfo].haikuan_min;
        secondLabel.text = [UserInfo shareUserInfo].haikuan_second;
        
        nowLong --;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
