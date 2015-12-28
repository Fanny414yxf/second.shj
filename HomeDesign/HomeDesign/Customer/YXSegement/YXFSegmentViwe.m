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
    NSArray *titles;
}

@end


@implementation YXFSegmentViwe



- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        titles = @[@"原装正品", @"增项全免", @"延期赔付", @"环保承诺"];
       [self reload];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleArr = [NSArray arrayWithArray:titleArr];
       
    }
    return self;
}

- (void)setTitleArr:(NSArray *)titleArr
{
    titles = [NSArray arrayWithArray:titleArr];
    _titleArr = titleArr;
    [self reload];
}


- (void)setDataSource:(id<YXFSegmentDataSource>)dataSource{
    _dataSource = dataSource;
    [self reload];
}

- (void)reload{
    NSMutableString *titilestring;
    for (NSString *str in titles) {
        [titilestring stringByAppendingString:str];
    }
    
    for (NSInteger i  = 0; i < titles.count; i ++) {
        UIButton *button = [[YXFSegmentItemButton alloc] init];
        button.frame = RECT(0 + i * SCREEN_WIDTH/4, 5, SCREEN_WIDTH / 4, 30);
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(handleBUtton:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [self addSubview:button];
        
        UIImageView *line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_line"]];
        line.frame = RECT(ORIGIN_X_ADD_SIZE_W(button), 12.5, 1, 15);
        [self addSubview:line];
        
        i == 3 ? (line.hidden = YES):(line.hidden = NO);
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