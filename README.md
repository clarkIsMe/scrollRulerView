# scrollRulerView
---
### 说明
###### 可滑动，自定义标尺，支持惯性滑动，重绘，以及超多自定义参数设定，随心所欲的使用。欢迎提出批评。

### 效果图参考，更多自定义请下载demo查看

<img src="https://github.com/clarkIsMe/image/blob/master/biaochi.png" width = "375" height = "667" alt="图片名称" align=center />

##### 经典标尺 样式
<pre><code>
TTScrollRulerView *rulerClassic = [[TTScrollRulerView alloc] initWithFrame:CGRectMake(50, 50+100*0, cy_ScreenW-100, 100)];
[self.view addSubview:rulerClassic];
rulerClassic.rulerDelegate = self;
//在执行此方法前，可先设定参数：最小值，最大值，横向，纵向等等  ------若不设定，则按照默认值绘制
[rulerClassic classicRuler];
</code></pre>

##### 自定义标尺 样式
<pre><code>
TTScrollRulerView *rulerCustom = [[TTScrollRulerView alloc] initWithFrame:CGRectMake(50, 50+100*1, cy_ScreenW-100, 100)];
[self.view addSubview:rulerCustom];
rulerCustom.rulerDelegate = self;
//在执行此方法前，可先设定参数：最小值，最大值，横向，纵向等等   ------若不设定，则按照默认值绘制
[rulerCustom customRulerWithLineColor:customColorMake(0, 0, 0) NumColor:[UIColor redColor] scrollEnable:YES];
</code></pre>

##### 横向滚动，刻度位于上方
<pre><code>
TTScrollRulerView *rulerHUP = [[TTScrollRulerView alloc] initWithFrame:CGRectMake(50, 50+100*2, cy_ScreenW-100, 100)];
[self.view addSubview:rulerHUP];
rulerHUP.rulerDelegate = self;
//设置滚动方向，默认横向滚动
rulerHUP.rulerDirection = RulerDirectionHorizontal;
//设置刻度位置，默认在上方
rulerHUP.rulerFace = RulerFace_up_left;
[rulerHUP classicRuler];
</code></pre>
##### 横向滚动，刻度位于下方
<pre><code>
TTScrollRulerView *rulerHDOWN = [[TTScrollRulerView alloc] initWithFrame:CGRectMake(50, 50+100*3, cy_ScreenW-100, 100)];
[self.view addSubview:rulerHDOWN];
rulerHDOWN.rulerDelegate = self;
//设置滚动方向，默认横向滚动
rulerHDOWN.rulerDirection = RulerDirectionHorizontal;
//设置刻度位置，下方
rulerHDOWN.rulerFace = RulerFace_down_right;
[rulerHDOWN classicRuler];
</code></pre>

##### 纵向滚动，刻度位于左边
<pre><code>
TTScrollRulerView *rulerVUP = [[TTScrollRulerView alloc] initWithFrame:CGRectMake(50, 50+100*4, 100, 250)];
[self.view addSubview:rulerVUP];
rulerVUP.rulerDelegate = self;
//设置滚动方向，默认横向滚动
rulerVUP.rulerDirection = RulerDirectionVertical;
//设置刻度位置，下方
rulerVUP.rulerFace = RulerFace_up_left;
[rulerVUP classicRuler];
</code></pre>

##### 纵向滚动，刻度位于右边
<pre><code>
TTScrollRulerView *rulerVDOWN = [[TTScrollRulerView alloc] initWithFrame:CGRectMake(50+100, 50+100*4, 100, 250)];
[self.view addSubview:rulerVDOWN];
rulerVDOWN.rulerDelegate = self;
//设置滚动方向，默认横向滚动
rulerVDOWN.rulerDirection = RulerDirectionVertical;
//设置刻度位置，下方
rulerVDOWN.rulerFace = RulerFace_down_right;
[rulerVDOWN classicRuler];
</code></pre>

##### 参数改变后，重新绘制标尺
<pre><code>
rulerVDOWN.lockMin = 50;
[rulerVDOWN reDrawerRuler];
</code></pre>

##### 让标尺滚动到某一个数值
<pre><code>
[rulerVDOWN scrollToValue:50 animation:NO];
</code></pre>

##### 完全自定义标尺
<pre><code>
/**
 *  自定义标尺
 *  注意事项：
 *  1、标尺视图的frame需要足够标尺显示出来，自己摸索
 *  2、最小值、最大值、单位刻度值，最好一起设定，只设定部分会和默认值产生冲突
 *  3、默认值的意思是标尺创建之后，刻度所在的位置，若不设定，会默认在最小值的位置
 *  4、自定义指针的frame是相对于标尺视图的

 *  如果遇到其它问题，无法解决，请联系QQ：943051580
 **/
TTScrollRulerView *rulerView = [[TTScrollRulerView alloc] initWithFrame:CGRectMake(50+100*2+50, 50+100*4, 150, 250)];
[self.view addSubview:rulerView];
rulerView.rulerDelegate = self;
//纵向滚动
rulerView.rulerDirection = RulerDirectionVertical;
//最小值
rulerView.lockMin = 1000;
//最大值
rulerView.lockMax = 50000;
//一个刻度代表的数值
rulerView.unitValue = 100;
//默认值
rulerView.lockDefault = 2000;
//不显示刻度数值
rulerView.isShowRulerValue = YES;
//背景颜色
rulerView.rulerBackgroundColor = [UIColor whiteColor];
//自定义指针位置
rulerView.pointerFrame = CGRectMake(rulerView.bounds.size.width/2.0-cy_fit(80), cy_fit(65), cy_fit(80), cy_fit(1));
//自定义指针图片
rulerView.pointerImage = nil; //可自定义
rulerView.pointerBackgroundColor = [UIColor blueColor];

[rulerView classicRuler];
</code></pre>

### 导入方法
<code>

pod 'TTScrollRuler'

#import <TTScrollRulerView.h> 即可使用

</code>
