//
//  ChangjianWentiViewModel.h
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/22.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChangjianWentiViewModel : ViewModerClass

/**
 常见问题
 */
- (void)getChangjianWentiDataWithID:(NSString *)ID  type:(NSNumber *)type row:(NSNumber*)row page:(NSNumber *)page keywords:(NSString *)keywords show:(NSString *)show lei:(NSNumber *)lei;


@end
