//
//  RGBColor.h
//  GXJKT
//
//  Created by apple on 15/7/23.
//  Copyright (c) 2015年 成都豌豆角网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RGBColor : NSObject

/**
 *  十六进制颜色值转UIColor
 *
 *  @param color 十六进
 *
 */
+ (UIColor *)colorWithHexString: (NSString *)color;


@end
