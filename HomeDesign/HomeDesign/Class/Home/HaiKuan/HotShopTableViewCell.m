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
    UIView *timmebg;
    UILabel *hourse1;
    UILabel *hourse2;
    UILabel *fen1;
    UILabel *fen2;
    UILabel *miao1;
    UILabel *miao2;
    NSString *endtiemStr;
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
    _model = model;
    endtiemStr = [TimeFormatter longTimeLongString:_model.endtime];
    if ([_model.endtime integerValue] > 0) {
#pragma mark - 已写好  拖延时间  SB**********************************************
//    [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(intervalFromLastDate:toTheDate:) userInfo:nil repeats:YES];
        [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(contDownTimeWithHfenmiaoTimerFireMethod:) userInfo:nil repeats:YES];

        _discreptionBg.backgroundColor = [RGBColor colorWithHexString:MAINCOLOR_GREEN];
    }else{
        hourse1.text = @"0";
        hourse2.text = @"0";
        fen1.text = @"0";
        fen2.text = @"0";
        miao1.text = @"0";
        miao2.text = @"0";
        _discreptionBg.backgroundColor = [RGBColor colorWithHexString:MAINCOLOR_GREEN];
    }
}

//时间
- (UIView *)overdueOrCountDown:(NSString *)endtime
{
    NSArray *arr = @[@"0", @"0", @":", @"1", @"2", @":", @"4", @"6"];
    
    //endtime 为负数为已过期  否则开始倒计时
    if ([endtime integerValue] > 0) {
       _flagbg.frame = RECT(SCREEN_WIDTH - 100, 20, 100, 30);
        timmebg = [[UIView alloc] initWithFrame:RECT(10, 7.5, 60, 15)];
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
            
            if (i == 0) {
                hourse1 = time;
            }
            if (i == 1) {
                hourse2 = time;
            }
            if (i == 3) {
                fen1 = time;
            }
            if (i == 4) {
                fen2 = time;
            }
            if (i == 6) {
                miao1 = time;
            }
            if (i == 7) {
                miao2 = time;
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


#pragma mark - 嗨款倒计时
/**
 *  嗨款倒计时
 *
 *  @param dateString1 当前时间
 *  @param dateString2 结束时间
 *
 *  @return 剩余 时分秒
 */
- (NSString *)intervalFromLastDate:(NSString *)dateString1 toTheDate:(NSString *) dateString2
{
    NSString *nowtime = [TimeFormatter dateFormatterWithDate_yyyyMMdd_HHmmss:[NSDate date]];
    
    NSArray *timeArray1=[nowtime componentsSeparatedByString:@"."];
    dateString1=[timeArray1 objectAtIndex:0];
    
    NSArray *timeArray2=[endtiemStr componentsSeparatedByString:@"."];
    dateString2=[timeArray2 objectAtIndex:0];
    
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *d1=[date dateFromString:dateString1];
    
    NSTimeInterval late1=[d1 timeIntervalSince1970]*1;
    
    NSDate *d2=[date dateFromString:dateString2];
    
    NSTimeInterval late2=[d2 timeIntervalSince1970]*1;
    
    NSTimeInterval cha=late2-late1;
    NSString *timeString=@"";
    NSString *house=@"";
    NSString *min=@"";
    NSString *sen=@"";
    
    sen = [NSString stringWithFormat:@"%d", (int)cha%60];
    //        min = [min substringToIndex:min.length-7];
    //    秒
    sen=[NSString stringWithFormat:@"%@", sen];
    if ([sen integerValue] < 10) {
        sen = [NSString stringWithFormat:@"0%@",sen];
    }
    
    min = [NSString stringWithFormat:@"%d", (int)cha/60%60];
    //        min = [min substringToIndex:min.length-7];
    //    分
    min=[NSString stringWithFormat:@"%@", min];
    if ([min integerValue] < 10) {
        min = [NSString stringWithFormat:@"0%@",min];
    }
    
    //    小时
    house = [NSString stringWithFormat:@"%d", (int)cha/3600];
    //        house = [house substringToIndex:house.length-7];
    house=[NSString stringWithFormat:@"%@", house];
    if ([house integerValue] < 10) {
        house = [NSString stringWithFormat:@"0%@",house];
    }
    
    hourse1.text = [house substringToIndex:1];
    hourse2.text = [house substringFromIndex:1];
    miao1.text = [sen substringToIndex:1];
    miao2.text = [sen substringFromIndex:1];
    fen1.text = [min substringToIndex:1];
    fen2.text = [min substringFromIndex:1];
    if (house == 0 && min == 0 && sen == 0) {
        hourse1.text = @"0";
        hourse2.text = @"0";
        fen1.text = @"0";
        fen2.text = @"0";
        miao1.text = @"0";
        miao2.text = @"0";
    }
    
    timeString=[NSString stringWithFormat:@"%@:%@:%@",house,min,sen];
    
    return timeString;
}

- (void)contDownTimeWithHfenmiaoTimerFireMethod:(NSTimer *)timer{
    BOOL timeStar = YES;
    //定义一个NSCalendar
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *endTime = [[NSDateComponents alloc] init];
    //当前时间
    NSDate *today = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //结束时间
    NSDate *date = [TimeFormatter makeDateWithTimeString:endtiemStr];
    NSString *overDate = [dateFormatter stringFromDate:date];
    
    static NSInteger year;
    static NSInteger month;
    static NSInteger day;
    static NSInteger hour;
    static NSInteger minute;
    static NSInteger second;
    
    if (timeStar) {
        year = [[overDate substringWithRange:NSMakeRange(0, 4)] intValue];
        month = [[overDate substringWithRange:NSMakeRange(5, 2)] intValue];
        day = [[overDate substringWithRange:NSMakeRange(8, 2)] intValue];
        hour = [[overDate substringWithRange:NSMakeRange(11, 2)] intValue];
        minute = [[overDate substringWithRange:NSMakeRange(14, 2)] intValue];
        second = [[overDate substringWithRange:NSMakeRange(17, 2)] intValue];
        timeStar= NO;
    }
    [endTime setYear:year];
    [endTime setMonth:month];
    [endTime setDay:day];
    [endTime setHour:hour];
    [endTime setMinute:minute];
    [endTime setSecond:second];
    
    //用来得到具体时间差  是为了统一成北京时间
    NSDate *overtime = [cal dateFromComponents:endTime];
    unsigned int uiitFalgs = NSYearCalendarUnit| NSMonthCalendarUnit| NSDayCalendarUnit| NSHourCalendarUnit| NSMinuteCalendarUnit| NSSecondCalendarUnit;
    NSDateComponents *d = [cal components:uiitFalgs fromDate:today toDate:overtime options:0];
    NSString *t = [NSString stringWithFormat:@"%ld", (long)[d day]];
    if ([d day] < 10) {
        t = [NSString stringWithFormat:@"0%ld", (long)[d day]];
    }
    NSString *h = [NSString stringWithFormat:@"%ld", (long)[d hour]];
    if ([d hour] < 10) {
        h = [NSString stringWithFormat:@"0%ld", (long)[d hour]];
    }
    NSString *fen = [NSString stringWithFormat:@"%ld", (long)[d minute]];
    if([d minute] < 10) {
        fen = [NSString stringWithFormat:@"0%ld",(long)[d minute]];
    }
    NSString *miao = [NSString stringWithFormat:@"%ld", (long)[d second]];
    if([d second] < 10) {
        miao = [NSString stringWithFormat:@"0%ld",(long)[d second]];
    }
    
    if ([d second] > 0) {
        hourse1.text = [t substringToIndex:1];
        hourse2.text = [t substringFromIndex:1];
        miao1.text = [fen substringToIndex:1];
        miao2.text = [fen substringFromIndex:1];
        fen1.text = [h substringToIndex:1];
        fen2.text = [h substringFromIndex:1];
    }else if (t == 0 && h == 0 && fen == 0){
        hourse1.text = @"0";
        hourse2.text = @"0";
        fen1.text = @"0";
        fen2.text = @"0";
        miao1.text = @"0";
        miao2.text = @"0";
    }else{
        //计时器失效
        [timer invalidate];
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
