//
//  CountResultView.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/17.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "CountResultView.h"

@interface CountResultView ()<UIAlertViewDelegate>

@property (nonatomic, strong) UILabel *priceselabel;


@end

@implementation CountResultView


- (instancetype)initWithJieguo:(NSString *)jieguo
{
    self = [super init];
    if (self) {
        self.frame = RECT(0, FUSONNAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - FUSONNAVIGATIONBAR_HEIGHT);
        self.backgroundColor = [UIColor colorWithHex:0.6 alpha:0.5];
        
        UIView *contentView = [[UIView alloc] initWithFrame:RECT(0, SCREEN_HEIGHT - 200, SCREEN_WIDTH, 200)];
        contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:contentView];
        
        UIView *topView = [[UIView alloc] initWithFrame:RECT(0, 0, SCREEN_WIDTH, 3)];
        topView.backgroundColor = [RGBColor colorWithHexString:MAINCOLOR_GREEN];
        [contentView addSubview:topView];
        
        UILabel *namelabel = [[UILabel alloc] initWithFrame:RECT(10, 35, SCREEN_SCALE_WIDTH(90), 30) textAlignment:NSTextAlignmentCenter font:FONT(18) textColor:[UIColor blackColor]];
        namelabel.text = @"估算价格：";
        [namelabel sizeToFit];
        [contentView addSubview:namelabel];
        
        _priceselabel = [[UILabel alloc] initWithFrame:RECT(ORIGIN_X_ADD_SIZE_W(namelabel), ORIGIN_Y(namelabel) - 10, 120, 40) textAlignment:NSTextAlignmentCenter font:FONT(20) textColor:[RGBColor colorWithHexString:MAINCOLOR_GREEN]];
        _priceselabel.attributedText =  [self attributedStringChangeFont:[NSString stringWithFormat:@"%@ 元", jieguo]];
        _priceselabel.layer.cornerRadius = 5;
        _priceselabel.layer.borderColor = [[RGBColor colorWithHexString:MAINCOLOR_GREEN] CGColor];
        _priceselabel.layer.borderWidth = 1;
        [_priceselabel sizeToFit];
        _priceselabel.frame = RECT(ORIGIN_X_ADD_SIZE_W(namelabel), ORIGIN_Y(namelabel) - 5, SIZE_W(_priceselabel) + SCREEN_SCALE_WIDTH(20), 35);
        [contentView addSubview:_priceselabel];
        
        UIView *personView = [[UIView alloc] initWithFrame:RECT(ORIGIN_X_ADD_SIZE_W(_priceselabel) + 10, ORIGIN_Y(_priceselabel) - 2.5, SCREEN_SCALE_WIDTH(100), 35)];
        personView.layer.cornerRadius = 5;
        personView.backgroundColor = [RGBColor colorWithHexString:MAINCOLOR_GREEN];
        [contentView addSubview:personView];
        
        UIImageView *btnbg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"woyaobaojia_perbtn"]];
        btnbg.frame = RECT(SCREEN_SCALE_WIDTH(10), 10, 20, 20);
        btnbg.contentMode = UIViewContentModeScaleAspectFit;
        [personView addSubview:btnbg];
        
        UILabel *persontbtnLabel = [[UILabel alloc] initWithFrame:RECT(ORIGIN_X_ADD_SIZE_W(btnbg), 10, 60, 20) textAlignment:NSTextAlignmentCenter font:FONT(12) textColor:[UIColor whiteColor]];
        persontbtnLabel.text = @"人工报价";
        [personView addSubview:persontbtnLabel];
        
        UIButton *personBtn = [[UIButton alloc] initWithFrame:btnbg.bounds];
        [personBtn addTarget:self action:@selector(handlePersonBtn:) forControlEvents:UIControlEventTouchUpInside];
        [personView addSubview:personBtn];
        
        UIImageView *gouimage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"woyaobaojia_gou"]];
        gouimage.frame = RECT(ORIGIN_X(namelabel), 90, 20, 20);
        gouimage.contentMode = UIViewContentModeScaleAspectFit;
        [contentView addSubview:gouimage];
        
        UILabel *note = [[UILabel alloc] initWithFrame:RECT(ORIGIN_X_ADD_SIZE_W(gouimage) + 10, ORIGIN_Y(gouimage) - 5, SCREEN_WIDTH - 60, 30) textAlignment:NSTextAlignmentLeft font:FONT(12) textColor:[UIColor grayColor]];
        note.text = @"以上价格为估算报价， 实际价格以量房结果为准";
        [contentView addSubview:note];
        
        UIButton *closebtn = [[UIButton alloc] initWithFrame:RECT(SCREEN_WIDTH - 30, - 15, 30, 30)];//RECT(SCREEN_WIDTH - 30, SCREEN_HEIGHT - SCREEN_SCALE_HEIGHT(185), 30, 30)
        [closebtn setImage:[UIImage imageNamed:@"woyaobaojia_close"] forState:UIControlStateNormal];
        closebtn.imageView.contentMode = UIViewContentModeScaleToFill;
        [closebtn addTarget:self action:@selector(handleCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:closebtn];
        
    }
    return self;
}


#pragma mark - process
- (void)handlePersonBtn:(UIButton *)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否拨打4008-122-100" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定 ", nil];
    alert.delegate = self;
    [alert show];
    
}

#pragma mark  <UIAlertViewDelegate>
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (buttonIndex == 0) {
        [alertView removeFromSuperview];
    }else{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:4008122100"]];
    }
}


- (void)handleCloseBtn:(UIButton *)sender
{
    [self removeFromSuperview];
}


- (NSMutableAttributedString *)attributedStringChangeFont:(NSString *)string
{
    NSMutableAttributedString * mutAttStr = [[NSMutableAttributedString alloc] initWithString:string];
    [mutAttStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, [string length] - 2)];
   [mutAttStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange([string length] - 1, 1)];
    return mutAttStr;
}


@end
