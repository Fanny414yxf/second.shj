//
//  YXFSegmentViwe.h
//  HomeDesign
//
//  Created by 杨晓芬 on 15/11/17.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>



@class YXSegmentView;

@protocol YXFSegmentDelegate <NSObject>



@end

@protocol YXFSegmentDataSource <NSObject>

@end



@interface YXFSegmentViwe : UIView

@property (nonatomic, assign) id <YXFSegmentDataSource> dataSource;
@property (nonatomic, assign) id <YXFSegmentDelegate> delegate;

//block属性
@property (nonatomic, copy) BlockBtnClick buttn;
//自定义block方法
- (void)handleButtonAction:(BlockBtnClick)block;


- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr;

- (void)reload;

@end



@interface YXFSegmentItemButton : UIButton

@end
