//
//  ZaiJianGongChengViewModel.h
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/21.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZaiJianGongChengViewModel : ViewModerClass

/**
 *  在建工程列表数据
 *
 *  @param ID
 *  @param type
 *  @param row
 *  @param page
 *  @param show
 */
- (void)getZaiJianGongChengList:(NSString *)ID type:(NSNumber *)type row:(NSNumber *)row page:(NSNumber *)page show:(NSString *)show;

@end
