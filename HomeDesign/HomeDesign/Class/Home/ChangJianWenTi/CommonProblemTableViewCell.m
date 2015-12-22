//
//  CommonProblemTableViewCell.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/7.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "CommonProblemTableViewCell.h"

#define kLabelHorizontalInsets      15.0f
#define kLabelVerticalInsets        10.0f

@interface CommonProblemTableViewCell ()
{
    CGFloat pro_y;
    CGFloat pro_h;
    CGFloat pro_w;
    CGFloat ansbg_y;
    CGFloat ansbg_h;
    CGFloat ans_y;
    CGFloat ans_h;
    
    CGRect pro_frame;
    CGRect ans_frame;
    CGRect ansbg_frame;
    UIView *linev;
    UIView *lineh;
}

@property (nonatomic, strong) UILabel *problemLabel;
@property (nonatomic, strong) UIView *answerbgViewbg;
@property (nonatomic, strong) UILabel *answerLabel;

@end

@implementation CommonProblemTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _problemLabel = [[UILabel alloc] initWithFrame:RECT(2, 5, SCREEN_WIDTH/2, 30) textAlignment:NSTextAlignmentCenter font:FONT(12) textColor:[UIColor whiteColor]];
        _problemLabel.backgroundColor = [RGBColor colorWithHexString:MAINCOLOR_GREEN];
        [_problemLabel sizeToFit];
        [self.contentView addSubview:_problemLabel];
        
        _answerbgViewbg = [[UIView alloc] initWithFrame:RECT(30, ORIGIN_Y_ADD_SIZE_H(_problemLabel) - _problemLabel.frame.size.height / 2, SCREEN_WIDTH - 40, 120)];
        _answerbgViewbg.backgroundColor = [RGBColor colorWithHexString:@"#eeeeee"];
        [self.contentView insertSubview:_answerbgViewbg belowSubview:_problemLabel];
        
        _answerLabel = [[UILabel alloc] initWithFrame:RECT(10, _problemLabel.frame.size.height / 2 , SIZE_W(_answerbgViewbg) - 20, 100)];
        _answerLabel.textAlignment = NSTextAlignmentLeft;
        _answerLabel.font = FONT(12);
        _answerLabel.userInteractionEnabled = NO;
        _answerLabel.numberOfLines = 0;
        _answerLabel.adjustsFontSizeToFitWidth = YES;
        [_answerbgViewbg addSubview:_answerLabel];
        
        //*****************************两条线条
        linev = [[UILabel alloc] init];
        linev.backgroundColor = [UIColor blackColor];
        [_problemLabel addSubview:linev];
        
        lineh = [[UILabel alloc] init];
        lineh.backgroundColor = [UIColor blackColor];
        [_problemLabel addSubview:lineh];
        
     }
    return self;
}


- (void)setCellInfo:(ChangjianWentiModel *)info;
{
    _problemLabel.text = [NSString stringWithFormat:@"%@", info.title];
    _answerLabel.text = [NSString stringWithFormat:@"%@", info.content];
    
    [self cellHeightForRowAtIndexPath:info];
}

- (void)cellHeightForRowAtIndexPath:(ChangjianWentiModel *)dic
{
    
    UILabel *labe = _problemLabel;
    labe.font = FONT(12);
    labe.textAlignment = NSTextAlignmentCenter;
    [labe sizeToFit];
    CGFloat width = labe.frame.size.width;
    
    //****************************问题
    CGRect proframe = _problemLabel.frame;
    //文字高度
    proframe.size.height = [_problemLabel.text boundingRectWithSize:CGSizeMake(proframe.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:[NSDictionary dictionaryWithObjectsAndKeys:_problemLabel.font,NSFontAttributeName, nil] context:nil].size.height;
    //实际高度 = 文字高度 + 15 （看起比较自然）
    _problemLabel.frame = RECT(2, 5, width + 20, proframe.size.height + 15);
    
    linev.frame = RECT(_problemLabel.frame.size.width, 0, 1, 30);
    lineh.frame = RECT(0, _problemLabel.frame.size.height, _problemLabel.frame.size.width , 1);
    
    //label 行间距
    NSMutableAttributedString * attributedString2 = [[NSMutableAttributedString alloc] initWithString:dic.content];
    NSMutableParagraphStyle * paragraphStyle2 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle2 setLineSpacing:6];
    [attributedString2 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle2 range:NSMakeRange(0, [dic.content length])];
    [_answerLabel setAttributedText:attributedString2];
    //***************************答案
    CGRect txtFrame = _answerLabel.frame;
    txtFrame.size.height =[_answerLabel.text boundingRectWithSize:CGSizeMake(txtFrame.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:[NSDictionary dictionaryWithObjectsAndKeys:_answerLabel.font,NSFontAttributeName, nil] context:nil].size.height;
    _answerLabel.frame = CGRectMake(10, 10 + _problemLabel.frame.size.height / 2, SIZE_W(_answerbgViewbg) - 20, txtFrame.size.height);
    
    
    CGFloat ansng_y = 5 + _problemLabel.frame.size.height / 2;
    CGFloat ansng_h = _problemLabel.frame.size.height / 2 + txtFrame.size.height + 20;
    _answerbgViewbg.frame = RECT(30, ansng_y, SCREEN_WIDTH - 40, ansng_h);
    
    self.cellHeight = _problemLabel.frame.size.height/2 + _answerbgViewbg.frame.size.height + 30;    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
