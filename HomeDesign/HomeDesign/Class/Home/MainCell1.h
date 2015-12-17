//
//  MainCell1.h
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/12.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainCell1 : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *itemImageName;

@property (weak, nonatomic) IBOutlet UILabel *itemName;

- (void)setCellInfo:(NSDictionary *)info;

@property (strong, nonatomic) IBOutlet UIImageView *mageNew;

@end
