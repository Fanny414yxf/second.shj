//
//  UITextField+Shake.m
//  UITextField+Shake
//
//  Created by Andrea Mazzini on 08/02/14.
//  Copyright (c) 2014 Fancy Pixel. All rights reserved.
//

#import "UITextField+Tools.h"

@implementation UITextField (Shake)


- (instancetype)initWithFrame:(CGRect)frame textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font textColor:(UIColor *)textColor
{
    if (self = [self initWithFrame:frame]) {
        self.textAlignment = textAlignment;
        self.font = font;
        self.textColor = textColor;
        
    }
    return self;
}

- (void)shake:(int)times withDelta:(CGFloat)delta
{
	[self _shake:times direction:1 currentTimes:0 withDelta:delta andSpeed:0.03];
}

- (void)shake:(int)times withDelta:(CGFloat)delta andSpeed:(NSTimeInterval)interval
{
	[self _shake:times direction:1 currentTimes:0 withDelta:delta andSpeed:interval];
}

- (void)_shake:(int)times direction:(int)direction currentTimes:(int)current withDelta:(CGFloat)delta andSpeed:(NSTimeInterval)interval
{
	[UIView animateWithDuration:interval animations:^{
		self.transform = CGAffineTransformMakeTranslation(delta * direction, 0);
	} completion:^(BOOL finished) {
		if(current >= times) {
			self.transform = CGAffineTransformIdentity;
			return;
		}
		[self _shake:(times - 1)
		   direction:direction * -1
		currentTimes:current + 1
		   withDelta:delta
			andSpeed:interval];
	}];
}
//禁用密码框的copy cut...
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if ([self.placeholder isEqualToString:@"密码"] ||[self.placeholder isEqualToString:@"请输入密码"] ||[self.placeholder isEqualToString:@"重复输入密码"]) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [[UIMenuController sharedMenuController] setMenuVisible:NO animated:NO];
        }];
    }
    return [super canPerformAction:action withSender:sender];
}
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (void)drawPlaceholderInRect:(CGRect)rect
{
    if (self.background) {
        [[UIColor lightGrayColor] setFill];
    }else {
        [[UIColor whiteColor] setFill];
    }
    [[self placeholder] drawInRect:rect withFont:self.font];
}
-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x, bounds.origin.y + iOS7_AND_LATER ? 6 : 0, bounds.size.width, bounds.size.height);
    return inset;
    
}
#pragma clang diagnostic pop
@end
