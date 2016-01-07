//
//  GuideViewController.h
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/30.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GuideViewControllerDelegate <NSObject>

- (void)removeGuideWindow;
- (void)pageControlSetPage:(UIPageControl *)control;

@end

@interface GuideViewController : UIViewController

@property(nonatomic, strong)UIScrollView * scrollView;
@property(nonatomic, strong)UIPageControl * pageControl;

@property (nonatomic, assign) id <GuideViewControllerDelegate> delegate;

@end
