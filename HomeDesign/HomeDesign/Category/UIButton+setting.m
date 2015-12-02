//
//  UIButton+setting.m
//  greenLandProject
//
//  Created by rimi on 15/1/8.
//  Copyright (c) 2015年 ZouJie. All rights reserved.
//

#import "UIButton+setting.h"

@implementation UIButton (setting)


@dynamic event;


- (instancetype)initWithFrame:(CGRect)frame normalimage:(UIImage *)normalImage selectImage:(UIImage *)selectImage normalTitle:(NSString *)norTitle selctedTitle:(NSString *)selectedTitle normalTitleColor:(UIColor *)normalColor selectedTitleColor:(UIColor *)selectedColor
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self setImage:normalImage forState:UIControlStateNormal];
        [self setTitle:norTitle forState:UIControlStateNormal];
        [self setTitleColor:normalColor forState:UIControlStateNormal];
        if (selectImage) {
            [self setImage:selectImage forState:UIControlStateSelected];
            [self setTitle:selectedTitle forState:UIControlStateSelected];
            [self setTitleColor:selectedColor forState:UIControlStateSelected];
        }
    }
    return self;
}


- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    [self setBackgroundImage:[UIButton imageWithColor:backgroundColor] forState:state];
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (instancetype)initButtonHaveSanjiWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


@end
