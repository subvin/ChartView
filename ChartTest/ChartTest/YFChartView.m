//
//  YFChartView.m
//  ChartTest
//
//  Created by Vincent Wang on 16/6/28.
//  Copyright © 2016年 subvin.inc. All rights reserved.
//

#import "YFChartView.h"
#import "YFLayer.h"
#import "YFSharplayer.h"

@implementation YFChartView


static float values[31] = {};

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = CBColor(5,44,70);
        _width = self.bounds.size.width - 40;
        _sectionWidth = _width/6.0;
        _rowSectionHeight = _width/30.0f;
        
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 15)];
        _titleLabel.hidden = YES;
        _titleLabel.text = @"5.65";
        _titleLabel.font = [UIFont systemFontOfSize:11.0f];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.backgroundColor = [UIColor greenColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        
        [self addGestureRecognizer:tap];
        
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        
        [self addGestureRecognizer:pan];
        
        [self initLayer];
        
        [self reloadData];
    }
    return self;
}

-(void)tap:(UITapGestureRecognizer *)gesture_tap
{
    _point = [gesture_tap locationInView:self];
    if ([self isTouchInGrid:_point]) {

        [self setlabelBackgroundAndPositionByPosition:_point];
        
    }else
    {
        _titleLabel.hidden = YES;
    }
    
}

-(void)pan:(UIPanGestureRecognizer *)gesture_pan
{
    _point = [gesture_pan locationInView:self];
    if ([self isTouchInGrid:_point]) {
        
        [self setlabelBackgroundAndPositionByPosition:_point];
    }else
    {
        _titleLabel.hidden = YES;
    }

}


-(BOOL)isTouchInGrid:(CGPoint)point
{
    if (point.x< 15 || point.x > _width + 25 ) {
        return NO;
    }
    if (point.y < 15 || point.y > 30 + _sectionWidth * 7.0) {
        return NO;
    }
    return YES;
}

-(void)setlabelBackgroundAndPositionByPosition:(CGPoint)point
{
    CGFloat colWidth = _sectionWidth/5.0;
    CGFloat x = (point.x - 15.0)/(colWidth);
    int floorIndexX = floorf(x);
    int ceilIndexX = ceilf(x);
    
    
    //   求出直线方程   y = k * x + b;   k = (y2 -y1)/(x2 - x1);   x2 -x1 = colWidth;
    
    
    CGFloat floorY1 = (0 == floorIndexX)?  values[0] * _sectionWidth  + 5:values[floorIndexX] * _sectionWidth + 5.0f;
    CGFloat ceilY2 = values[ceilIndexX] * _sectionWidth + 5.0f;
    
    CGFloat diffY = ceilY2 - floorY1;
    CGFloat k = diffY/colWidth;
    CGFloat b = ceilY2 - k * ceilIndexX; //   b = y - k *x;
    
    CGFloat valueY = k * x + b;
    
    
    
    CGRect frame = _titleLabel.frame;
    frame.origin = CGPointMake(_point.x - 10.0, valueY );
    _titleLabel.hidden = NO;
    _titleLabel.text = [NSString stringWithFormat:@"%.2f",valueY];
    _titleLabel.frame = frame;
    
    if (valueY <= ( _sectionWidth  + 5)) {
        
        _titleLabel.backgroundColor = [UIColor redColor];
    }else if (valueY <= ( _sectionWidth * 5.0  + 5)){
        _titleLabel.backgroundColor = [UIColor greenColor];
    }else if (valueY < _sectionWidth * 6.0 + 5){
        _titleLabel.backgroundColor = [UIColor yellowColor];
    }else
    {
        _titleLabel.backgroundColor = [UIColor redColor];
    }
    
}


-(void)initLayer
{
    CGFloat width = self.bounds.size.width - 40;
    CGFloat sectionWidth = width/6.0;
    
    
    _gradientLayer = [YFLayer layer];
    
    _gradientLayer.frame = CGRectMake(15, 15, kScreenWidth - 30, sectionWidth * 7 + 10);
    
    [self.layer insertSublayer:_gradientLayer atIndex:0];
    [_gradientLayer setNeedsDisplay];
    
    
    _shapeLayer = [YFSharplayer layer];
    _shapeLayer.fillColor = [[UIColor clearColor]CGColor];
    _shapeLayer.strokeColor = [[UIColor cyanColor] CGColor];
    _shapeLayer.backgroundColor = [[UIColor clearColor] CGColor];
    _shapeLayer.lineJoin = kCALineJoinBevel;
    _shapeLayer.lineCap = kCALineCapRound;
    _shapeLayer.frame = CGRectMake(0, 0, kScreenWidth - 30, sectionWidth * 7 + 10);
    _shapeLayer.lineWidth = 1.5f;
    [self.layer insertSublayer:_shapeLayer atIndex:1];
    
}

-(CGPathRef)path
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGFloat width = self.bounds.size.width - 40;
    CGFloat sectionWidth = width/6.0;
    CGFloat rowSectionHeight = width/30.0f;
    
    [path moveToPoint:CGPointMake(5, values[0] * _sectionWidth  + 5)];
    
    [path addArcWithCenter:CGPointMake(5 , values[0] * _sectionWidth + 5.0f ) radius:2.0 startAngle:0 endAngle:360 clockwise:YES];
    
    for(int i = 0 ;i < 31 ; i++){
        
        if (0 == i) {

            continue;
        }
        CGFloat height = values[i] * sectionWidth + 5.0f;
        
        [path addLineToPoint:CGPointMake(5 + i * rowSectionHeight, height)];
        [path moveToPoint:CGPointMake(5 + i * rowSectionHeight, height)];
        
        if (0 == i % 5) {
            [path addArcWithCenter:CGPointMake(5 + i * rowSectionHeight , height ) radius:2.0 startAngle:0 endAngle:360 clockwise:YES];
        }
    }
    
    
    return path.CGPath;
}

-(void)reloadData
{
    for (int i = 0; i < 31; i ++) {
        values[i] = arc4random()%8;
    }
    _shapeLayer.path = [self path];
    
    [_shapeLayer setNeedsDisplay];
    [_gradientLayer setMask:_shapeLayer];
}


-(void)draGrid
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();//获取当前ctx
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(ctx, 0.6f);  //线宽
    CGContextSetAllowsAntialiasing(ctx, YES);
    CGContextSetRGBStrokeColor(ctx, 44/255.0, 219/255.0, 216/255.0, 1.0);  //颜色
    CGContextBeginPath(ctx);
    
    CGFloat width = self.bounds.size.width - 40;
    CGFloat sectionWidth = width/6.0;
    CGFloat rowSectionHeight = width/30.0f;
    
    //网格的横线
    for(int j = 0 ;j < 8 ; j++){
        CGContextMoveToPoint(ctx,20 ,20 + j * sectionWidth);
        CGContextAddLineToPoint(ctx, 20 + width, 20 + j * sectionWidth);
        CGContextStrokePath(ctx);
        CGContextDrawPath(ctx, kCGPathFillStroke);
    }
    NSArray *xlabels = [NSArray arrayWithObjects:@"0",@"5",@"10",@"15",@"20",@"25",@"30",nil];
    //网格竖线  先画实线
    for(int i = 0 ;i < 7 ; i++){
        CGContextSetRGBStrokeColor(ctx, 44/255.0, 219/255.0, 216/255.0, 1.0);  //颜色
        CGContextMoveToPoint(ctx, 20 + i * sectionWidth, 20 );
        CGContextAddLineToPoint(ctx, 20 + i * sectionWidth, 7 * sectionWidth + 20.0f);
        CGContextStrokePath(ctx);
    }
    for(int i = 0 ;i < 7 ; i++){

        UIFont *font = [UIFont systemFontOfSize:15];
        NSString *text = xlabels[i];
        CGContextSetLineWidth(ctx, 0.8);
        CGContextSetRGBFillColor(ctx, 1.0, 1.0, 1.0, 0.7);
        
        [text drawInRect:CGRectMake(20 + i * sectionWidth - 10 , 7 * sectionWidth + 20.0f, 44, 22) withFont:font];
    }
    //画虚线  不把它和实线在一起画，由于放在一起的时候，一旦画了虚线，实线效果就出不来，暂时没解决这个问题
    
    for(int i = 0 ;i < 31 ; i++){
        if(0 != i%5)
        {
            CGContextSetRGBStrokeColor(ctx, 1.0, 1.0, 1.0, 0.6);  //颜色
            CGContextSetLineWidth(ctx, 0.8f);  //线宽
            CGFloat lengths[] = {3,1.5,2,1.5,5,0};
            CGContextSetLineDash(ctx, 0.f, lengths, 6);
            CGContextMoveToPoint(ctx, 20 + i * rowSectionHeight, 20 );
            CGContextAddLineToPoint(ctx, 20 + i * rowSectionHeight, 7 * sectionWidth + 20.0f);
            CGContextStrokePath(ctx);
        }
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self draGrid];
    
    
}


@end
