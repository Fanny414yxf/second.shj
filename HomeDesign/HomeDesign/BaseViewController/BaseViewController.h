//
//  BaseViewController.h
//  HomeDesign
//
//  Created by 杨晓芬 on 15/11/18.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, strong) UIView *navigationBarView;
@property (nonatomic, strong) UIImageView *titleImage;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIImageView *backimage;

@property (nonatomic, strong) NSDictionary *info;

//返回
- (void)backButton:(UIButton *)sender;

@end
