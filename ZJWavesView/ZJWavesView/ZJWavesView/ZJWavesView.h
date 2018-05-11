//
//  ZJWavesView.h
//  ZJWavesView
//
//  Created by abner on 2018/5/11.
//  Copyright © 2018年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ZJWavesColor [UIColor colorWithRed:86/255.0f green:202/255.0f blue:139/255.0f alpha:1]

/** 波浪类型 */
typedef enum : NSUInteger {
    ZJWavesTypeSin,   /**< 正弦函数波浪 */
    ZJWavesTypeCos,   /**< 余弦函数波浪 */
} ZJWavesType;

/**
 波纹视图
 */
@interface ZJWaves : UIView

/*
 y =Asin（ωx+φ）+C
 A表示振幅，也就是使用这个变量来调整波浪的高度
 ω表示周期，也就是使用这个变量来调整在屏幕内显示的波浪的数量
 φ表示波浪横向的偏移，也就是使用这个变量来调整波浪的流动
 C表示波浪纵向的位置，也就是使用这个变量来调整波浪在屏幕中竖直的位置。
 */

/** 水纹振幅 */
@property (nonatomic, assign) CGFloat waveA;
/** 水纹周期 */
@property (nonatomic, assign) CGFloat waveW;
/** 水纹速度 */
@property (nonatomic, assign) CGFloat wavesSpeed;
/** 水纹宽度 */
@property (nonatomic, assign) CGFloat wavesWidth;
/** 当前波浪高度Y */
@property (nonatomic, assign) CGFloat currentK;
/** 位移 */
@property (nonatomic, assign) CGFloat offsetX;
/** 波浪类型 */
@property (nonatomic, assign) ZJWavesType wavesType;
/** 波浪颜色 */
@property (nonatomic, strong) UIColor *wavesColor;

/**
 快速实例化方法
 */
- (instancetype)initWithFrame:(CGRect)frame
                    wavesType:(ZJWavesType)wavesType
                        waveA:(CGFloat)waveA
                        waveW:(CGFloat)waveW
                   wavesSpeed:(CGFloat)wavesSpeed
                   wavesWidth:(CGFloat)wavesWidth
                     currentK:(CGFloat)currentK
                   wavesColor:(UIColor *)wavesColor;

@end


/**
 自定义的波纹视图
 */
@interface ZJWavesView : UIView


/**
 快速实例化方法
 @param wavesColor 波纹颜色
 */
- (instancetype)initWithFrame:(CGRect)frame wavesColor:(UIColor *)wavesColor;

@end
