//
//  NSString+MKNetworkKitAdditions.h
//  MKNetworkKitDemo
//
//  Created by Mugunth Kumar (@mugunthkumar) on 11/11/11.
//  Copyright (C) 2011-2020 by Steinlogic Consulting and Training Pte Ltd

//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
/*
 
 后面验证需拓展.  部分可适用本项目
 
 */

#import <UIKit/UIKit.h>

@interface NSString (Tools) 
typedef enum RegexType{
    isNill,
    isError,
    isRight
}RegexType;

#define MYBUNDLE_NAME @"GLResources.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]
/**
 *  从bundle里面读取图片文件
 *
 *  @param name bundle里面的图片文件名
 *
 *  @return UIImage
 */
+ (UIImage *)readBundleImageNamed:(NSString *)name;
/**
 *  MD5加密字符串
 *
 *  @param str 被加密的字符串
 *
 *  @return 加密后的字符串
 */
+ (NSString*)md5Str:(NSString*)str;


/**
 *  文本先进行DES加密。然后再转成base64
 *
 *  @param text 被加密的字符串
 *  @param key  加密的key
 *
 *  @return 加密后的字符串
 */
+ (NSString *)base64StringFromText:(NSString *)text withKey:(NSString*)key;
/**
 *  先把base64转为文本。然后再DES解密
 *
 *  @param withKey:NSString* 被解密的字符串
 *  @param key  加密的key
 *
 *  @return 解密后的字符串
 */

+ (NSString *)textFromBase64String:(NSString *)base64 withKey:(NSString*)key;
/**
 *  文本数据进行DES加密
 *
 *  @param data 被加密的data
 *  @param key  加密的key
 *
 *  @return 加密后的字符串
 */
+ (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key;
/**
 *  文本数据进行DES解密
 *
 *  @param data 被解密的data
 *  @param key  加密的key
 *
 *  @return 解密后的字符串
 */
+ (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key;
/**
 *  字符串base64加密
 *
 *  @param string 文本数据base64加密
 *
 *  @return 返回加密后的data
 */
+ (NSData *)dataWithBase64EncodedString:(NSString *)string;

//文本数据转换为base64格式字符串
/**
 *  data base64解密
 *
 *  @param data 被解密的data
 *
 *  @return 返回解密后的字符串
 */
+ (NSString *)base64EncodedStringFrom:(NSData *)data;
/**
 *  字节数组转化16进制数
 *
 *  @param bytes 字节数组
 *
 *  @return 转化后的字符串
 */
+ (NSString *) parseByteArray2HexString:(Byte[]) bytes;

/**
 *  将16进制字符串转化成NSData
 *
 *  @param hexString 被转换的字符串
 *
 *  @return 转换后的data
 */
+ (NSData*) parseHexToByteArray:(NSString*) hexString;
/**
 *  SHA 加密
 *
 *  @return 加密后的字符串
 */
- (NSString*) sha;
/**
 *  MD5加密
 *
 *  @return 加密后的字符串
 */
- (NSString *) md5;
/**
 *  返回UUID
 *
 *  @return UUID
 */
- (NSString*) uniqueString;
/**
 *  URL 里面特殊字符进行编码
 *
 *  @return 编码后的字符串
 */
//-------------------------如果调用报错,请查看消息内部内容----------------------------------------------------
- (NSString*) urlEncodedString;
/**
 *  URL里面的特殊字符解码
 *
 *  @return 解码后的字符串
 */
//-------------------------如果调用报错,请查看消息内部内容----------------------------------------------------
- (NSString*) urlDecodedString;
/**
 *  Unicode转换为汉字
 *
 *  @param unicodeStr unicode字符串
 *
 *  @return 转换后的汉字
 */
//-------------------------如果调用报错,请查看消息内部内容----------------------------------------------------
+ (NSString *)replaceUnicode:(NSString *)unicodeStr;
/**
 *  验证密码
 *
 *  @param password 密码串
 *
 *  @return 验证是否正确
 */
+ (RegexType)isValidatePassword:(NSString *)password;
/**
 *  验证真实姓名
 *
 *  @param name 姓名
 *
 *  @return 验证是否正确
 */
+ (RegexType)isValidateName:(NSString *)name;
/**
 *  验证身份证号
 *
 *  @param idCardNumber 身份证号码
 *
 *  @return 验证是否正确
 */
+ (RegexType)isValidateIdCardNumber:(NSString *)idCardNumber;
/**
 *  邮箱验证格式
 *
 *  @param candidate 被验证的字符串
 *
 *  @return 验证是否正确
 */
+ (RegexType) validateEmail: (NSString *) candidate;
/**
 *  电话号码验证
 *
 *  @param candidate 被验证的字符串
 *
 *  @return 验证是否正确
 */
+ (RegexType) isValidateTel: (NSString *) candidate;
/**
 *  只能是汉字或字母
 *
 *  @param candidate 被验证的字符串
 *
 *  @return 验证是否正确
 */
+ (RegexType) isValidateCharacter:(NSString *)candidate;
/**
 *  验证是否是数字
 *
 *  @param str 被验证的字符串
 *
 *  @return 验证是否正确
 */
+ (RegexType)isValidateNumeric:(NSString *)str;
/**
 *  验证是否包含空格
 *
 *  @param blank 被验证的字符串
 *
 *  @return 验证是否正确
 */
+(RegexType)isValidateBlank:(NSString*)blank;
/**
 *  验证数字(小数点后两位)
 *
 *  @param num 数字字符串
 *
 *  @return 验证是否正确
 */
+ (RegexType)isValidateNum:(NSString *)num;
/**
 *   只能为中文或数字
 *
 *  @param searchText 被验证的字符串
 *
 *  @return 验证是否正确
 */
+(RegexType)isValidateSearchText:(NSString *)searchText;
/**
 *  验证是否是汉字
 *
 *  @param string 被验证的字符串
 *
 *  @return 验证是否正确
 */
+(RegexType)isValidateHanzi:(NSString *)string;
/**
 *  验证匹配
 *
 *  @param string 被验证的字符串
 *  @param regex  正则表达式
 *
 *  @return 返回验证结果
 */
+ (BOOL)isValidate:(NSString *)string regex:(NSString *)regex;
/**
 *  验证匹配
 *
 *  @param string 被验证的字符串
 *  @param regex  正则表达式
 *
 *  @return 返回验证结果
 */
- (BOOL)isValidate:(NSString *)regex;

@end

