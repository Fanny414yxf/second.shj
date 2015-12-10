//
//  UILabel+Setting.h
//  GXJKT
//
//  Created by apple on 15/5/15.
//  Copyright (c) 2015年 成都豌豆角网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Setting)
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
/**
 *  富文本 中间有几个颜色不一样
 *
 *  @param string      要插入的不一样的文字
 *  @param changeIndex 插入下标
 *  @param last        插入长度
 *
 *  @return <#return value description#>
 */
- (NSMutableAttributedString *)attributedString:(NSString *)string changedIndex:(NSInteger)changeIndex last:(NSInteger)last;



@end
