//
//  EncryptionCodeWithMD5.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/22.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "EncryptionCodeWithMD5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation EncryptionCodeWithMD5

//32位加密小写
+ (NSString *)getmd5_32Bit_String:(NSString *)string;
{
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), digest);
    NSMutableString * result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x",digest[i]];
    }
    return  result;
}


+(NSString *)getmd5_16Bit_String:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
    }
    return [hash lowercaseString];
}


//AES加密iOS代码加密
////加密
//- (NSString *)setAESCodeWithString:(NSString *)string
//{
//    return [AESCrypt encrypt:userName password:string];//加密
//}
//
// //解密
//- (NSString *)getAESCodeWithString:(NSString *)string
//{
//  return [AESCrypt decrypt:encryptedData password:string];
//}


//BASE64加密iOS代码加密
//+ (NSString*)encodeBase64String:(NSString * )input {
//    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
//    data = [GTMBase64 encodeData:data];
//    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    return base64String;
//}
//+ (NSString*)decodeBase64String:(NSString * )input {
//    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
//    data = [GTMBase64 decodeData:data];
//    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    return base64String;
//}
//+ (NSString*)encodeBase64Data:(NSData *)data {
//    data = [GTMBase64 encodeData:data];
//    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    return base64String;
//}
//+ (NSString*)decodeBase64Data:(NSData *)data {
//    data = [GTMBase64 decodeData:data];
//    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    return base64String;
//}




@end
