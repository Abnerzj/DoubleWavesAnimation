//
//  ZJWavesView.m
//  DoubleWavesAnimation
//
//  Created by abner on 2018/5/11.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "ZJWavesView.h"

@interface ZJWaves ()
/** 定时器 */
@property (nonatomic, strong) CADisplayLink *wavesDisplayLink;
/** 波纹图层 */
@property (nonatomic, strong) CAShapeLayer *wavesLayer;

@end

@implementation ZJWaves

- (instancetype)initWithFrame:(CGRect)frame
                    wavesType:(ZJWavesType)wavesType
                        waveA:(CGFloat)waveA
                        waveW:(CGFloat)waveW
                   wavesSpeed:(CGFloat)wavesSpeed
                   wavesWidth:(CGFloat)wavesWidth
                     currentK:(CGFloat)currentK
                   wavesColor:(UIColor *)wavesColor
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置属性
        self.backgroundColor = [UIColor clearColor];
        self.layer.masksToBounds = YES;
        self.alpha = 0.6;
        
        self.wavesType = wavesType;
        self.waveA = waveA;
        self.waveW = waveW;
        self.wavesSpeed = wavesSpeed;
        self.wavesWidth = wavesWidth;
        self.currentK = currentK;
        self.wavesColor = wavesColor;
        
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
        //y = waveA * cos(waveW*i + offsetX+M_PI_2)+currentK;
        //y = waveA * sin(-(waveW*i + offsetX))+currentK;
        
        // 将点连成线
        CGPathAddLineToPoint(path, nil, i, y);
    }
    
    CGPathAddLineToPoint(path, nil, _wavesWidth, 0);
    CGPathAddLineToPoint(path, nil, 0, 0);
    
    CGPathCloseSubpath(path);
    self.wavesLayer.path = path;
    
    // 使用layer 而没用CurrentContext
    CGPathRelease(path);
}

- (void)dealloc
{
    [self.wavesDisplayLink invalidate];
}

@end

@interface ZJWavesView ()
@property (nonatomic, strong) ZJWaves *firstWares;
@property (nonatomic, strong) ZJWaves *secondWares;
/** 波浪颜色 */
@property (nonatomic, strong) UIColor *wavesColor;
@end

@implementation ZJWavesView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // 添加波纹视图
        [self addWaresViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame wavesColor:nil];
}

- (instancetype)initWithFrame:(CGRect)frame wavesColor:(UIColor *)wavesColor
{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加波纹视图
        self.wavesColor = wavesColor;
        [self addWaresViews];
    }
    return self;
}

#pragma mark 添加波纹视图
- (void)addWaresViews
{
    self.firstWares = [[ZJWaves alloc] initWithFrame:self.frame wavesType:ZJWavesTypeSin waveA:12 waveW:0.5/30.0 wavesSpeed:0.02 wavesWidth:self.frame.size.width currentK:self.frame.size.height*0.5 wavesColor:self.wavesColor];
    self.secondWares = [[ZJWaves alloc] initWithFrame:self.frame wavesType:ZJWavesTypeCos waveA:13 waveW:0.5/30.0 wavesSpeed:0.04 wavesWidth:self.frame.size.width currentK:self.frame.size.height*0.5 wavesColor:self.wavesColor];
    
    [self addSubview:self.firstWares];
    [self addSubview:self.secondWares];
    
    //是否有震荡效果
    //NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(animateWave) userInfo:nil repeats:YES];
    //[[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

#pragma mark 震荡效果
- (void)animateWave
{
    [UIView animateWithDuration:1.0f animations:^{
        self.firstWares.transform = CGAffineTransformMakeTranslation(0, -self.firstWares.frame.origin.y);
        self.secondWares.transform = CGAffineTransformMakeTranslation(0, -self.secondWares.frame.origin.y);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0f animations:^{
            self.firstWares.transform = CGAffineTransformMakeTranslation(0, 0);
            self.secondWares.transform = CGAffineTransformMakeTranslation(0, 0);
        } completion:nil];
    }];
}

- (UIColor *)wavesColor
{
    return !_wavesColor ? ZJWavesColor : _wavesColor;
}

@end

