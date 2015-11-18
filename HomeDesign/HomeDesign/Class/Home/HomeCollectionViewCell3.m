//
//  HomeCollectionViewCell3.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/11/18.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "HomeCollectionViewCell3.h"

@interface HomeCollectionViewCell3 ()


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
            
            UIImageView *image = [[UIImageView alloc] initWithFrame:RECT(10, 5, 50, 50)];
            image.layer.cornerRadius = 25;
            image.center = CGPointMake( 50, frame.size.height / 2);
            image.tag = i;
            i == 0 ? (image.image = [UIImage imageNamed:@"zunxiangjia"]) : (image.image = [UIImage imageNamed:@"haikuan"]);
            [layerView addSubview:image];
            [image mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(layerView.mas_left).with.offset(5);
                make.centerY.equalTo(layerView.mas_centerY);
                make.width.and.height.mas_equalTo(50);
            }];
            
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
                make.left.equalTo(image.mas_right).with.offset(3);
                make.right.equalTo(layerView.mas_right);
                make.height.mas_equalTo(20);
            }];
            
            UILabel *labledetail = [[UILabel alloc] init];
            labledetail.textAlignment = NSTextAlignmentLeft;
            labledetail.tag = 20 + i;
            i == 0 ? (labledetail.text = @"时代尊享，就在生活家") :(labledetail.text = @"剩余 0 套");
            [labledetail sizeToFit];
            labledetail.textColor = [UIColor yellowColor];
            labledetail.font = FONT(SCREEN_SCALE_WIDTH(12));
            [layerView addSubview:labledetail];
            [labledetail mas_makeConstraints:^(MASConstraintMaker *make) {
                i == 0 ? (make.top.equalTo(layerView.mas_centerY).with.offset(2)) : (make.centerY.equalTo(layerView.mas_centerY).offset(3));
                make.left.equalTo(label);
                make.top.equalTo(label.mas_bottom).with.offset(3);
                make.right.equalTo(layerView.mas_right);
                make.height.mas_equalTo(20);
            }];
            if (i==1) {
                UILabel *timelabel = [[UILabel alloc] init];
                timelabel.text = @"26:38:45";;
                labledetail.font = FONT(SCREEN_SCALE_WIDTH(10));
                timelabel.tag = 30;
                timelabel.textAlignment = NSTextAlignmentLeft;
                timelabel.textColor = [UIColor whiteColor];
                [timelabel sizeToFit];
                [layerView addSubview:timelabel];
                [timelabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.and.right.equalTo(labledetail);
                    make.top.equalTo(labledetail.mas_bottom).with.offset(5);
                }];
            }
            
            UIButton *button = [[UIButton alloc] initWithFrame:self.contentView.frame];
            button.tag = i+10;
            [button addTarget:self action:@selector(handleButtoncell3:) forControlEvents:UIControlEventTouchUpInside];
            [layerView addSubview:button];
        }
    }
    return self;
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

@end
