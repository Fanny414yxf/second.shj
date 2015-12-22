//
//  EncryptionCodeWithMD5.h
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/22.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EncryptionCodeWithMD5 : NSObject

/**
 32位加密小写
 */
+ (NSString *)getmd5_32Bit_String:(NSString *)string;


/**
 *  16位小写
 */
+(NSString *)getmd5_16Bit_String:(NSString *)str;


//AES加密iOS代码加密
//加密
- (NSString *)setAESCodeWithString:(NSString *)string;
//解密
- (NSString *)getAESCodeWithString:(NSString *)string;



//BASE64加密iOS代码加密
+ (NSString*)encodeBase64String:(NSString *)input;
+ (NSString*)decodeBase64String:(NSString *)input;
+ (NSString*)encodeBase64Data:(NSData *)data;
+ (NSString*)decodeBase64Data:(NSData *)data;

@end
