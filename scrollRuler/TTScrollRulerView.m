//
//  TTScrollRulerView.m
//  标尺
//
//  Created by 天天理财 on 16/12/27.
//  Copyright © 2016年 天天理财. All rights reserved.
//

#import "TTScrollRulerView.h"

@interface TTScrollRulerView()<UIScrollViewDelegate>
{
    CGFloat _unitPX;
    UIImageView *_pointerView;
    UIScrollView *_rulerBackgroundView;
    RullerView *_rulerView;
}

@property (nonatomic,assign) NSInteger i;

@property (nonatomic,assign) BOOL pointerFrameSeted;

@end

@implementation TTScrollRulerView

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSAssert(NO, @"RULER:请以 initWithFrame 初始化！");
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSAssert(NO, @"RULER:请以 initWithFrame 初始化！");
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self start];
    }
    return self;
}

- (void)start {
    [self common];
    [self addView];
}

- (void)common {
    [self initialization];
}

- (void)initialization {
    //初始化内置参数
    _unitPX = fit(14);
    
    //初始化外部默认参数
    _unitValue = 1;
    _lockMin = 0;
    _lockMax = 360;
    _lockDefault = 10;
    _rulerWidth = ScreenW;
    _rulerHeight = fit(150);
    _rulerDirection = RulerDirectionHorizontal;
    _rulerFace = RulerFace_up_left;
    _rulerBackgroundColor = UIColorFromRGB(0xffffff);
    _isShowRulerValue = YES;
    _h_height = fit(24);
    _m_height = fit(12);
    _pointerBackgroundColor = UIColorFromRGB(0xfe2326);
    _pointerFrame = CGRectMake(selfWidth/2.0-fit(1)/2.0, selfHeight/2.0-(selfHeight>=fit(120)?fit(60):selfHeight/2.0), fit(1), selfHeight>=fit(120)?fit(60):selfHeight/2.0);
}

- (void)addView {
    _rulerBackgroundView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:_rulerBackgroundView];
    _rulerBackgroundView.delegate = self;
    _rulerBackgroundView.showsHorizontalScrollIndicator = NO;
    _rulerBackgroundView.showsVerticalScrollIndicator = NO;
    _rulerBackgroundView.alwaysBounceHorizontal = NO;
    _rulerBackgroundView.alwaysBounceVertical = NO;
    _rulerBackgroundView.bounces = NO;
    
    _pointerView = [[UIImageView alloc] initWithFrame:_pointerFrame];
    [self addSubview:_pointerView];
    _pointerView.backgroundColor = _pointerBackgroundColor;
    
}

- (BOOL)paramIsAvialiable {
    BOOL flag = YES;
    if (_lockMax <= _lockMin) {
        NSAssert(NO, @"最小值应该比最大值小");
        flag = NO;
    }
    if (_lockDefault < _lockMin || _lockDefault > _lockMax) {
        NSAssert(NO, @"默认值应该比最小值大，比最大值小");
        flag = NO;
    }
    if (_lockMin%10 != 0 || _lockMax%10 != 0 || _lockDefault%10 != 0) {
        NSLog(@"小伙子，我不是太推荐你设置的这种参数~,但是随你……");
    }
    return flag;
}

- (void)classicRuler {
    [self rulerInit];
    [_rulerView drawRuler:nil];
}

- (void)customRulerWithLineColor:(CustomeColor)lineColor NumColor:(UIColor *)numColor scrollEnable:(BOOL)enable {
    [self rulerInit];
    [_rulerView drawRuler:^{
        _rulerView.lineColor = lineColor;
        if (numColor) {
            _rulerView.txtColor = numColor;
        }
        if (enable) {
            _rulerBackgroundView.scrollEnabled = enable;
        }
    }];
}

- (void)reDrawerRuler {
    [self rulerInit];
    [_rulerView setNeedsDisplay];
}

- (void)rulerInit {
    if (![self paramIsAvialiable]) {
        return;
    }
    
//    if (_rulerView) {
//        [_rulerView removeFromSuperview];
//        _rulerView = nil;
//    }
    
    if (_rulerDirection == RulerDirectionHorizontal) {
        
        _rulerBackgroundView.contentSize = CGSizeMake(_unitPX*_lockMax/_unitValue + selfWidth, 0);
        _rulerBackgroundView.contentOffset = CGPointMake(_unitPX*_lockDefault/_unitValue, 0);
        if (!_rulerView) {
            _rulerView = [[RullerView alloc] initWithFrame:CGRectMake(0, 0, _rulerBackgroundView.contentSize.width, selfHeight)];
            [_rulerBackgroundView addSubview:_rulerView];
        }else {
            _rulerView.frame = CGRectMake(0, 0, _rulerBackgroundView.contentSize.width, selfHeight);
        }
        
        if (!_pointerFrameSeted && _rulerFace == RulerFace_down_right) {
            _pointerView.transform = CGAffineTransformMakeTranslation(0, _pointerFrame.size.height);
        }
        
    }else if (_rulerDirection == RulerDirectionVertical) {
        
        _rulerBackgroundView.contentSize = CGSizeMake(0, _unitPX*_lockMax/_unitValue + selfHeight);
        _rulerBackgroundView.contentOffset = CGPointMake(0, _unitPX*_lockDefault/_unitValue);
        if (!_rulerView) {
            _rulerView = [[RullerView alloc] initWithFrame:CGRectMake(0, 0, selfWidth, _rulerBackgroundView.contentSize.height)];
            [_rulerBackgroundView addSubview:_rulerView];
        }else {
            _rulerView.frame = CGRectMake(0, 0, selfWidth, _rulerBackgroundView.contentSize.height);
        }
        
        if (!_pointerFrameSeted && _rulerFace == RulerFace_up_left) {
//            _pointerView.transform = CGAffineTransformTranslate(_pointerView.transform,-_pointerFrame.size.height/2.0, _pointerFrame.size.height/2.0);
//            _pointerView.transform = CGAffineTransformRotate(_pointerView.transform, 3.1415927/2.0);
            _pointerView.frame = CGRectMake(selfWidth/2.0-(selfHeight>=fit(120)?fit(80):selfHeight/2.0), selfHeight/2.0-fit(1)/2.0, selfHeight>=fit(120)?fit(80):selfHeight/2.0, fit(1));
            
        }
        if (!_pointerFrameSeted && _rulerFace == RulerFace_down_right) {
//            _pointerView.transform = CGAffineTransformTranslate(_pointerView.transform,_pointerFrame.size.height/2.0, _pointerFrame.size.height/2.0);
//            _pointerView.transform = CGAffineTransformRotate(_pointerView.transform, 3.1415927/2.0);
            _pointerView.frame = CGRectMake(selfWidth/2.0, selfHeight/2.0-fit(1)/2.0, selfHeight>=fit(120)?fit(80):selfHeight/2.0, fit(1));
        }
        
    }else {
        NSAssert(NO, @"error");
    }
    
    _rulerView.h_height = _h_height;
    _rulerView.m_height = _m_height;
    _rulerView.lockMin = _lockMin;
    _rulerView.lockMax = _lockMax;
    _rulerView.unitValue = _unitValue;
    _rulerView.rulerDirection = _rulerDirection;
    _rulerView.rulerFace = _rulerFace;
    _rulerView.isShowRulerValue = _isShowRulerValue;
    _rulerView.pointerFrame = _pointerFrame;
    _rulerView.rulerBackgroundColor = _rulerBackgroundColor;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_rulerDirection == RulerDirectionHorizontal) {
        
        if (scrollView.contentOffset.x <= _unitPX*(_lockMin/_unitValue)) {
            scrollView.contentOffset = CGPointMake(_unitPX*(_lockMin/_unitValue), 0);
            [self.rulerDelegate rulerWith:_lockMin];
            if ([self.rulerDelegate respondsToSelector:@selector(rulerRunEnd)]) {
                [self.rulerDelegate rulerRunEnd];
            }
        }
        if (scrollView.contentOffset.x >= _unitPX*(_lockMax/_unitValue)) {
            scrollView.contentOffset = CGPointMake(_unitPX*(_lockMax/_unitValue), 0);
            [self.rulerDelegate rulerWith:_lockMax];
            if ([self.rulerDelegate respondsToSelector:@selector(rulerRunEnd)]) {
                [self.rulerDelegate rulerRunEnd];
            }
        }
        self.i = (int)(scrollView.contentOffset.x/_unitPX+0.5);
        [self.rulerDelegate rulerWith:self.i*_unitValue];
        
    }else if (_rulerDirection == RulerDirectionVertical) {
        
        if (scrollView.contentOffset.y <= _unitPX*(_lockMin/_unitValue)) {
            scrollView.contentOffset = CGPointMake(0, _unitPX*(_lockMin/_unitValue));
            [self.rulerDelegate rulerWith:_lockMin];
            if ([self.rulerDelegate respondsToSelector:@selector(rulerRunEnd)]) {
                [self.rulerDelegate rulerRunEnd];
            }
        }
        if (scrollView.contentOffset.y >= _unitPX*(_lockMax/_unitValue)) {
            scrollView.contentOffset = CGPointMake(0, _unitPX*(_lockMax/_unitValue));
            [self.rulerDelegate rulerWith:_lockMax];
            if ([self.rulerDelegate respondsToSelector:@selector(rulerRunEnd)]) {
                [self.rulerDelegate rulerRunEnd];
            }
        }
        self.i = (int)(scrollView.contentOffset.y/_unitPX+0.5);
        [self.rulerDelegate rulerWith:self.i*_unitValue];
        
    }else {
        NSAssert(NO, @"error");
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (_rulerDirection == RulerDirectionHorizontal) {
        
        if (decelerate) {
            // nothing
        }else {
            self.i = (int)(scrollView.contentOffset.x/_unitPX+0.5);
            [scrollView setContentOffset: CGPointMake(_unitPX*self.i, 0) animated:YES];
            [self.rulerDelegate rulerWith:self.i*_unitValue];
            if ([self.rulerDelegate respondsToSelector:@selector(rulerRunEnd)]) {
                [self.rulerDelegate rulerRunEnd];
            }
        }
        
    }else if (_rulerDirection == RulerDirectionVertical) {
        
        if (decelerate) {
            // nothing
        }else {
            self.i = (int)(scrollView.contentOffset.y/_unitPX+0.5);
            [scrollView setContentOffset: CGPointMake(0, _unitPX*self.i) animated:YES];
            [self.rulerDelegate rulerWith:self.i*_unitValue];
            if ([self.rulerDelegate respondsToSelector:@selector(rulerRunEnd)]) {
                [self.rulerDelegate rulerRunEnd];
            }
        }
        
    }else {
        NSAssert(NO, @"error");
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_rulerDirection == RulerDirectionHorizontal) {
        
        self.i = (int)(scrollView.contentOffset.x/_unitPX+0.5);
        [scrollView setContentOffset: CGPointMake(_unitPX*self.i, 0) animated:YES];
        [self.rulerDelegate rulerWith:self.i*_unitValue];
        if ([self.rulerDelegate respondsToSelector:@selector(rulerRunEnd)]) {
            [self.rulerDelegate rulerRunEnd];
        }
        
    }else if (_rulerDirection == RulerDirectionVertical) {
        
        self.i = (int)(scrollView.contentOffset.y/_unitPX+0.5);
        [scrollView setContentOffset: CGPointMake(0, _unitPX*self.i) animated:YES];
        [self.rulerDelegate rulerWith:self.i*_unitValue];
        if ([self.rulerDelegate respondsToSelector:@selector(rulerRunEnd)]) {
            [self.rulerDelegate rulerRunEnd];
        }
        
    }else {
        NSAssert(NO, @"error");
    }
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (_rulerDirection == RulerDirectionHorizontal) {
        
        self.i = (int)(scrollView.contentOffset.x/_unitPX+0.5);
        [scrollView setContentOffset: CGPointMake(_unitPX*self.i, 0) animated:NO];
        [self.rulerDelegate rulerWith:self.i*_unitValue];
        if ([self.rulerDelegate respondsToSelector:@selector(rulerRunEnd)]) {
            [self.rulerDelegate rulerRunEnd];
        }
        
    }else if (_rulerDirection == RulerDirectionVertical) {
        
        self.i = (int)(scrollView.contentOffset.y/_unitPX+0.5);
        [scrollView setContentOffset: CGPointMake(0, _unitPX*self.i) animated:NO];
        [self.rulerDelegate rulerWith:self.i*_unitValue];
        if ([self.rulerDelegate respondsToSelector:@selector(rulerRunEnd)]) {
            [self.rulerDelegate rulerRunEnd];
        }
        
    }else {
        NSAssert(NO, @"error");
    }
}




- (void)setPointerFrame:(CGRect)pointerFrame {
    _pointerFrame = pointerFrame;
    _pointerFrameSeted = YES;
}



@end
