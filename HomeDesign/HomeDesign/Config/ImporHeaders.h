//
//  ImporHeaders.h
//  HomeDesign
//
//  Created by apple on 15/11/13.
//  Copyright (c) 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#ifndef HomeDesign_ImporHeaders_h
#define HomeDesign_ImporHeaders_h

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

//thirdlibrary
#import "UIImageView+WebCache.h"
#import "RGBColor.h"
#import "Masonry.h"
#import "UIView+HKSetConstraints.h"
#import "LxDBAnything.h"
#import "IQKeyboardManager.H"
#import "KeyboardManager.h"
#import "PureLayout.h"

//category
#import "NSString+Tools.h"
#import "NSTimer+Tools.h"
#import "UIColor+Tools.h"
#import "UIImage+Tools.h"
#import "UINavigationController+Tools.h"
#import "UITextField+Tools.h"
#import "UIResponder+Tools.h"
#import "UIButton+setting.h"
#import "UILabel+Setting.h"


//button点击事件
typedef void (^BlockBtnClick)(NSInteger tag);



//高德定位APIkey
const static NSString *GaodeAPIKey = @"070011907645813cb2b27168fba524e9"; 
#define MAINCOLOR_GREEN @"#52b615"
#define MAINCOLOR_GRAY  @"#3c3c3c"


//URL--------------HTML
#define LINBAOZHUANG_HTML @"http://test.myi120.com/shenghuojiahtml/linbaozhuang.html"
#define ZUNXIANGJIA_HTML @"http://test.myi120.com/shenghuojiahtml/zunxiangjia.html"
#define SANDITIYAN_HTML @"http://test.myi120.com/shenghuojiahtml/3d.html"
#define DEBIAOGONGYI_HTML @"http://test.myi120.com/shenghuojiahtml/debiao.html"

#endif
