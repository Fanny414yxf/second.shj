//
//  MainHeaderReusableView.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/12.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "MainHeaderReusableView.h"
#import "TimeFormatter.h"
#import "ITTHeader.h"


@interface MainHeaderReusableView ()
{
    NSString *timeStr;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *segementHeith;
@property (strong, nonatomic) IBOutlet UILabel *zunxiangjiaFont;
@end

@implementation MainHeaderReusableView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        _adCycleScrollView.titleArr = @[@"原装正品", @"增项全免", @"0延期", @"环保不达标全额退款"];
       
        
        //*******轮播广告*******
        _adScorll.delegate = self;
        _adScorll.placeholderImage = [UIImage imageNamed:@"defaultimage"];
        
    }
    return self;
}


- (void)setReusableViewInfo:(MainModel *)info;
{
     if (info.advs != [NSNull null]) {
        NSArray *adv = [NSArray arrayWithArray:(NSArray *)info.advs];
        NSMutableArray * imagesURLStrings = [NSMutableArray array];
        for (NSDictionary *dic in adv) {
            NSString *imageUrl = [NSString stringWithFormat:@"%@%@",ADVIMAGE_URL,dic[@"cover_id"]];
            [imagesURLStrings addObject:imageUrl];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _adScorll.imageURLStringsGroup = imagesURLStrings;
        });
        imagesURLStrings == nil ? ( _adScorll.placeholderImage = [UIImage imageNamed:@"defaultimage"]) : nil;

     }else{
         _adScorll.placeholderImage = [UIImage imageNamed:@"defaultimage"];
     }
    if (info.linbaozhuang != [NSNull null]) {
        
    }
    if (info.linbaozhuangPLUS != [NSNull null]) {
        
    }
    if (info.zunxiangjia != [NSNull null]) {
        
    }
    if (info.haikuan != [NSNull null]) {
        NSDictionary *dic = (NSDictionary *)info.haikuan;
        NSString *count = dic[@"count"];
        NSString *end = [NSString stringWithFormat:@"%d",[dic[@"endtime"] integerValue]];
        timeStr = [TimeFormatter longTimeLongString:end];
        _remainingShop.text = [NSString stringWithFormat:@"剩余 %@ 套",count];
        if ([end integerValue] > 0) {
            [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(intervalFromLastDate:toTheDate:) userInfo:nil repeats:YES];
        }else{
            _countdown_h.text = @"00";
            _countdowm_m.text = @"00";
            _countdown_s.text = @"00";
        }
    
    }else{
        _countdown_h.text = @"00";
        _countdowm_m.text = @"00";
        _countdown_s.text = @"00";
        _remainingShop.text = [NSString stringWithFormat:@"剩余 0 套"];
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
    
    NSArray *timeArray2=[timeStr componentsSeparatedByString:@"."];
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
    
    _countdown_h.text = house;
    _countdowm_m.text = min;
    _countdown_s.text = sen;
    if (house == 0 && min == 0 && sen == 0) {
        _countdown_h.text = @"00";
        _countdowm_m.text = @"00";
        _countdown_s.text = @"00";
    }
    
    timeString=[NSString stringWithFormat:@"%@:%@:%@",house,min,sen];
    
    return timeString;
}


- (IBAction)clickLingBaoZhuang:(id)sender {
        if (self.button) {
        self.button(ReusableTypeLinBaoZhuang);
    }
}
- (IBAction)clickLinBaoZhuangPLUS:(id)sender {
    if (self.button) {
        self.button(ReusableTypeLinBaoZhuangPLUS);
    }
}
- (IBAction)clickZunXiangJia:(id)sender {
    if (self.button) {
        self.button(ReusableTypeZunXiangJia);
    }
}
- (IBAction)clickHaiKuan:(id)sender {
    if (self.button) {
        self.button(ReusableTypeHaiKuan);
    }
}

- (void)handleButton:(BlockBtnClick)block
{
    self.button = block;
}


- (void)awakeFromNib {
//    if (isSizeOf_4_0) {
//        self.segementHeith.constant = 30;
//    }
    // Initialization code
}

@end
