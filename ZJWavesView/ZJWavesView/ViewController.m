//
//  ViewController.m
//  ZJWavesView
//
//  Created by abner on 2018/5/11.
//  Copyright © 2018年 Abnerzj. All rights reserved.
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
