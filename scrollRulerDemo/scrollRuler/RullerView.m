//
//  RullerView.m
//  标尺
//
//  Created by 标尺 on 16/12/27.
//  Copyright © 2016年 标尺. All rights reserved.
//

#import "RullerView.h"

@interface RullerView()
{
    float _unitPX;//标尺单位长度
    float _coarseness;//标尺粗
    
    float _num_height;//数字高度
    float _num_top;//数字头部位置
    
    float _mark_bottom;//刻度尾部位置
    float _short_mark_top;//短刻度头部位置
    float _long_mark_top;//长刻度头部位置
}

@end

@implementation RullerView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
    
    }
    return self;
}

- (void)start {
    self.backgroundColor = _rulerBackgroundColor?_rulerBackgroundColor:[UIColor whiteColor];
    _unitPX = cy_fit(14);
    _coarseness = cy_fit(1);
    _num_height = cy_fit(24);
    _txtColor = UIColorFromRGB(0xDDDDDD);
    _lineColor = customColorMake(221, 221, 221);
    
    if (_rulerDirection == RulerDirectionHorizontal) {
        
        if (_rulerFace == RulerFace_up_left) {
            
            _mark_bottom = cy_selfHeight/2.0;
            _short_mark_top = _mark_bottom-_m_height;
            _long_mark_top = _mark_bottom-_h_height;
            _num_top = _long_mark_top-_num_height-cy_fit(10);
            
        }else if (_rulerFace == RulerFace_down_right) {
            
            _mark_bottom = cy_selfHeight/2.0;
            _short_mark_top = _mark_bottom+_m_height;
            _long_mark_top = _mark_bottom+_h_height;
            _num_top = _long_mark_top+_num_height-cy_fit(10);
            
        }else {
            NSAssert(NO, @"error");
        }
        
    }else if (_rulerDirection == RulerDirectionVertical) {
        
        if (_rulerFace == RulerFace_up_left) {
            
            _mark_bottom = cy_selfWidth/2.0;
            _short_mark_top = _mark_bottom-_m_height;
            _long_mark_top = _mark_bottom-_h_height;
            _num_top = _long_mark_top-_unitPX*8+cy_fit(10);
            
        }else if (_rulerFace == RulerFace_down_right) {
            
            _mark_bottom = cy_selfWidth/2.0;
            _short_mark_top = _mark_bottom+_m_height;
            _long_mark_top = _mark_bottom+_h_height;
            _num_top = _long_mark_top-cy_fit(10);
            
        }else {
            NSAssert(NO, @"error");
        }
        
    }else {
        NSAssert(NO, @"error");
    }
}

- (void)drawRuler:(Handler)block {
    [self start];
    if (block) {
        block();
    }
    [self setNeedsDisplay];
}

//绘制方法
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context,self.lineColor.R,self.lineColor.G,self.lineColor.B,1.0);
    CGContextSetLineWidth(context, _coarseness);
    //画轴
    CGPoint aPoints[2];//X轴
    if (_rulerDirection == RulerDirectionHorizontal) {
        
        aPoints[0] =CGPointMake(0, _mark_bottom);//起始点
        aPoints[1] =CGPointMake(cy_selfWidth, _mark_bottom);//终点
        
    }else if (_rulerDirection == RulerDirectionVertical) {
        
        aPoints[0] =CGPointMake(_mark_bottom, 0);//起始点
        aPoints[1] =CGPointMake(_mark_bottom, cy_selfHeight);//终点
        
    }else {
        NSAssert(NO, @"error");
    }
    CGContextAddLines(context, aPoints, 2);//添加线
    CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径
    
    //画刻度
    for (NSInteger i=_lockMin/_unitValue; i<(_lockMax/_unitValue+1); i++) {
        CGContextSetRGBStrokeColor(context,self.lineColor.R,self.lineColor.G,self.lineColor.B,1.0);
        CGContextSetLineWidth(context, _coarseness);
        CGPoint aPoints[2];//X轴
        if (_rulerDirection == RulerDirectionHorizontal) {
            
            aPoints[0] =CGPointMake(_pointerFrame.origin.x+_pointerFrame.size.width/2.0+_unitPX*i, i%10==0?_long_mark_top:_short_mark_top);//起始点
            aPoints[1] =CGPointMake(_pointerFrame.origin.x+_pointerFrame.size.width/2.0+_unitPX*i, _mark_bottom);//终点
            
        }else if (_rulerDirection == RulerDirectionVertical) {
            
            aPoints[0] =CGPointMake(i%10==0?_long_mark_top:_short_mark_top,_pointerFrame.origin.y+_pointerFrame.size.height/2.0+_unitPX*i);//起始点
            aPoints[1] =CGPointMake(_mark_bottom,_pointerFrame.origin.y+_pointerFrame.size.height/2.0+_unitPX*i);//终点
            
        }else {
            NSAssert(NO, @"error");
        }
        
        CGContextAddLines(context, aPoints, 2);//添加线
        CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径
        
        if (_isShowRulerValue && i%10==0) {
            NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
            textStyle.lineBreakMode = NSLineBreakByWordWrapping;
            textStyle.alignment = NSTextAlignmentCenter;
            UIFont  *font = [UIFont systemFontOfSize:_num_height];
            NSDictionary *attributes = @{NSForegroundColorAttributeName:self.txtColor,NSFontAttributeName:font, NSParagraphStyleAttributeName:textStyle};
            if (_rulerDirection == RulerDirectionHorizontal) {
                
                [@(i*_unitValue).stringValue drawInRect:CGRectMake(_pointerFrame.origin.x+_pointerFrame.size.width/2.0+_unitPX*(i-4), _num_top, _unitPX*8, _num_height) withAttributes:attributes];
                
            }else if (_rulerDirection == RulerDirectionVertical) {
                
                [@(i*_unitValue).stringValue drawInRect:CGRectMake(_num_top, _pointerFrame.origin.y+_pointerFrame.size.height/2.0+_unitPX*(i-1), _unitPX*8, _num_height) withAttributes:attributes];
                
            }else {
                NSAssert(NO, @"error");
            }
            
        }
    }
}

//c 函数构造结构体
CustomeColor customColorMake(CGFloat R,CGFloat G,CGFloat B) {
    CustomeColor l;l.R = R/255.0;l.G = G/255.0;l.B = B/255.0; return l;
}

@end
