//
//  ViewController.m
//  ChartTest
//
//  Created by Vincent Wang on 16/6/28.
//  Copyright © 2016年 subvin.inc. All rights reserved.
//

#import "ViewController.h"
#import "YFChartView.h"

@interface ViewController ()


@property(nonatomic,strong)YFChartView *chartView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YFChartView *chartV = [[YFChartView alloc] initWithFrame:CGRectMake(0, 30, kScreenWidth , kScreenheight - 100)];
    _chartView = chartV;
    [self.view addSubview:chartV];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(120, chartV.bounds.size.height - 41, 100, 40);
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn setTitle:@"刷新" forState:UIControlStateNormal];
    [btn setTitle:@"刷新" forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(reloadData) forControlEvents:UIControlEventTouchUpInside];
    [chartV addSubview:btn];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)reloadData
{
    [_chartView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
