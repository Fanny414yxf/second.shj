//
//  HotShopTableViewCell.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/9.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "HotShopTableViewCell.h"


@implementation HotShopTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier row:(NSInteger)row
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView *contentView = [[UIView alloc] initWithFrame:self.bounds];
        contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:contentView];
        
        _shopImage = [[UIImageView alloc] initWithFrame:RECT(0, 5, SCREEN_WIDTH, 200)];
        _shopImage.backgroundColor = [UIColor cyanColor];
        [contentView addSubview:_shopImage];
        
        UIView *discreptionBg = [[UIView alloc] initWithFrame:RECT(0, ORIGIN_Y_ADD_SIZE_H(_shopImage), SCREEN_WIDTH, 40)];
        discreptionBg.backgroundColor = [RGBColor colorWithHexString:MAINCOLOR_GREEN];
        [contentView addSubview:discreptionBg];
        
        _shopDiscreptionLabel = [[UILabel alloc] initWithFrame:RECT(20, 0, SCREEN_WIDTH - 20, 40) textAlignment:NSTextAlignmentLeft font:FONT(14) textColor:[UIColor whiteColor]];
        _shopDiscreptionLabel.text = @"5周年珍藏版， 黄金性价比飙升";
        [discreptionBg addSubview:_shopDiscreptionLabel];
        
        UILabel *label = [[UILabel alloc] initWithFrame:RECT(SCREEN_WIDTH - 100, 20, 100, 30) textAlignment:NSTextAlignmentCenter font:FONT(12) textColor:[UIColor whiteColor]];
        label.backgroundColor = [UIColor colorWithHex:0.5 alpha:0.5];
        label.text = @"已过期";
        [contentView addSubview:label];
        
        NSArray *arr = @[@"0", @"0", @":", @"1", @"2", @":", @"4", @"6"];
        if (row == 0) {
            for (NSInteger i = 0; i < 8; i ++) {
                label.text = nil;
                discreptionBg.backgroundColor = [RGBColor colorWithHexString:@"#e0e0e0"];
                UILabel *time = [[UILabel alloc] initWithFrame:RECT(10 + i * 11, 5, 10, 15) textAlignment:NSTextAlignmentCenter font:FONT(12) textColor:[UIColor whiteColor]];
                time.text = [NSString stringWithFormat:@"%@", arr[i]];
                if (i == 2 || i == 5) {
                    time.backgroundColor = [UIColor clearColor];
                }else{
                    time.backgroundColor = [RGBColor colorWithHexString:MAINCOLOR_GREEN];
                }
                [label addSubview:time];
            }
        }
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
