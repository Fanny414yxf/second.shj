//
//  UserInfo.h
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/16.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property (nonatomic, copy) NSString *kCityName;

+ (UserInfo *)shareUserInfo;


@end
