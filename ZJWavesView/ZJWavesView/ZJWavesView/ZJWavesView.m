//
//  ZJWavesView.m
//  ZJWavesView
//
//  Created by abner on 2018/5/11.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "ZJWavesView.h"

#define ZJWavesColor [UIColor colorWithRed:86/255.0f green:202/255.0f blue:139/255.0f alpha:1]

@interface ZJWaves ()

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
/** 波浪位置 */
@property (nonatomic, assign) ZJWavesViewWaveLocation location;
/** 波浪颜色 */
@property (nonatomic, strong) UIColor *wavesColor;

/** 定时器 */
@property (nonatomic, strong) CADisplayLink *wavesDisplayLink;
/** 波纹图层 */
@property (nonatomic, strong) CAShapeLayer *wavesLayer;

/**
 快速实例化方法
 */
- (instancetype)initWithFrame:(CGRect)frame
                        waveA:(CGFloat)waveA
                        waveW:(CGFloat)waveW
                   wavesSpeed:(CGFloat)wavesSpeed
                   wavesWidth:(CGFloat)wavesWidth
                     currentK:(CGFloat)currentK
                    wavesType:(ZJWavesType)wavesType
                     location:(ZJWavesViewWaveLocation)location
                   wavesColor:(UIColor *)wavesColor;

@end

@implementation ZJWaves

- (instancetype)initWithFrame:(CGRect)frame
                        waveA:(CGFloat)waveA
                        waveW:(CGFloat)waveW
                   wavesSpeed:(CGFloat)wavesSpeed
                   wavesWidth:(CGFloat)wavesWidth
                     currentK:(CGFloat)currentK
                    wavesType:(ZJWavesType)wavesType
                     location:(ZJWavesViewWaveLocation)location
                   wavesColor:(UIColor *)wavesColor
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置属性
        self.backgroundColor = [UIColor clearColor];
        self.layer.masksToBounds = YES;
        self.alpha = 0.6;
        
        _waveA = waveA;
        _waveW = waveW;
        _wavesSpeed = wavesSpeed;
        _wavesWidth = wavesWidth;
        _currentK = currentK;
        _wavesType = wavesType;
        _location = location;
        _wavesColor = wavesColor;
        
        // 初始化layer
        self.wavesLayer = [CAShapeLayer layer];
        // 设置闭环的颜色
        self.wavesLayer.fillColor = self.wavesColor.CGColor;
        // 设置边缘线的颜色
        //self.wavesLayer.strokeColor = [UIColor blueColor].CGColor;
        // 设置边缘线的宽度
        //self.wavesLayer.lineWidth = 1.0;
        //self.wavesLayer.strokeStart = 0.0;
        //self.wavesLayer.strokeEnd = 0.8;
        [self.layer addSublayer:self.wavesLayer];
        
        // 启动定时器
        self.wavesDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getCurrentWave:)];
        [self.wavesDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return self;
}

- (void)getCurrentWave:(CADisplayLink *)displayLink
{
    // 实时的位移
    _offsetX += _wavesSpeed;
    
    [self setCurrentFirstWaveLayerPath];
}

- (void)setCurrentFirstWaveLayerPath
{
    // 创建一个路径
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGFloat y = _currentK;
    // 将点移动到 x=0,y=_currentK的位置
    CGPathMoveToPoint(path, nil, 0, y);
    
    for (NSInteger i = 0.0f; i <= _wavesWidth; i++) {
        // 正弦函数波浪公式
        if (self.wavesType == ZJWavesTypeSin) {
            y = _waveA * sin(_waveW * i + _offsetX) + _currentK;
        } else { // 余弦函数波浪公式
            y = _waveA * cos(_waveW * i + _offsetX) + _currentK;
        }
        
        // 如果需要正弦函数的峰顶和余弦函数的峰底对应,可以替换成下方公式均可
        //y = _waveA * sin(-(_waveW*i + _offsetX))+_currentK;
        //y = _waveA * cos(_waveW*i + _offsetX+M_PI_2)+_currentK;
        
        // 将点连成线
        CGPathAddLineToPoint(path, nil, i, y);
    }
    
    // 波浪位置
    if (self.location == ZJWavesViewWaveLocationTop) {
        CGPathAddLineToPoint(path, nil, _wavesWidth, self.frame.size.height);
        CGPathAddLineToPoint(path, nil, 0, self.frame.size.height);
    } else {
        CGPathAddLineToPoint(path, nil, _wavesWidth, 0);
        CGPathAddLineToPoint(path, nil, 0, 0);
    }
    
    CGPathCloseSubpath(path);
    self.wavesLayer.path = path;
    
    // 使用layer 而没用CurrentContext
    CGPathRelease(path);
}

#pragma mark - setter & getter
- (void)setWavesColor:(UIColor *)wavesColor
{
    _wavesColor = wavesColor;
    
    // 设置闭环的颜色
    self.wavesLayer.fillColor = self.wavesColor.CGColor;
}

- (void)setLocation:(ZJWavesViewWaveLocation)location
{
    _location = location;
}

- (void)dealloc
{
    [self.wavesDisplayLink invalidate];
}

@end

@interface ZJWavesView ()
@property (nonatomic, strong) ZJWaves *firstWares;
@property (nonatomic, strong) ZJWaves *secondWares;
/** 震荡效果定时器 */
@property (nonatomic, strong) NSTimer *animationWaveTimer;
@end

@implementation ZJWavesView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // 添加波纹视图
        self.location = ZJWavesViewWaveLocationBottom;
        self.wavesColor = ZJWavesColor;
        self.isAnimateWave = NO;
        [self addWaresViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame location:ZJWavesViewWaveLocationBottom wavesColor:ZJWavesColor isAnimateWave:NO];
}

- (instancetype)initWithFrame:(CGRect)frame
                     location:(ZJWavesViewWaveLocation)location
                   wavesColor:(UIColor *)wavesColor
                isAnimateWave:(BOOL)isAnimateWave
{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加波纹视图
        self.location = location;
        self.wavesColor = wavesColor;
        self.isAnimateWave = isAnimateWave;
        [self addWaresViews];
    }
    return self;
}

+ (instancetype)waveWithFrame:(CGRect)frame
                     location:(ZJWavesViewWaveLocation)location
                   wavesColor:(UIColor *)wavesColor
                isAnimateWave:(BOOL)isAnimateWave
{
    return [[ZJWavesView alloc] initWithFrame:frame location:location wavesColor:wavesColor isAnimateWave:isAnimateWave];
}

#pragma mark 添加波纹视图
- (void)addWaresViews
{
    self.firstWares = [[ZJWaves alloc] initWithFrame:self.bounds waveA:12 waveW:0.5/30.0 wavesSpeed:0.02 wavesWidth:self.frame.size.width currentK:self.frame.size.height*0.5 wavesType:ZJWavesTypeSin location:self.location wavesColor:self.wavesColor];
    self.secondWares = [[ZJWaves alloc] initWithFrame:self.bounds waveA:13 waveW:0.5/30.0 wavesSpeed:0.04 wavesWidth:self.frame.size.width currentK:self.frame.size.height*0.5 wavesType:ZJWavesTypeCos location:self.location wavesColor:self.wavesColor];

    self.firstWares.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.secondWares.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self addSubview:self.firstWares];
    [self addSubview:self.secondWares];
}

#pragma mark 震荡效果
- (void)animateWave
{
    CGFloat adjustedValue = 20;
    [UIView animateWithDuration:1.0f animations:^{
        self.firstWares.transform = CGAffineTransformMakeTranslation(0, (self.location == ZJWavesViewWaveLocationBottom) ? adjustedValue : -adjustedValue);
        self.secondWares.transform = CGAffineTransformMakeTranslation(0, (self.location == ZJWavesViewWaveLocationBottom) ? adjustedValue : -adjustedValue);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0f animations:^{
            self.firstWares.transform = CGAffineTransformMakeTranslation(0, 0);
            self.secondWares.transform = CGAffineTransformMakeTranslation(0, 0);
        } completion:nil];
    }];
}

#pragma mark - setter & getter
- (void)setWavesColor:(UIColor *)wavesColor
{
    _wavesColor = wavesColor;
    
    self.firstWares.wavesColor = wavesColor;
    self.secondWares.wavesColor = wavesColor;
}

#if TARGET_INTERFACE_BUILDER
- (void)setLocation:(NSUInteger)location
{
    _location = location;
    
    self.firstWares.location = (ZJWavesViewWaveLocation)location;
    self.secondWares.location = (ZJWavesViewWaveLocation)location;
}
#else
- (void)setLocation:(ZJWavesViewWaveLocation)location
{
    _location = location;
    
    self.firstWares.location = location;
    self.secondWares.location = location;
}
#endif

- (void)setIsAnimateWave:(BOOL)isAnimateWave
{
    _isAnimateWave = isAnimateWave;
    
    if (self.animationWaveTimer) {
        [self.animationWaveTimer invalidate];
        self.animationWaveTimer = nil;
    }
    
    if (_isAnimateWave) {
        self.animationWaveTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(animateWave) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.animationWaveTimer forMode:NSRunLoopCommonModes];
    }
}

- (void)dealloc
{
    [self.animationWaveTimer invalidate];
}

@end

