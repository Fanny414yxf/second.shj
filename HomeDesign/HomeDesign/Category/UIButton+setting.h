
//
//  UIButton+setting.h
//  greenLandProject
//
//  Created by rimi on 15/1/8.
//  Copyright (c) 2015年 ZouJie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ActionBlock)(NSInteger tag);

@interface UIButton (setting)

@property (readonly) NSMutableDictionary *event;


- (instancetype)initWithFrame:(CGRect)frame normalimage:(UIImage *)normalImage selectImage:(UIImage *)selectImage normalTitle:(NSString *)norTitle selctedTitle:(NSString *)selectedTitle normalTitleColor:(UIColor *)normalColor selectedTitleColor:(UIColor *)selectedColor;
/**
 *  设置button不同状态下地背景颜色
 *
 *  @param backgroundColor 颜色
 *  @param state           状态
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;


@end
