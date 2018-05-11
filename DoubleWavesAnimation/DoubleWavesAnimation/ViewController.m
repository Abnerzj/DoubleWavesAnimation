//
//  ViewController.m
//  DoubleWavesAnimation
//
//  Created by anyongxue on 2016/12/12.
//  Copyright © 2016年 cc. All rights reserved.
//

#import "ViewController.h"
#import "ZJWavesView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ZJWavesView *wavesView = [[ZJWavesView alloc] initWithFrame:CGRectMake(0, -20, self.view.frame.size.width, 220)];
    [self.view addSubview:wavesView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
