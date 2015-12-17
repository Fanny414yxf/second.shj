//
//  WebViewController.h
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/14.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : BaseViewController

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *titleString;//标题

@end
