//
//  FastAppointmentViewModel.h
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/22.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FastAppointmentViewModel : ViewModerClass

/**
 快速预约
 post参数
 token  md5（"thp7hoiOK" + “yyyy-MM-dd”）
 tid=1
 loupan   string
 city   城市 string （传城市名)
 phone
 mianji 面积 int
 name 名称
 */
- (void)fasetAppointmentWithTid:(NSInteger)tid loupan:(NSString *)loupan city:(NSString *)city phone:(NSString *)phone mianji:(NSInteger)mianji name:(NSString *)name;

@end
