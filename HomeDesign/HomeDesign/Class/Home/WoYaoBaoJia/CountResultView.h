//
//  CountResultView.h
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/17.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountResultView : UIView

@property (nonatomic, copy) NSString *chanping;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *cp;
@property (nonatomic, copy) NSString *create_at;
@property (nonatomic, copy) NSString *fan;
@property (nonatomic, copy) NSString *jieguo;
@property (nonatomic, copy) NSString *mianji;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *ting;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *wei;


- (instancetype)initWithJieguo:(NSString *)jieguo;

@end
