//
//  ViewController.m
//  scrollRulerDemo
//
//  Created by 天天理财 on 17/2/3.
//
//

#import "ViewController.h"
#import "TTScrollRulerView.h"

@interface ViewController ()<rulerDelegate>

@property (nonatomic,strong) TTScrollRulerView *ruler;
@property (nonatomic,strong) UIView *line;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _ruler = [[TTScrollRulerView alloc] initWithFrame:CGRectMake(0,ScreenH/4.0, ScreenW, ScreenW)];
    [self.view addSubview:self.ruler];
    _ruler.rulerDelegate = self;
    
    _ruler.lockMin = 1000;
    _ruler.lockMax = 50000;
    _ruler.lockDefault = 3000;
    _ruler.unitValue = 100;
    _ruler.rulerDirection = RulerDirectionVertical;
    _ruler.rulerFace = RulerFace_down_right;
    _ruler.isShowRulerValue = YES;
    
    [_ruler classicRuler];
    
    _ruler.lockMax = 5000;
    [_ruler reDrawerRuler];
    
//    [_ruler customRulerWithLineColor:customColorMake(0, 0, 0) NumColor:[UIColor redColor] scrollEnable:YES];
    
}

#pragma mark 标尺代理方法
- (void)rulerWith:(NSInteger)days {
    //即时打印出标尺滑动位置的数值
    NSLog(@"当前刻度值：%ld",days);
}

- (void)rulerRunEnd {
    NSLog(@"end");
}


@end
