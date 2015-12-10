//
//  PopShadowView.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/10.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "PopShadowView.h"

@interface PopShadowView ()

@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *bodyLabel;

@end

@implementation PopShadowView

- (instancetype)init
{
    if (self = [super init]) {
        self.frame = RECT(0, FUSONNAVIGATIONBAR_HEIGHT, SCREEN_HEIGHT, SCREEN_HEIGHT - FUSONNAVIGATIONBAR_HEIGHT);
        self.backgroundColor = [UIColor colorWithHex:0.5 alpha:0.5];
        self.userInteractionEnabled = YES;
        
        UIView * contentView = [[UIView alloc] initWithFrame:RECT(0, 0, SCREEN_WIDTH * 0.7, SCREEN_HEIGHT *0.6)];
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.center = CGPointMake(SCREEN_WIDTH / 2, (SCREEN_HEIGHT - FUSONNAVIGATIONBAR_HEIGHT) / 2 ) ;
        [self addSubview:contentView];
        
        UIButton *closeBtn = [[UIButton alloc] initWithFrame:RECT(ORIGIN_X(contentView), ORIGIN_Y_ADD_SIZE_H(contentView), SIZE_W(contentView), 30)];
        closeBtn.backgroundColor = [UIColor whiteColor];
        [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
        [closeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        closeBtn.titleLabel.font = FONT(12);
        [closeBtn addTarget:self action:@selector(removeSeleFromSuperView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeBtn];
        
        _image = [UIImageView newAutoLayoutView];
        _image.backgroundColor = [UIColor cyanColor];
        [contentView addSubview:_image];
        
        _bodyLabel = [UILabel newAutoLayoutView];
        [self.bodyLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.bodyLabel setNumberOfLines:0];
        [self.bodyLabel setTextAlignment:NSTextAlignmentLeft];
        [self.bodyLabel setTextColor:[UIColor darkGrayColor]];
        self.bodyLabel.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.1];
        [contentView addSubview:self.bodyLabel];
        
        [_image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentView.mas_top);
            make.left.equalTo(contentView.mas_left).with.offset(10);
            make.right.equalTo(contentView.mas_right).with.offset(-10);
            make.bottom.equalTo(_bodyLabel.mas_top).with.offset(-10);
        }];
        
        [_bodyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_image.mas_bottom).with.offset(10);
            make.left.equalTo(contentView.mas_left).with.offset(20);
            make.right.equalTo(contentView.mas_right).with.offset(-20);
            make.bottom.equalTo(contentView.mas_bottom).with.offset(-10);
        }];
    }
    return self;
}


#pragma mark - process
- (void)removeSeleFromSuperView:(UIButton *)sender
{
    [self removeFromSuperview];
}


@end
