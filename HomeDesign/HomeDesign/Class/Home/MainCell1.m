//
//  MainCell1.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/12.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "MainCell1.h"

@interface MainCell1 ()

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *itemImageSpaceToNew_w;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *itemTopToItemImageBotton_h;

@end

@implementation MainCell1

- (void)setCellInfo:(NSDictionary *)info
{
    self.itemImageName.image = [UIImage imageNamed:info[@"image"]];
    self.itemName.text = [NSString stringWithFormat:@"%@", info[@"title"]];
}

- (void)awakeFromNib {
    // Initialization code
    if (isSizeOf_4_7 || isSizeOf_5_5) {
        _itemTopToItemImageBotton_h.constant = 3;
    }
    if (isSizeOf_4_0 || isSizeOf_3_5) {
        _itemImageSpaceToNew_w.constant = -15;
    }
}

@end
