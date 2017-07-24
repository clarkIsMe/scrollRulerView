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
    
    /**
     *  经典标尺 样式
     **/
    TTScrollRulerView *rulerClassic = [[TTScrollRulerView alloc] initWithFrame:CGRectMake(50, 50+100*0, cy_ScreenW-100, 100)];
    [self.view addSubview:rulerClassic];
    rulerClassic.rulerDelegate = self;
    rulerClassic.lockMax = 1000000;
    rulerClassic.unitValue = 100;
    //在执行此方法前，可先设定参数：最小值，最大值，横向，纵向等等  ------若不设定，则按照默认值绘制
    [rulerClassic classicRuler];
    
    
//    /**
//     *  自定义标尺 样式
//     **/
//    TTScrollRulerView *rulerCustom = [[TTScrollRulerView alloc] initWithFrame:CGRectMake(50, 50+100*1, cy_ScreenW-100, 100)];
//    [self.view addSubview:rulerCustom];
//    rulerCustom.rulerDelegate = self;
//    //在执行此方法前，可先设定参数：最小值，最大值，横向，纵向等等   ------若不设定，则按照默认值绘制
//    [rulerCustom customRulerWithLineColor:customColorMake(0, 0, 0) NumColor:[UIColor redColor] scrollEnable:YES];
//    
//    
//    /**
//     *  横向滚动，刻度位于上方
//     **/
//    TTScrollRulerView *rulerHUP = [[TTScrollRulerView alloc] initWithFrame:CGRectMake(50, 50+100*2, cy_ScreenW-100, 100)];
//    [self.view addSubview:rulerHUP];
//    rulerHUP.rulerDelegate = self;
//    //设置滚动方向，默认横向滚动
//    rulerHUP.rulerDirection = RulerDirectionHorizontal;
//    //设置刻度位置，默认在上方
//    rulerHUP.rulerFace = RulerFace_up_left;
//    [rulerHUP classicRuler];
//    
//    
//    /**
//     *  横向滚动，刻度位于下方
//     **/
//    TTScrollRulerView *rulerHDOWN = [[TTScrollRulerView alloc] initWithFrame:CGRectMake(50, 50+100*3, cy_ScreenW-100, 100)];
//    [self.view addSubview:rulerHDOWN];
//    rulerHDOWN.rulerDelegate = self;
//    //设置滚动方向，默认横向滚动
//    rulerHDOWN.rulerDirection = RulerDirectionHorizontal;
//    //设置刻度位置，下方
//    rulerHDOWN.rulerFace = RulerFace_down_right;
//    [rulerHDOWN classicRuler];
//    
//    
//    
//    /**
//     *  纵向滚动，刻度位于左边
//     **/
//    TTScrollRulerView *rulerVUP = [[TTScrollRulerView alloc] initWithFrame:CGRectMake(50, 50+100*4, 100, 250)];
//    [self.view addSubview:rulerVUP];
//    rulerVUP.rulerDelegate = self;
//    //设置滚动方向，默认横向滚动
//    rulerVUP.rulerDirection = RulerDirectionVertical;
//    //设置刻度位置，下方
//    rulerVUP.rulerFace = RulerFace_up_left;
//    [rulerVUP classicRuler];
//    
//    
//    
//    /**
//     *  纵向滚动，刻度位于右边
//     **/
//    TTScrollRulerView *rulerVDOWN = [[TTScrollRulerView alloc] initWithFrame:CGRectMake(50+100, 50+100*4, 100, 250)];
//    [self.view addSubview:rulerVDOWN];
//    rulerVDOWN.rulerDelegate = self;
//    //设置滚动方向，默认横向滚动
//    rulerVDOWN.rulerDirection = RulerDirectionVertical;
//    //设置刻度位置，下方
//    rulerVDOWN.rulerFace = RulerFace_down_right;
//    [rulerVDOWN classicRuler];
//    
//    
//    
//    /**
//     *  参数改变后，重新绘制标尺
//     **/
//    rulerVDOWN.lockMin = 50;
//    [rulerVDOWN reDrawerRuler];
//    
//    
//    /**
//     *  让标尺滚动到某一个数值
//     **/
//    [rulerVDOWN scrollToValue:50 animation:NO];
//    
//    
    /**
     *  自定义标尺
     *  注意事项：
     *  1、标尺视图的frame需要足够标尺显示出来，自己摸索
     *  2、最小值、最大值、单位刻度值，最好一起设定，只设定部分会和默认值产生冲突
     *  3、默认值的意思是标尺创建之后，刻度所在的位置，若不设定，会默认在最小值的位置
     *  4、自定义指针的frame是相对于标尺视图的
     
     *  如果遇到其它问题，无法解决，请联系QQ：943051580
     **/
//    TTScrollRulerView *rulerView = [[TTScrollRulerView alloc] initWithFrame:CGRectMake(50+100*2+50, 50+100*4, 150, 250)];
//    [self.view addSubview:rulerView];
//    rulerView.rulerDelegate = self;
//    //纵向滚动
//    rulerView.rulerDirection = RulerDirectionVertical;
//    //最小值
//    rulerView.lockMin = 1000;
//    //最大值
//    rulerView.lockMax = 1000000;
//    //一个刻度代表的数值
//    rulerView.unitValue = 100;
//    //默认值
//    rulerView.lockDefault = 2000;
//    //不显示刻度数值
//    rulerView.isShowRulerValue = YES;
//    //背景颜色
//    rulerView.rulerBackgroundColor = [UIColor whiteColor];
//    //自定义指针位置
//    rulerView.pointerFrame = CGRectMake(rulerView.bounds.size.width/2.0-cy_fit(80), cy_fit(65), cy_fit(80), cy_fit(1));
//    //自定义指针图片
//    rulerView.pointerImage = nil; //可自定义
//    rulerView.pointerBackgroundColor = [UIColor blueColor];
//    
//    [rulerView classicRuler];
    
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
