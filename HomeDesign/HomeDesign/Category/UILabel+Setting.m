//
//  UILabel+Setting.m
//  GXJKT
//
//  Created by apple on 15/5/15.
//  Copyright (c) 2015年 成都豌豆角网络科技有限公司. All rights reserved.
//

#import "UILabel+Setting.h"

@implementation UILabel (Setting)
- (instancetype)initWithFrame:(CGRect)frame textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font textColor:(UIColor *)textColor
{
    if (self = [self initWithFrame:frame]) {
        self.textAlignment = textAlignment;
        self.font = font;
        self.textColor = textColor;
        
    }
    return self;
}


@end
