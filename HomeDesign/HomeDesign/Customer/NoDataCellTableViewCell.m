//
//  NoDataCellTableViewCell.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/29.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "NoDataCellTableViewCell.h"

@implementation NoDataCellTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *image = [[UIImageView alloc] initWithFrame:RECT(0, 0, 50, 50)];
        image.image = [UIImage imageNamed:@"icon_none_data"];
        image.center = CGPointMake(self.bounds.size.width / 2, (SCREEN_HEIGHT - FUSONNAVIGATIONBAR_HEIGHT) / 2 - 50);
        [self addSubview:image];
        
        
        _discriptionLabel = [[UILabel alloc] initWithFrame:RECT(0, ORIGIN_Y_ADD_SIZE_H(image)+5, SCREEN_WIDTH, 30) textAlignment:NSTextAlignmentCenter font:FONT(14) textColor:[UIColor grayColor]];
        [self addSubview:self.discriptionLabel];
    }
    return self;
}

- (void)setDiscriptionString:(NSString *)discriptionString
{
    _discriptionLabel.text = discriptionString;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
