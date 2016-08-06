# YFChartView
This resposity about the drawing is based on Core Graphics and Core Animation.

## 效果
![](/pics/model.png)    

#### 思路：
1、先画网格，自定义一个View，重写drawRect:方法进行网格的绘制。    
2、给自定义的View上，绘制四种颜色分布的CAGradientlayer，再设置CASharpLayer 做为遮罩，可得到曲线。    
3、两点间的差值：当手势划到两小间隔之间的某一个点时，根据两个点的Y坐标及其Y轴上对应的分量计算出着两个点的直线方程，y=kx+b；输入该点的x 坐标，可算出该点的线性插值结果，为了求出显示数值标题的位置，也产用了类似的插值算法。    
#### pitfalls
1、在绘制四种颜色非渐变的Gradientlayer的时候，由于直接给GradientLayer 设置colors会产生渐变效果(但这里不需要渐变),所以绘制这种四块区域不同颜色的时候，重写了drawIncontext:方法，通过Core Graphiics 进行绘制。    

#### 杂谈之插值：
插值有很多种方式，但就我所知道的就有线性插值、二次插值、三次样条插值，其中本人认为三次样条插值最为复杂，不易掌握，有兴趣者可以自行研究，推荐一本书《数值计算方法》。

有待更新.......
