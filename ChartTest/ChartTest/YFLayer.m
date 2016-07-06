//
//  YFLayer.m
//  ChartTest
//
//  Created by Vincent Wang on 16/7/2.
//  Copyright © 2016年 subvin.inc. All rights reserved.
//

#import "YFLayer.h"
#import <UIKit/UIKit.h>


# define ViewWidth self.bounds.size.width
# define ViewHeight self.bounds.size.height

@implementation YFLayer



-(void)drawInContext:(CGContextRef)ctx
{
    CGFloat sectionHeight = (ViewHeight - 10)/7.0;
    CGContextAddRect(ctx, CGRectMake(0, 0, ViewWidth, sectionHeight + 5.0));
    CGContextSetRGBFillColor(ctx, 1, 0, 0, 1);
    CGContextFillPath(ctx);
    
    
    CGContextAddRect(ctx, CGRectMake(0, 5.0 + sectionHeight * 1, ViewWidth,sectionHeight * 4 ));
    CGContextSetRGBFillColor(ctx, 0, 1, 0, 1);
    CGContextFillPath(ctx);
    
    CGContextAddRect(ctx, CGRectMake(0, 5.0 + sectionHeight * 5, ViewWidth,sectionHeight * 1 ));
    CGContextSetRGBFillColor(ctx, 1, 1, 0, 1);
    CGContextFillPath(ctx);
    
    CGContextAddRect(ctx, CGRectMake(0, 5.0 + sectionHeight * 6, ViewWidth,sectionHeight * 1 + 5 ));
    CGContextSetRGBFillColor(ctx, 1, 0, 0, 1);
    CGContextFillPath(ctx);
    
    
}

@end
