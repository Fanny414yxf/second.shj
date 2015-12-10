//
//  CommonProblemTableViewCell.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/7.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "CommonProblemTableViewCell.h"

@interface CommonProblemTableViewCell ()

@property (nonatomic, strong) UILabel *problemLabel;
@property (nonatomic, strong) UIView *answerbgView;
@property (nonatomic, strong) UITextView *answerLabel;


@end

@implementation CommonProblemTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        _answerbgView = [[UIView alloc] initWithFrame:RECT(30, 15, SCREEN_WIDTH - 50, 120)];
        _answerbgView.backgroundColor = [RGBColor colorWithHexString:@"#eeeeee"];
        [self.contentView addSubview:_answerbgView];
        
        _answerLabel = [[UITextView alloc] initWithFrame:RECT(10, 15, SCREEN_WIDTH - 50, 100)];
        _answerLabel.backgroundColor = [UIColor clearColor];
        _answerLabel.text = @"    家庭装修时要怎么装修厨房？";
        [_answerbgView insertSubview:_answerLabel aboveSubview:_answerLabel];
        
        _problemLabel = [[UILabel alloc] initWithFrame:RECT(0, 5, SCREEN_WIDTH/2, 30) textAlignment:NSTextAlignmentCenter font:FONT(12) textColor:[UIColor whiteColor]];
        _problemLabel.backgroundColor = [RGBColor colorWithHexString:MAINCOLOR_GREEN];
        _problemLabel.text = @"家庭装修时要怎么装修厨房？";
        [self.contentView addSubview:_problemLabel];
        
        UIView *linev = [[UILabel alloc] initWithFrame:RECT(_problemLabel.frame.size.width - 2, 0, 1, 30)];
        linev.backgroundColor = [UIColor blackColor];
        [_problemLabel addSubview:linev];
        
        UIView *lineh = [[UILabel alloc] initWithFrame:RECT(0, _problemLabel.frame.size.height - 2, _problemLabel.frame.size.width , 1)];
        lineh.backgroundColor = [UIColor blackColor];
        [_problemLabel addSubview:lineh];
        
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
