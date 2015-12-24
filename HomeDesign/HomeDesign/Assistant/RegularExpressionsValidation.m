//
//  RegularExpressionsValidation.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/23.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "RegularExpressionsValidation.h"

@implementation RegularExpressionsValidation

//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}


@end
