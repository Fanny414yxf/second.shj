//
//  HomeCollectionViewCell1.h
//  HomeDesign
//
//  Created by apple on 15/11/13.
//  Copyright (c) 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCollectionViewCell1 : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UILabel *detail;

- (void)setCellInfo:(NSDictionary *)info;

@end
