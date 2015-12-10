//
//  CommonalityMacro.h
//  RACInterfaceDome
//
//  Created by apple on 15/11/13.
//  Copyright (c) 2015年 成都豌豆角网络科技有限公司. All rights reserved.
//


#import <UIKit/UIKit.h>

#ifndef RACInterfaceDome_CommonalityMacro_h
#define RACInterfaceDome_CommonalityMacro_h

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


//输出语句
#define DDLog(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#endif




#pragma mark - Syetem
/**是否是模拟器 */
#define iPhoneSimulator    [[self getDeviceType] isEqualToString:@"iPhone Simulator"]

/** 传入参数判断系统是版本*/
#define  iOS_SYSTEM_VERSION(version) [[[UIDevice currentDevice] systemVersion] hasPrefix:[NSString stringWithFormat:@"@",version]]

/**系统是版本*/
#define  iOS_SYSTEM_VERSIONN [[UIDevice currentDevice] systemVersion]

/**传入参数,判断系统版本是多少,及以后*/
#define iOS_SYSTEM_LATER(version)   (([[[UIDevice currentDevice] systemVersion] floatValue] >= version) ? YES : NO)

/**iOS系统 */
#define iOS9               (iOS_SYSTEM_LATER(9) ? YES : NO)
#define iOS8               (iOS_SYSTEM_LATER(8) ? YES : NO)
#define iOS7               (iOS_SYSTEM_LATER(7) ? YES : NO)
#define iOS6               (iOS_SYSTEM_LATER(6) ? YES : NO)
#define iOS7_AND_LATER     (iOS_SYSTEM_LATER(7) ? YES : NO)
#define iOS8_AND_LATER     (iOS_SYSTEM_LATER(8) ? YES : NO)


//字体
#define FONT(size)                 [UIFont systemFontOfSize:size]
#define BOLDFONT(size)             [UIFont boldSystemFontOfSize:size]
//颜色
#define RGB(r,g,b)                 [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]


#pragma mark - View Frame
/**状态栏高度*/
#define STATUSBAR_HEIGHT             20
/**工具栏高度*/
#define TABBAT_HEIGHT                49
/**导航栏高度*/
#define NAVIGATIONBAR_HEIGHT         44
/**状态栏 导航栏融合高度*/
#define FUSONNAVIGATIONBAR_HEIGHT    64
/**屏幕 宽 高*/
#define SCREEN_WIDTH                 [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT                [UIScreen mainScreen].bounds.size.height
/**判断屏幕大小*/
#define isSizeOf_3_5                 (SCREEN_HEIGHT == 480 ? YES : NO)
#define isSizeOf_4_0                 (SCREEN_HEIGHT == 568 ? YES : NO)
#define isSizeOf_4_7                 (SCREEN_HEIGHT == 667 ? YES : NO)
#define isSizeOf_5_5                 (SCREEN_HEIGHT == 736 ? YES : NO)
#define isWidth320                   (SCREEN_WIDTH == 320 ? YES : NO)

#define RECT(x, y, width, height)                        (CGRect){x, y, width, height}
#define SCALERECT(x, y, width, height)                   (CGRect){SCREEN_SCALE_WIDTH(x), SCREEN_SCALE_HEIGHT(y), SCREEN_SCALE_WIDTH(width), SCREEN_SCALE_HEIGHT(height)}
#define RECT_ORIGIN(origin, width, height)               (CGRect){origin, width, height}
#define RECT_SIZE(x, y, size)                            (CGRect){x, y, size}
#define RECT_ORIGIN_SIZE(origin, size)                   (CGRect){origin, size}

#define ORIGIN(view)                                     (view.frame.origin)
#define SIZE(view)                                       (view.frame.size)
#define FRAME(view)                                      (view.frame)
#define ORIGIN_X(view)                                   (view.frame.origin.x)
#define ORIGIN_Y(view)                                   (view.frame.origin.y)
#define SIZE_W(view)                                     (view.frame.size.width)
#define SIZE_H(view)                                     (view.frame.size.height)

#define ORIGIN_Y_ADD_SIZE_H(view)                        (ORIGIN_Y(view) + SIZE_H(view))
#define ORIGIN_X_ADD_SIZE_W(view)                        (ORIGIN_X(view) + SIZE_W(view))

/**重置frame*/
#define RESET_FRAME_ORIGIN_X(view, x)                    view.frame = (CGRect){x, ORIGIN_Y(view), SIZE_W(view), SIZE_H(view)}
#define RESET_FRAME_ORIGIN_Y(view, y)                    view.frame = (CGRect){ORIGIN_X(view), y, SIZE_W(view), SIZE_H(view)}
#define RESET_FRAME_SIZE_WIDTH(view, width)              view.frame = (CGRect){ORIGIN_X(view), ORIGIN_Y(view), width, SIZE_H(view)}
#define RESET_FRAME__SIZE_HEIGHT(view, height)           view.frame = (CGRect){ORIGIN_X(view), ORIGIN_Y(view), SIZE_W(view), height}

/**原始比例缩放宽高*/
#define RESET_FRAME_SIZE_WIDTH_FROM_ORIGINAL(view)       view.frame = (CGRect){ORIGIN_X(view), ORIGIN_Y(view), SCREEN_SCALE_WIDTH(SIZE_W(view)), SIZE_H(view)}
/**根据宽高设置方形*/
#define RESET_FRAME_SQUARE_FROM_WIDTH(view)              view.frame = (CGRect){ORIGIN_X(view), ORIGIN_Y(view), SIZE_W(view), SIZE_W(view)}
/**比例设置矩形*/
#define RESET_FRAME_HEIGHT_FROM_WIDTH(view)              JUDGE_IF(view.sizeRatio.floatValue == 0.f, NSLog(@"默认比例未设置"); return;) \
view.frame = (CGRect){ORIGIN_X(view), ORIGIN_Y(view), SIZE_W(view), SIZE_W(view) / view.sizeRatio.floatValue}
/**原始比例缩放宽度, 并设置高度*/
#define RESET_FRAME_SIZE_WIDTH_FROM_ORIGINAL_AND_SET_TATIO_HEIGHT(view) \
RESET_FRAME_SIZE_WIDTH_FROM_ORIGINAL(view);\
RESET_FRAME_HEIGHT_FROM_WIDTH(view)

#pragma mark - Algorithm Maybe Changed
#define SCREEN_SCALE_WIDTH(width)                 (width * (SCREEN_WIDTH / 375.f))
#define SCREEN_SCALE_HEIGHT(height)               (height * (SCREEN_HEIGHT / (isSizeOf_3_5 ? 568.f : 667.f)))


#pragma mark - assist
//不失去第一响应的TAG
#define DONOT_RESIGN_FIRST_RESPONDER                  687
/**强制转换*/
#define CONVERTION_TYPE(classType,object)            ((classType *)object)
/**普通类型直接转为字符串*/
#define STRINGFORMAT(value)                          [NSString stringWithFormat:@"%@",value]
#define STRINGFORMATWITH_INT(value)                  [NSString stringWithFormat:@"%d",value]
/**弹出AlterView*/
#define ALERT(msg)                                   [[[UIAlertView alloc]initWithTitle:@"系统提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show]
/**打印请求日志*/
#define URL_LOG                                      NSLog(@"%@->interface:%@\n%@",method,path,[url.absoluteString stringByAppendingFormat:@"?%@",[[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding]])



