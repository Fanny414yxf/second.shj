//
//  UserInfo.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/16.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "UserInfo.h"

static UserInfo *userInfo = nil;

@implementation UserInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


+ (UserInfo *)shareUserInfo
{
    if (!userInfo) {
        userInfo = [[UserInfo alloc] init];
    }
    return userInfo;
}

@end
