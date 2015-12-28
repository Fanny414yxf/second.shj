//
//  NoDataView.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/28.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "NoDataView.h"

@interface NoDataView ()

@property (nonatomic, strong) UILabel *discriptionLabel;

@end

@implementation NoDataView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:RECT(0, 0, 50, 50)];
        image.image = [UIImage imageNamed:@"icon_none_data"];
        image.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2 - 50);
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
