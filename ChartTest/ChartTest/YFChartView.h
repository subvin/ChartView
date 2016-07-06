//
//  YFChartView.h
//  ChartTest
//
//  Created by Vincent Wang on 16/6/28.
//  Copyright © 2016年 subvin.inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFChartView : UIView

@property(nonatomic,assign)CGPoint point;
@property(nonatomic,strong)CAShapeLayer *shapeLayer;
@property(nonatomic,strong)CAGradientLayer *gradientLayer;

@property(nonatomic,strong)UILabel *titleLabel;


@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat sectionWidth;
@property(nonatomic,assign)CGFloat rowSectionHeight;


inline void drawDashLine(int i,CGFloat sectionWidth);

inline void drawLine(int i,CGFloat sectionWidth);
inline void drawVerLine(int j ,CGFloat width,CGFloat sectionWidth);

-(void)reloadData;


@end
