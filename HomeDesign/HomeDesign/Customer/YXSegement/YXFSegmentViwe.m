//
//  YXFSegmentViwe.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/11/17.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "YXFSegmentViwe.h"

@interface YXFSegmentViwe ()
{
    CGRect oldrect;
    UIButton *tempbtn;
}

@property (nonatomic, strong) NSArray *titleArr;
@end


@implementation YXFSegmentViwe

- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleArr = [NSArray arrayWithArray:titleArr];
        
    }
    return self;
}


- (void)setDataSource:(id<YXFSegmentDataSource>)dataSource{
    _dataSource = dataSource;
    [self reload];
}

- (void)reload{
    
    CGFloat space_width = (SCREEN_WIDTH - [self fontText:@"原装正品增项全免0延期环保不达标全额退款" withFontHeight:30]) / 16;
    
    for (NSInteger i  = 0; i < self.titleArr.count; i ++) {
        UIButton *button = [[YXFSegmentItemButton alloc] init];
        button.frame = RECT(oldrect.origin.x + oldrect.size.width, 5, [self fontText:self.titleArr[i] withFontHeight:20], 30);
        [button setTitle:self.titleArr[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(handleBUtton:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [self addSubview:button];
        
        
        //重置frame
        RESET_FRAME_ORIGIN_X(button, ORIGIN_X_ADD_SIZE_W(tempbtn) + 1);
        if (SCREEN_HEIGHT < 667) {
            RESET_FRAME_SIZE_WIDTH(button, [self fontText:self.titleArr[i] withFontHeight:30]);
        }else if(SCREEN_HEIGHT == 667 || SCREEN_HEIGHT > 667){
            RESET_FRAME_SIZE_WIDTH(button, [self fontText:self.titleArr[i] withFontHeight:30] + space_width);
        }
        
        UIImageView *line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
        line.frame = RECT(ORIGIN_X_ADD_SIZE_W(tempbtn), 10, 1, 20);
        [self addSubview:line];
        
        i == 0 ? (line.hidden = YES):(line.hidden = NO);

        oldrect = button.frame;
        tempbtn = button;
    }
}

#pragma mark 计算字体宽度
- (CGFloat)fontText:(NSString *)text withFontHeight:(CGFloat)height{
    CGFloat padding = 20;
    NSDictionary *fontAttribute = @{NSFontAttributeName : [UIFont systemFontOfSize:SCREEN_SCALE_WIDTH(14)]};
    CGSize fontSize = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:fontAttribute context:nil].size;
    return fontSize.width + padding;
}

#pragma mark - process
- (void)handleBUtton:(UIButton *)sender
{
    if (self.buttn) {
        self.buttn(sender.tag);
    }
}

- (void)handleButtonAction:(BlockBtnClick)block{
    self.buttn = block;
}

@end


@implementation YXFSegmentItemButton

- (instancetype)init{
    if (self = [super init]) {
        [self.titleLabel setFont:[UIFont systemFontOfSize:SCREEN_SCALE_WIDTH(14)]];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    if (self.selected) {
        CGFloat lineWidth = 2.5;
        CGColorRef color = self.titleLabel.textColor.CGColor;
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(ctx, color);
        CGContextSetLineWidth(ctx, lineWidth);
        CGContextMoveToPoint(ctx, 0, self.frame.size.height - lineWidth);
        CGContextAddLineToPoint(ctx, self.frame.size.width, self.frame.size.height);
        CGContextStrokePath(ctx);
    }
}

@end