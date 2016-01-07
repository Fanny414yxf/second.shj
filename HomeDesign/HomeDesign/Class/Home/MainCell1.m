//
//  MainCell1.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/12.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "MainCell1.h"

@interface MainCell1 ()

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *itemImageTopToItenTop;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *itemImageSpaceToNew_w;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *mageNewTopTopCellTop;


@property (strong, nonatomic) IBOutlet NSLayoutConstraint *itemTopToItemImageBotton_h;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *ItemImageBottonToCellBottn;

@end

@implementation MainCell1

- (void)setCellInfo:(NSDictionary *)info
{
    self.itemImageName.image = [UIImage imageNamed:info[@"image"]];
    self.itemName.text = [NSString stringWithFormat:@"%@", info[@"title"]];
}

- (void)awakeFromNib {
    // Initialization code
    
    if (isSizeOf_3_5) {
       _itemImageSpaceToNew_w.constant = -15;
    }else if (isSizeOf_4_0){
        _itemImageSpaceToNew_w.constant = -15;
    }else if (isSizeOf_4_7){
        _mageNewTopTopCellTop.constant = 12;
        _itemImageSpaceToNew_w.constant = -20;
        _itemImageTopToItenTop.constant = 6;
        _ItemImageBottonToCellBottn.constant = 25;
    }else{
        _mageNewTopTopCellTop.constant = 12;
        _itemImageSpaceToNew_w.constant = -23;
        _itemImageTopToItenTop.constant = 6;
        _ItemImageBottonToCellBottn.constant = 30;
    }
}

@end
