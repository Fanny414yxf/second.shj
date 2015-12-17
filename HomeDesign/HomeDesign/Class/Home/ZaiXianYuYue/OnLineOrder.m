//
//  OnLineOrder.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/7.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "OnLineOrder.h"


@interface OnLineOrder ()

@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) UIDynamicAnimator *animator;

@end

@implementation OnLineOrder


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.5];
        
        _view = [[UIView alloc] initWithFrame:RECT(0, SCREEN_HEIGHT - 180, SCREEN_WIDTH, 140)];
        _view.backgroundColor = [UIColor whiteColor];
        [self addSubview:_view];
    
        NSArray *imagename = @[@"zaixinyuyu_tel", @"zaixinyuyu_yuyue", @"zaixinyuyu_online"];
        NSArray *textArr = @[@"400-122-100", @"快速预约", @"在线咨询"];
        for (NSInteger i = 0; i < 3; i ++) {
            CGFloat center_x = SCREEN_WIDTH / 6;
            UIImageView *image = [[UIImageView alloc] initWithFrame:RECT(0, 0 , 60, 60)];
            image.tag = 30 + i;
            image.image = [UIImage imageNamed:imagename[i]];
            [_view addSubview:image];
            
            UILabel *label = [[UILabel alloc] initWithFrame:RECT(0, 0, SCREEN_WIDTH/3, 20) textAlignment:NSTextAlignmentCenter font:FONT(12) textColor:[UIColor blackColor]];
            label.tag = 40 + i;
            label.text = textArr[i];
            [_view addSubview:label];
            
            image.center = CGPointMake(center_x * 3 , 150);
            label.center = CGPointMake(center_x * 3, 150);
            
            UIButton *button = [[UIButton alloc] initWithFrame:RECT(0 + i * (SCREEN_WIDTH/3), 0, SCREEN_WIDTH/3, 150)];
            button.tag = 50 + i;
            [button addTarget:self action:@selector(processButton:) forControlEvents:UIControlEventTouchUpInside];
            [_view addSubview:button];
        }
        
        UIButton *cancelbtn = [[UIButton alloc] initWithFrame:RECT(0, SCREEN_HEIGHT - 40, SCREEN_WIDTH, 40)];
        cancelbtn.backgroundColor = [RGBColor colorWithHexString:@"#ebebeb"];
        [cancelbtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cancelbtn.titleLabel.font = FONT(14);
        [cancelbtn addTarget:self action:@selector(removeOnLineOrderView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelbtn];
    }
    
    
    [self bounceMenu];
    return self;
}

#pragma mark - 动画
-(void)bounceMenu{
    
    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc]initWithReferenceView:_view];
    CGFloat space_x = SCREEN_WIDTH/6;
    CGFloat space_y = _view.frame.size.height/2;

    UISnapBehavior *snap1 = [[UISnapBehavior alloc]initWithItem:(UIImageView *)[_view viewWithTag:30] snapToPoint:[self imagePointOnCubicBezierWithControlPoints:space_x - 15 :space_y - 15 :space_x :space_y :1 :1]];
    [animator addBehavior:snap1];
    UISnapBehavior *snap2 = [[UISnapBehavior alloc]initWithItem:(UIImageView *)[_view viewWithTag:31] snapToPoint:[self imagePointOnCubicBezierWithControlPoints:space_x * 3 - 15 :space_y - 15 :space_x  :space_y :1 :3]];
    [animator addBehavior:snap2];
    UISnapBehavior *snap3 = [[UISnapBehavior alloc]initWithItem:(UIImageView *)[_view viewWithTag:32] snapToPoint:[self imagePointOnCubicBezierWithControlPoints:space_x - 15 * 5 :space_y - 15 :space_x * 5 :space_y :1 :5]];
    [animator addBehavior:snap3];
    UISnapBehavior *snap4 = [[UISnapBehavior alloc]initWithItem:(UILabel *)[_view viewWithTag:40] snapToPoint:[self labelPointOnCubicBezierWithControlPoints:space_x - 15 :space_y + 30 :space_x :space_y :1 :1]];
    [animator addBehavior:snap4];
    UISnapBehavior *snap5 = [[UISnapBehavior alloc]initWithItem:(UILabel *)[_view viewWithTag:41] snapToPoint:[self labelPointOnCubicBezierWithControlPoints:space_x - 15 :space_y + 30 :space_x :space_y :1 :3]];
    [animator addBehavior:snap5];
    UISnapBehavior *snap6 = [[UISnapBehavior alloc]initWithItem:(UILabel *)[_view viewWithTag:42] snapToPoint:[self labelPointOnCubicBezierWithControlPoints:space_x - 15 :space_y + 30 :space_x :space_y :1 :5]];
    [animator addBehavior:snap6];
    
    self.animator = animator;
}

//三阶贝塞尔曲线 ------------图片动画
- (CGPoint)imagePointOnCubicBezierWithControlPoints:(float)c1x :(float)c1y :(float)c2x :(float)c2y :(float)t :(NSInteger)n{
    // x = (1-t)^3 *x0 + 3*t*(1-t)^2 *x1 + 3*t^2*(1-t) *x2 + t^3 *x3
    // y = (1-t)^3 *y0 + 3*t*(1-t)^2 *y1 + 3*t^2*(1-t) *y2 + t^3 *y3
    
    CGFloat space_x = SCREEN_WIDTH/6;
    CGFloat space_y = _view.frame.size.height/2;
    
    float c0x = 0, c0y = 0;
    float c3x = space_x * n, c3y = space_y - 10;//图片最终center
    float ax, bx, cx;
    float ay, by, cy;
    float tSquared, tCubed;
    float x, y;
    
    cx = 3.0 * (c1x - c0x);
    bx = 3.0 * (c2x - c1x) - cx;
    ax = c3x - c0x - cx - bx;
    
    cy = 3.0 * (c1y - c0y);
    by = 3.0 * (c2y - c1y) - cy;
    ay = c3y - c0y - cy - by;
    
    tSquared = t * t;
    tCubed = tSquared * t;
    
    x = (ax * tCubed) + (bx * tSquared) + (cx * t) + c0x;
    y = (ay * tCubed) + (by * tSquared) + (cy * t) + c0y;
    return CGPointMake(x, y);
}

//三阶贝塞尔曲线 ------------标签动画
- (CGPoint)labelPointOnCubicBezierWithControlPoints:(float)c1x :(float)c1y :(float)c2x :(float)c2y :(float)t :(NSInteger)n{
    // x = (1-t)^3 *x0 + 3*t*(1-t)^2 *x1 + 3*t^2*(1-t) *x2 + t^3 *x3
    // y = (1-t)^3 *y0 + 3*t*(1-t)^2 *y1 + 3*t^2*(1-t) *y2 + t^3 *y3
    
    CGFloat space_x = SCREEN_WIDTH/6;
    CGFloat space_y = _view.frame.size.height/2;
    
    float c0x = 0, c0y = 0;
    float c3x = space_x * n, c3y = space_y + 40;//图片最终center
    float ax, bx, cx;
    float ay, by, cy;
    float tSquared, tCubed;
    float x, y;
    
    cx = 3.0 * (c1x - c0x);
    bx = 3.0 * (c2x - c1x) - cx;
    ax = c3x - c0x - cx - bx;
    
    cy = 3.0 * (c1y - c0y);
    by = 3.0 * (c2y - c1y) - cy;
    ay = c3y - c0y - cy - by;
    
    tSquared = t * t;
    tCubed = tSquared * t;
    
    x = (ax * tCubed) + (bx * tSquared) + (cx * t) + c0x;
    y = (ay * tCubed) + (by * tSquared) + (cy * t) + c0y;
    return CGPointMake(x, y);
}


#pragma makr - process 
- (void)removeOnLineOrderView:(UIButton *)sender
{
    [self removeFromSuperview];
}

- (void)processButton:(UIButton *)sender
{
    if (self.button) {
        self.button(sender.tag);
    }
}

- (void)handleButton:(BlockBtnClick)block
{
    self.button = block;
}

@end
