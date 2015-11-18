//
//  UITextField+Shake.m
//  UITextField+Shake
//
//  Created by Andrea Mazzini on 08/02/14.
//  Copyright (c) 2014 Fancy Pixel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface  UITextField (Shake)
/**
 *  文本框抖动
 *
 *  @param times 抖动的次数
 *  @param delta 抖动的偏移量
 */
- (void)shake:(int)times withDelta:(CGFloat)delta;
/**
 *  文本框抖动
 *
 *  @param times    抖动的次数
 *  @param delta    抖动的偏移量
 *  @param interval 整个抖动的执行时间
*/
- (void)shake:(int)times withDelta:(CGFloat)delta andSpeed:(NSTimeInterval)interval;


/**
 *  Label
 *
 *  @param frame         大小
 *  @param textAlignment 字体位置
 *  @param font          字体大小
 *  @param textColor     字体颜色
 *
 */
- (instancetype)initWithFrame:(CGRect)frame textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font textColor:(UIColor *)textColor;



@end
