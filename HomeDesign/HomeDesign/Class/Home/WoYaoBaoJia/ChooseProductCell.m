//
//  ChooseProductCell.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/18.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "ChooseProductCell.h"

@interface ChooseProductCell ()

@property (nonatomic, strong) UIImageView *productImage;
@property (nonatomic, strong) UILabel *productName;
@property (nonatomic, strong) UILabel *productIntroduce;

@end

@implementation ChooseProductCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *contentView = [[UIView alloc] initWithFrame:RECT(0, 0, SCREEN_WIDTH, 209)];
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.userInteractionEnabled = YES;
        [self addSubview:contentView];
        
        _productImage = [[UIImageView alloc] initWithFrame:RECT(0, 10, SCREEN_WIDTH, 160)];
        _productImage.userInteractionEnabled = YES;
        [contentView addSubview:_productImage];
        
        UIView *productlabelbg = [[UIView alloc] initWithFrame:RECT(0, 130, SCREEN_WIDTH, 30)];
        productlabelbg.backgroundColor = [UIColor colorWithHex:0.5 alpha:0.5];
        [_productImage addSubview:productlabelbg];
        
        _productIntroduce = [[UILabel alloc] initWithFrame:RECT(30, 0, SCREEN_WIDTH - 30, 30) textAlignment:NSTextAlignmentLeft font:FONT(12) textColor:[UIColor whiteColor]];
        _productIntroduce.text = @"本产品适合70-90m户型，请选择适合您的产品报价";
        [productlabelbg addSubview:_productIntroduce];
        
        
        _productName = [[UILabel  alloc] initWithFrame:RECT(30, ORIGIN_Y_ADD_SIZE_H(_productImage), SCREEN_WIDTH/2, 30) textAlignment:NSTextAlignmentLeft font:FONT(16) textColor:[RGBColor colorWithHexString:MAINCOLOR_GREEN]];
        _productName.text = @"屌丝绅士";
        [contentView addSubview:_productName];
        
        
        UIImageView *showdetailBtnbg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zaijiangongcheng_typegb"]];
        showdetailBtnbg.userInteractionEnabled = YES;
        showdetailBtnbg.clipsToBounds = YES;
        showdetailBtnbg.frame = RECT(SCREEN_WIDTH - 100, 15, 100, 30);
        showdetailBtnbg.contentMode = UIViewContentModeScaleAspectFit;
        [contentView addSubview:showdetailBtnbg];
        
        UIButton *showDetailbtn = [[UIButton alloc] initWithFrame:RECT(0, 0, 100, 30)];
        [showDetailbtn setTitle:@"查看详情" forState:UIControlStateNormal];
        [showDetailbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        showDetailbtn.titleLabel.font = FONT(12);
        [showDetailbtn addTarget:self action:@selector(handShowDetailBtn:) forControlEvents:UIControlEventTouchUpInside];
        [showdetailBtnbg addSubview:showDetailbtn];
        
        
        UITapGestureRecognizer *tapgestre = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(processSssssssssssssssselectedCell:)];
        [self addGestureRecognizer:tapgestre];
        
    }
    return self;
}

- (void)setCellInfo:(ProductListMModel *)info
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ADVIMAGE_URL, info.cover_id]];
    [_productImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"defaultimage"]];
    _productIntroduce.text = info.msg;
    _productName.text = info.title;
}

#pragma mark - process 
- (void)handShowDetailBtn:(UIButton *)sender
{
    if (self.button) {
        self.button(sender.tag);
    }
}

- (void)handleShowDetailBtn:(BlockBtnClick)block
{
    self.button = block;
}

- (void)processSssssssssssssssselectedCell:(UIGestureRecognizer *)gesture
{
    if (self.gesture) {
        self.gesture();
    }
}

- (void)selectedCell:(Gesture)block;
{
    self.gesture = block;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
