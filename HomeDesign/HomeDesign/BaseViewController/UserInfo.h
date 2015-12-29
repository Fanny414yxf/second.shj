//
//  UserInfo.h
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/16.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property (nonatomic, copy) NSString *currentCityName;//当前定位城市
@property (nonatomic, copy) NSString *kCityName;//选择城市
@property (nonatomic, assign) NSInteger cityID;//选择城市的id
@property (nonatomic, copy) NSString * zaixianzixunLink;//当前城市的在线咨询
@property (nonatomic, copy) NSString *phoneNumber;//生活家电话

+ (UserInfo *)shareUserInfo;


@end
