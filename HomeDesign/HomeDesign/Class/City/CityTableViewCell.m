//
//  CityTableViewCell.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/11/20.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "CityTableViewCell.h"

@implementation CityTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _chooseBtn = [[UIButton alloc] initWithFrame:RECT(SCREEN_WIDTH - 80, 5, 30, 30)];
        [_chooseBtn  setImage: [UIImage imageNamed:@""] forState:UIControlStateNormal];
        _chooseBtn.backgroundColor = [UIColor orangeColor];
        _chooseBtn.hidden = YES;
        [self.contentView addSubview:_chooseBtn];
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
