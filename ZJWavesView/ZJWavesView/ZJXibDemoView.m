//
//  ZJXibDemoView.m
//  ZJWavesView
//
//  Created by abner on 2018/6/12.
//  Copyright © 2018年 Abnerzj. All rights reserved.
//

#import "ZJXibDemoView.h"

@implementation ZJXibDemoView

+ (instancetype)xib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil
            ][0];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
