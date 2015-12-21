//
//  HaiKuanViewModel.h
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/21.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HaikuanModel.h"

@interface HaiKuanViewModel : ViewModerClass

/**
 *  获取嗨款列表
 */
- (void)getHaiKuanListWithCityID:(NSString*)ID type:(NSNumber *)type row:(NSNumber*)row page:(NSNumber*)page show:(NSString *)show;

@end
