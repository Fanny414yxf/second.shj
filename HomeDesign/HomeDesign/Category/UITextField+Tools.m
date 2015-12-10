//
//  UITextField+Tools.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/3.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "UITextField+Tools.h"

@implementation UITextField (Tools)

- (instancetype)initWithFrame:(CGRect)frame textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font textColor:(UIColor *)textColor
{
    if (self = [self initWithFrame:frame]) {
        self.textAlignment = textAlignment;
        self.font = font;
        self.textColor = textColor;
    }
    return self;
}


- (void)drawPlaceholderInRect:(CGRect)rect
{
    [self.placeholder drawInRect:rect withFont:self.font];
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(15, 15, bounds.size.width, bounds.size.height);
    return inset;
}


@end
