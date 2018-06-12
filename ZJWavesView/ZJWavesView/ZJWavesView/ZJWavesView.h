//
//  ZJWavesView.h
//  ZJWavesView
//
//  Created by abner on 2018/5/11.
//  Copyright © 2018年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 波浪类型 */
typedef NS_ENUM(NSUInteger, ZJWavesType) {
    ZJWavesTypeSin,   /**< 正弦函数波浪 */
    ZJWavesTypeCos,   /**< 余弦函数波浪 */
};

/** 波浪位置 */
typedef NS_ENUM(NSUInteger, ZJWavesViewWaveLocation) {
    ZJWavesViewWaveLocationBottom = 0,   /**< 波浪在视图的下方 */
    ZJWavesViewWaveLocationTop = 1,      /**< 波浪在视图的上方 */
};

/**
 波纹视图
 */
@interface ZJWaves : UIView

@end

/**
 自定义的波纹视图。
 IB_DESIGNABLE 这个宏定义的作用是可以通过keypath动态看到效果,实时性,不过还是需要通过在keypath中输入相关属性来设置。
 */
IB_DESIGNABLE
@interface ZJWavesView : UIView

/** 注意: 加上IBInspectable就可以可视化显示相关的属性，可用于storyboard | xib 。IBInspectable适用于iOS8以上系统*/
/** 波浪颜色 */
@property (nonatomic, strong) IBInspectable UIColor *wavesColor;
/** 波浪位置 */
#if TARGET_INTERFACE_BUILDER
@property (nonatomic, assign) IBInspectable NSUInteger location;
#else
@property (nonatomic, assign) ZJWavesViewWaveLocation location;
#endif
/** 是否有震荡效果，默认无 */
@property (nonatomic, assign) IBInspectable BOOL isAnimateWave;

/**
 快速实例化方法
 @param location 波浪位置
 @param wavesColor 波纹颜色
 @param isAnimateWave 是否有震荡效果
 */
- (instancetype)initWithFrame:(CGRect)frame
                     location:(ZJWavesViewWaveLocation)location
                   wavesColor:(UIColor *)wavesColor
                isAnimateWave:(BOOL)isAnimateWave;

+ (instancetype)waveWithFrame:(CGRect)frame
                     location:(ZJWavesViewWaveLocation)location
                   wavesColor:(UIColor *)wavesColor
                isAnimateWave:(BOOL)isAnimateWave;

@end
