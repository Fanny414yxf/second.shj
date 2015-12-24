//
//  IWantOrderViewModel.h
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/23.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWantOrderViewModel : ViewModerClass

/**
 *  我要报价
 *  @  token          md5("thp7hoiOK" + “yyyy-MM-dd”)
 *  @  type            7
 *  @param tid        1：我的预约 2：我的报价
 *  @param name       预约人 string
 *  @param chanpingID 产品ID int
 *  @param phone      电话 （没做电话格式判断）
 *  @param mianji     面积 int
 *  @param ting       客厅 int
 *  @param wei        卫生间 int
 *  @param shi        卧室 int
 */
- (void)IWantOrderRequestWithTid:(NSString *)tid name:(NSString *)name chanpingID:(NSString *)chanpingID phone:(NSString *)phone mianji:(NSString *)mianji ting:(NSString *)ting wei:(NSString *)wei shi:(NSString *)shi;


@end
