//
//  RegularExpressionsValidation.h
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/23.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegularExpressionsValidation : NSObject

/**
 手机号码验证
 */
+ (BOOL) validateMobile:(NSString *)mobile;

/**
 *  手机验证
 *  1开头的11位数
 *  @param phone number
 *
 *  @return 是否正确
 */
+ (BOOL)VerificationWihtPhoneNumber:(NSString *)phone;

@end
