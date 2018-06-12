//
//  ViewController.m
//  ZJWavesView
//
//  Created by abner on 2018/5/11.
//  Copyright © 2018年 Abnerzj. All rights reserved.
//

#import "ViewController.h"
#import "ZJWavesView.h"
#import "ZJXibDemoView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.手动初始化：-initWithFrame
    ZJWavesView *wavesView = [[ZJWavesView alloc] initWithFrame:CGRectMake(0, -20, self.view.frame.size.width, 220)];
    [self.view addSubview:wavesView];
    
    // 2.手动初始化: -initWithFrame:location:wavesColor
//    ZJWavesView *wavesView = [[ZJWavesView alloc] initWithFrame:CGRectMake(0, -20, self.view.frame.size.width, 220) location:ZJWavesViewWaveLocationBottom wavesColor:[UIColor redColor]];
//    [self.view addSubview:wavesView];
    
    // 3.手动初始化: +waveWithFrame:location:wavesColor
//    ZJWavesView *wavesView = [ZJWavesView waveWithFrame:CGRectMake(0, self.view.frame.size.height - 200, self.view.frame.size.width, 220) location:ZJWavesViewWaveLocationTop wavesColor:[UIColor redColor] isAnimateWave:YES];
//    [self.view addSubview:wavesView];
    
    // 4.xib
//    ZJXibDemoView *demoView = [ZJXibDemoView xib];
//    demoView.frame = CGRectMake(0, self.view.frame.size.height - 200, self.view.frame.size.width, 220);
//    demoView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    [self.view addSubview:demoView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
