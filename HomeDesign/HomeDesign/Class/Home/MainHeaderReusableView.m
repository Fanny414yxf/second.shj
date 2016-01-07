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
    NSString *timeStr;//结束时间
    BOOL timeEnd;//嗨款
    BOOL noadvs;
    NSArray *adv;
    NSString *end;
    
    NSInteger nowLong;//结束时间的long值
    
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *segementHeith;
@property (strong, nonatomic) IBOutlet UILabel *zunxiangjiaFont;
@property (nonatomic, strong) UIImageView *defaultImage;//没有轮播时

@end

@implementation MainHeaderReusableView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        _adCycleScrollView.titleArr = @[@"原装正品", @"增项全免", @"延期赔付", @"环保承诺"];
                
        _defaultImage = [[UIImageView alloc] init];
        if (isSizeOf_3_5) {
            _defaultImage.frame = RECT(0, 40, SCREEN_WIDTH, 156.5);
        }else if (isSizeOf_4_0){
            _defaultImage.frame = RECT(0, 40, SCREEN_WIDTH, 159);
        }else if (isSizeOf_4_7){
            _defaultImage.frame = RECT(0, 40, SCREEN_WIDTH, 226);
        }else if (isSizeOf_5_5){
            _defaultImage.frame = RECT(0, 40, SCREEN_WIDTH, 272.667);
        }
        _defaultImage.contentMode = UIViewContentModeScaleToFill;
        _defaultImage.backgroundColor = [UIColor cyanColor];
        _defaultImage.hidden = YES;
        _defaultImage.image = [UIImage imageNamed:@"defaultimage"];
        [self addSubview:_defaultImage];
        
    }
    return self;
}



- (void)setReusableViewInfo:(MainModel *)info;
{
    _defaultImage.frame = RECT(0, 40, SCREEN_WIDTH, SIZE_H(_adScorll));
     NSMutableArray * imagesURLStrings = [NSMutableArray array];
     if (![info.advs isEqual:[NSNull null]] && (info.advs != nil)) {
          adv = [NSArray arrayWithArray:(NSArray *)info.advs];
        for (NSDictionary *dic in adv) {
            NSString *imageUrl = [NSString stringWithFormat:@"%@%@",ADVIMAGE_URL,dic[@"cover_id"]];
            [imagesURLStrings addObject:imageUrl];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 _adScorll.imageURLStringsGroup = imagesURLStrings;
             });
         _defaultImage.hidden = YES;

     }else{
         _defaultImage.hidden = NO;

         [[SDImageCache sharedImageCache] clearMemory];
         [[SDImageCache sharedImageCache] cleanDisk];
         [[SDImageCache sharedImageCache] clearDisk];
         
         [imagesURLStrings removeAllObjects];
         
         _adScorll.placeholderImage = [UIImage imageNamed:@"defaultimage"];
         _adScorll.imageURLStringsGroup = nil;
     }
    
    if ([info.haikuan isEqual:[NSNull null]] || [info.haikuan isEqual:nil]) {
        timeEnd = YES;
        [_timer invalidate];
        
        _countdown_h.text = @"00";
        _countdowm_m.text = @"00";
        _countdown_s.text = @"00";
        _countdown_second.text = @"00";
        _remainingShop.text = [NSString stringWithFormat:@"剩余 0 套"];
        
        
    }else{
        NSDictionary *dic = (NSDictionary *)info.haikuan;
        NSString *count = dic[@"count"];
        end = [NSString stringWithFormat:@"%d",[dic[@"endtime"] integerValue]];
        nowLong = [end integerValue];
        timeStr = [TimeFormatter longTimeLongString:end];
        _remainingShop.text = [NSString stringWithFormat:@"剩余 %@ 套",count];
        if ([end integerValue] > 0) {
            timeEnd = NO;
            
            _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(intervalFromLastDate:toTheDate:) userInfo:@{@"key":@"value"} repeats:YES];
            
//            _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(intervalFromLastDate:toTheDate:) userInfo:@{@"key":@"value"} repeats:YES];
//            [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
//            dispatch_async(dispatch_get_global_queue(0, 0), ^{
//                _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(intervalFromLastDate:toTheDate:) userInfo:@{@"key":@"value"} repeats:true];
//                [[NSRunLoop currentRunLoop] run];
//                
//            });
            
        }else{
            timeEnd = YES;
            [_timer invalidate];
            _countdown_h.text = @"00";
            _countdowm_m.text = @"00";
            _countdown_s.text = @"00";
            _countdown_second.text = @"00";
            [UserInfo shareUserInfo].haikuan_day = @"00";
            [UserInfo shareUserInfo].haikuan_hour = @"00";
            [UserInfo shareUserInfo].haikuan_min = @"00";
            [UserInfo shareUserInfo].haikuan_second = @"00";
            return;
        }
    }
}


#pragma mark - 嗨款倒计时
- (void)intervalFromLastDate:(NSString *)dateString1  toTheDate:(NSString *) dateString2
{
    if (timeEnd) {
        [_timer invalidate];
        return ;
    }
    _countdown_h.text = [UserInfo shareUserInfo].haikuan_day;
    _countdowm_m.text = [UserInfo shareUserInfo].haikuan_hour;
    _countdown_s.text = [UserInfo shareUserInfo].haikuan_min;
    _countdown_second.text = [UserInfo shareUserInfo].haikuan_second;
    
    nowLong --;
    
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
    // Initialization code
    if (isSizeOf_4_0) {
        self.segementHeith.constant = 30;
    }
    
    if (isSizeOf_3_5) {
        
    }else if (isSizeOf_4_0){
        
    }else if (isSizeOf_4_7){
        
    }else if (isSizeOf_5_5){
        
    }
   
}

@end
