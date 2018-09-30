//
//  RatioView.m
//  hushenlicai
//
//  Created by yuxuan on 2017/8/14.
//  Copyright © 2017年 hushenlicai. All rights reserved.
//

#import "RatioView.h"
@interface RatioView () <CAAnimationDelegate>
@property (nonatomic,strong) NSArray *numbers;
@property (nonatomic,strong) NSArray *colors;

@property (nonatomic,assign) CGFloat startAngle; // 动画开始的弧度
@property (nonatomic,assign) CGFloat endAngle; // 动画结束的弧度
@property (nonatomic,assign) NSInteger index;// 当前的动画

@property (nonatomic,assign) CGFloat total;// 总金额



@end
@implementation RatioView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

*/
- (RatioView *)initWithNumber:(NSArray *)numbers withColor:(NSArray *)colors{
    self = [super init];
    if (self) {
        self.numbers = numbers;
        self.colors = colors;
        self.backgroundColor = [UIColor whiteColor];
        self.startAngle = - M_PI_2;
        self.endAngle = 0;
        self.index = 0;
        self.total = [self getTotal];
    }
    


    return self;
}
- (void)drawRect:(CGRect)rect {
    [self.layer removeAllAnimations];
    [self startAnimation];

}
- (void)startAnimation{
    if (self.index >= self.numbers.count) {
        self.index = 0;
        return;
    }
    CGFloat lineWidth = self.frame.size.width/4;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint center = CGPointMake(self.bounds.size.width/2, CGRectGetMidY(self.bounds));
    CGFloat radius = self.frame.size.width/8 * 3;
    
    CGFloat n = [self.numbers[self.index] floatValue];
    CGFloat angle = 2*M_PI*n/self.total;
    self.endAngle = self.startAngle + angle;
    [path addArcWithCenter:center radius:radius startAngle:self.startAngle endAngle:self.endAngle clockwise:YES];
    self.startAngle = self.endAngle;
    
    CAShapeLayer *layerAnimation = [CAShapeLayer layer];
    layerAnimation.path = path.CGPath;
    layerAnimation.strokeColor = [self.colors[self.index] CGColor];
    layerAnimation.lineWidth = lineWidth;
    layerAnimation.frame = self.bounds;
    layerAnimation.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:layerAnimation];
    [self drawArcAnimation:layerAnimation withDuration:2 * n /self.total];
    
}
- (void)drawArcAnimation:(CALayer*)layer withDuration:(CGFloat)duration{
    CABasicAnimation *bas = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    bas.delegate = self;
    bas.duration = duration;
    bas.fromValue = @0;
    bas.toValue = @1;
    [layer addAnimation:bas forKey:@"arcAnimation"];
}
#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    self.index++;
    [self startAnimation];
    
}
- (CGFloat)getTotal
{
    CGFloat sum = 0;
    for (NSNumber *num in self.numbers) {
        sum += [num floatValue];
    }
    return sum;
}
@end
