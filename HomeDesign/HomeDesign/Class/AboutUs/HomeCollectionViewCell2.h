//
//  HomeCollectionViewCell2.h
//  HomeDesign
//
//  Created by apple on 15/11/13.
//  Copyright (c) 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCollectionViewCell2 : UICollectionViewCell
//图片
@property (nonatomic, strong) UIImageView *itemImage;
//标签
@property (nonatomic, strong) UILabel *titilelab;

- (void)setCellInfo:(NSString *)info;


@end
