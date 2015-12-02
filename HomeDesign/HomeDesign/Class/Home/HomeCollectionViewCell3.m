//
//  HomeCollectionViewCell3.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/11/18.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "HomeCollectionViewCell3.h"
#import "TimeFormatter.h"
#import "ITTHeader.h"

@interface HomeCollectionViewCell3 ()
{
    UIView *countTimeView;
}

@property (nonatomic, strong) UILabel *timelabel;

@end

@implementation HomeCollectionViewCell3


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        for (NSInteger i  = 0; i < 2; i ++) {
            UIView *layerView = [[UIView alloc] initWithFrame:RECT(5 + i * (SCREEN_WIDTH/2), 0, (SCREEN_WIDTH - 20) / 2, SCREEN_WIDTH / 5.0)];
            layerView.layer.cornerRadius = 10;
            layerView.backgroundColor = [RGBColor colorWithHexString:@"#3c3c3c"];
            [self.contentView addSubview:layerView];
            
            UIImageView *image = [[UIImageView alloc] init];
            image.layer.cornerRadius = 25;
            image.center = CGPointMake( 50, frame.size.height / 2);
            image.tag = i;
            i == 0 ? (image.image = [UIImage imageNamed:@"home_zunxiangjia"]) : (image.image = [UIImage imageNamed:@"home_haikuan"]);
            [layerView addSubview:image];
            [image mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(layerView.mas_left).with.offset(15);
                make.centerY.equalTo(layerView.mas_centerY);
                make.width.mas_equalTo(40);
                make.height.mas_equalTo(55);
            }];
            //title
            UILabel *label = [[UILabel alloc] init];
            label.text = NSTextAlignmentLeft;
            label.tag = i + 10;
            label.font = FONT(SCREEN_SCALE_WIDTH(16));
            i == 0 ? (label.text = @"尊享家") : (label.text = @"嗨款");
            [label sizeToFit];
            label.textColor = [UIColor yellowColor];
            [layerView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                i == 0 ? (make.bottom.equalTo(layerView.mas_centerY).with.offset(2)) : (make.bottom.equalTo(layerView.mas_centerY).with.offset(-3));
                make.left.equalTo(image.mas_right).with.offset(10);
                make.right.equalTo(layerView.mas_right);
                make.height.mas_equalTo(20);
            }];
            //内容
            UILabel *labledetail = [[UILabel alloc] init];
            labledetail.textAlignment = NSTextAlignmentLeft;
            labledetail.tag = 20 + i;
            i == 0 ? (labledetail.text = @"时代尊享,就在生活家") :(labledetail.text = @"剩余 0 套");
            [labledetail sizeToFit];
            labledetail.textColor = [UIColor yellowColor];
            labledetail.font = FONT(SCREEN_SCALE_WIDTH(11));
            [layerView addSubview:labledetail];
            [labledetail mas_makeConstraints:^(MASConstraintMaker *make) {
                i == 0 ? (make.top.equalTo(layerView.mas_centerY).with.offset(5)) : (make.centerY.equalTo(layerView.mas_centerY).offset(3));
                make.left.equalTo(label);
                make.right.equalTo(layerView.mas_right);
                make.height.mas_equalTo(20);
            }];
            if (i==1) {
                _hotImage = [[UIImageView alloc] initWithFrame:RECT(layerView.frame.size.width - SCREEN_SCALE_WIDTH(40), 0, SCREEN_SCALE_WIDTH(40), SCREEN_SCALE_WIDTH(40))];
                _hotImage.image = [UIImage imageNamed:@"home_hot"];
                [layerView addSubview:_hotImage];
            
                [layerView addSubview:[self countimeView]];
                [countTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(labledetail.mas_left);
                    make.top.equalTo(labledetail.mas_bottom).offset(2);
                }];
                
                [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(contDownTimeWithHfenmiaoTimerFireMethod:) userInfo:nil repeats:YES];
            }
            
            UIButton *button = [[UIButton alloc] initWithFrame:self.contentView.frame];
            button.tag = i+10;
            [button addTarget:self action:@selector(handleButtoncell3:) forControlEvents:UIControlEventTouchUpInside];
            [layerView addSubview:button];
        }
    }
    return self;
}


/**
 *  倒计时view
 */
- (UIView *)countimeView
{
    countTimeView = [[UIView alloc] initWithFrame:RECT(SCREEN_SCALE_WIDTH(65), SCREEN_SCALE_HEIGHT(53), SCREEN_SCALE_WIDTH(30), SCREEN_SCALE_HEIGHT(20))];
    for (NSInteger i = 0; i < 3; i ++) {

        UIImageView *image = [[UIImageView alloc] initWithFrame:RECT(0 + i *SCREEN_SCALE_WIDTH(28), 0, 18, 15)];
        image.image = [UIImage imageNamed:@"home_shijianbcg"];
        [countTimeView addSubview:image];
        
        UILabel *maohaolabel = [[UILabel alloc] initWithFrame:RECT(ORIGIN_X_ADD_SIZE_W(image)+2, -2.5, 2, 20)];
        maohaolabel.textAlignment = NSTextAlignmentCenter;
        maohaolabel.textColor = [UIColor whiteColor];
        maohaolabel.font = FONT(SCREEN_SCALE_WIDTH(12));
        maohaolabel.text = @":";
        if (i == 2) {
            maohaolabel.hidden = YES;
        }
        [countTimeView addSubview:maohaolabel];
        
        UILabel *label = [[UILabel alloc] initWithFrame:RECT(0 , -2.5, 25, 20)];
        label.font = FONT(SCREEN_SCALE_WIDTH(12));
        label.text = @"33";
        label.tag = i + 30;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        [image addSubview:label];
        
        if (isSizeOf_3_5 || isSizeOf_4_0) {
            label.frame = RECT(-3, -2.5, 25, 20);
        }else if (isSizeOf_4_7){
            label.frame = RECT(-2, -2.5, 25, 20);
            maohaolabel.frame = RECT(ORIGIN_X_ADD_SIZE_W(image) + 3, -2.5, 2, 20);
        }else if (isSizeOf_5_5){
            image.frame = RECT(0 + i * SCREEN_SCALE_WIDTH(28), 0, 20, 16);
            label.frame = RECT(-2, -2.5, 25, 20);
            maohaolabel.frame = RECT(ORIGIN_X_ADD_SIZE_W(image) + 3, -2.5, 2, 20);
        }
    }
    return countTimeView;
}


#pragma mark - process
- (void)handleButtoncell3:(UIButton *)sender
{
    if (self.buttn) {
        self.buttn(sender.tag);
    }
}

- (void)handleButton:(BlockBtnClick)block
{
    self.buttn = block;
}

#pragma mark - 嗨款倒计时
- (void)contDownTimeWithHfenmiaoTimerFireMethod:(NSTimer *)timer{
    BOOL timeStar = YES;
    //定义一个NSCalendar
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *endTime = [[NSDateComponents alloc] init];
    //当前时间
    NSDate *today = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [TimeFormatter makeDateWithTimeString:@"2015-11-27 10:30:00"];
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
        //没结束
        _timelabel.text = [NSString stringWithFormat:@"%@ ：%@ ：%@",h, fen, miao];
        
        ((UILabel *)[countTimeView viewWithTag:30]).text = [NSString stringWithFormat:@"%@", h];
        ((UILabel *)[countTimeView viewWithTag:31]).text = [NSString stringWithFormat:@"%@", fen];
        ((UILabel *)[countTimeView viewWithTag:32]).text = [NSString stringWithFormat:@"%@", miao];
    }else if ([d second] == 0){
        //结束
        _timelabel.text = @"00:00:00";
    }else{
        //计时器失效
        [timer invalidate];
    }
}


@end
