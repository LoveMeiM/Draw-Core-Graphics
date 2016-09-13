//
//  BezierPathView.m
//  Dome
//
//  Created by liubaojian on 16/8/27.
//  Copyright © 2016年 liubaojian. All rights reserved.
//

#import "DrawsView.h"
#import <objc/runtime.h>
#import "Toast+UIView.h"

//由角度获取弧度 有弧度获取角度
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)
#define  TILE_SIZE  30

@implementation DrawsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)layoutSubviews
{
    
}
- (void)drawRect:(CGRect)rect {
    
    SEL selector = NSSelectorFromString([NSString stringWithFormat:@"forDrow%@",self.typeStr]);
    IMP imp = [self methodForSelector:selector];
    void (*func)(id, SEL) = (void *)imp;
    func(self, selector);
   
}
- (void)forDrow0
{
    //边框
    CGContextRef context = UIGraphicsGetCurrentContext();
    //画一个椭圆
    CGContextAddEllipseInRect(context, CGRectMake(110,100,100,100));
    //填充内部颜色
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextStrokePath(context);
    
    
    CGContextAddRect(context, CGRectMake(60,250,200,30));
    //填充内部颜色
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
    CGContextStrokePath(context);
}

- (void)forDrow1
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    
    NSString *str1 = @"使用drawAtPoint方法画文字";
    [[UIColor blackColor] set];
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor magentaColor]};
    [str1 drawAtPoint:CGPointMake(30, 150) withAttributes:attributes];
    
    
    //画一条线
    [[UIColor blackColor] set];
    CGContextSetLineWidth(context, 2.0);
    CGContextMoveToPoint(context, 20 ,200);
    CGContextAddLineToPoint(context, 200, 200);
    CGContextStrokePath(context);
    
}
//三角形
- (void)forDrow2
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctx, 50, 150); // 第一个点
    CGContextAddLineToPoint(ctx, 100, 100); // 第二个点
    CGContextAddLineToPoint(ctx, 140, 150); // 第三个点
    [[UIColor purpleColor] set];
    CGContextClosePath(ctx);
    CGContextStrokePath(ctx);
}

//圆弧
- (void)forDrow3
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddArc(ctx, 200, 200, 100, M_PI, M_PI_4, 0);
    [[UIColor magentaColor] set];
    CGContextStrokePath(ctx);
}
- (void)forDrow4
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIBezierPath *btnPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(60, 100, 200, 50) cornerRadius:4];
    //设置阴影
    CGContextSetShadow(context, CGSizeMake(2, 2), 10);
    //添加高亮效果
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    //开始描边
    [[UIColor blackColor]setStroke];
    //[btnPath stroke];
    //开始填充颜色
    [btnPath fill];
    
}

- (void)forDrow5
{
    // 创建Quartz上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect newRect = CGRectMake(40.0, 150, 240, 50);
    UIBezierPath *newPath = [UIBezierPath bezierPathWithOvalInRect:newRect];
    [newPath addClip];
    // 创建色彩空间对象
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    // 创建渐变对象
    CGGradientRef gradientRef = CGGradientCreateWithColorComponents(colorSpaceRef,
                                                                    (CGFloat[]){
                                                                        0.01f, 0.99f, 0.01f, 1.0f,
                                                                        0.01f, 0.99f, 0.99f, 1.0f,
                                                                        0.99f, 0.99f, 0.01f, 1.0f
                                                                    },
                                                                    (CGFloat[]){
                                                                        0.0f,
                                                                        0.5f,
                                                                        1.0f
                                                                    },
                                                                    3);
    
    // 释放色彩空间
    CGColorSpaceRelease(colorSpaceRef);
    // 填充渐变色
    CGContextDrawLinearGradient(context, gradientRef, CGPointMake(0.0f, 0.0f), CGPointMake(320.0f, 460.0f), 0);
    // 释放渐变对象
    CGGradientRelease(gradientRef);
    
}
- (void)forDrow6
{
    //=====================================================/*椭圆 */=============================================
    // 获取当前图形，视图推入堆栈的图形，相当于你所要绘制图形的图纸
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 定义其rect
    CGRect rectangle = CGRectMake(10, 150, 300, 280);
    // 在当前路径下添加一个椭圆路径
    CGContextAddEllipseInRect(ctx, rectangle);
    // 设置当前视图填充色
    CGContextSetFillColorWithColor(ctx, [UIColor purpleColor].CGColor);
    // 绘制当前路径区域
    CGContextFillPath(ctx);
    
    
    
    //=================================================   /*曲线*/  ==========================================
    
    // 创建一个新的空图形路径。
    CGContextBeginPath(ctx);
    /**
     *  @brief 在指定点开始一个新的子路径 参数按顺序说明
     *
     *  @param c 当前图形
     *  @param x 指定点的x坐标值
     *  @param y 指定点的y坐标值
     *
     */
    CGContextMoveToPoint(ctx, 160, 150);
    /**
     *  @brief 在指定点追加二次贝塞尔曲线，通过控制点和结束点指定曲线。
     *         关于曲线的点的控制见下图说明，图片来源苹果官方网站。参数按顺序说明
     *  @param c   当前图形
     *  @param cpx 曲线控制点的x坐标
     *  @param cpy 曲线控制点的y坐标
     *  @param x   指定点的x坐标值
     *  @param y   指定点的y坐标值
     *
     */
    CGContextAddQuadCurveToPoint(ctx, 160, 100, 190, 100);
    // 设置图形的线宽
    CGContextSetLineWidth(ctx, 30);
    // 设置图形描边颜色
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    // 根据当前路径，宽度及颜色绘制线
    CGContextStrokePath(ctx);
    
    
   //==========================================================   /*圆形*/  =================================
 
    // 创建一个新的空图形路径。
    CGContextSetFillColorWithColor(ctx, [UIColor blackColor].CGColor);
    
    /**
     *  @brief 在当前路径添加圆弧 参数按顺序说明
     *
     *  @param c           当前图形
     *  @param x           圆弧的中心点坐标x
     *  @param y           曲线控制点的y坐标
     *  @param radius      指定点的x坐标值
     *  @param startAngle  弧的起点与正X轴的夹角，
     *  @param endAngle    弧的终点与正X轴的夹角
     *  @param clockwise   指定1创建一个顺时针的圆弧，或是指定0创建一个逆时针圆弧
     *
     */
    CGContextAddArc(ctx, 120, 220, 20, 0, 2 * M_PI, 1);
    //绘制当前路径区域
    CGContextFillPath(ctx);
    
    
    CGContextSetFillColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGContextAddArc(ctx, 200, 220, 20, 0, 2 * M_PI, 1);
    CGContextFillPath(ctx);
    
    //==========================================================   /*三角形*/  =================================
  
    // 创建一个新的空图形路径。
    CGContextBeginPath(ctx);
    /**
     *  @brief 在指定点开始一个新的子路径 参数按顺序说明
     *
     *  @param c 当前图形
     *  @param x 指定点的x坐标值
     *  @param y 指定点的y坐标值
     *
     */
    CGContextMoveToPoint(ctx, 160, 270);
    /**
     *  @brief 在当前点追加直线段，参数说明与上面一样
     */
    CGContextAddLineToPoint(ctx, 190, 310);
    CGContextAddLineToPoint(ctx, 130, 310);
    // 关闭并终止当前路径的子路径，并在当前点和子路径的起点之间追加一条线
    CGContextClosePath(ctx);
    
    // 设置当前视图填充色
    CGContextSetFillColorWithColor(ctx, [UIColor blackColor].CGColor);
    // 绘制当前路径区域
    CGContextFillPath(ctx);
    
    //==========================================================   /*矩形*/  =================================

    
    // 定义矩形的rect
    CGRect rectangle1 = CGRectMake(100, 340, 120, 25);
    // 在当前路径下添加一个矩形路径
    CGContextAddRect(ctx, rectangle1);
    // 设置试图的当前填充色
    CGContextSetFillColorWithColor(ctx, [UIColor blackColor].CGColor);
    // 绘制当前路径区域
    CGContextFillPath(ctx);
    

}

- (void)forDrow7
{
    
// 获取绘图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
// 设置起始点 设置多条线段
     CGContextMoveToPoint(context, 20, 80);
     CGContextAddLineToPoint(context, 20, 150);
     CGContextAddLineToPoint(context, 300, 150);
     CGContextAddLineToPoint(context, 300, 300);
     CGContextAddLineToPoint(context, 100, 300);

 // 设置图形上下文状态属性
     CGContextSetRGBStrokeColor(context, 1.0, 0, 0, 1);// 设置笔触颜色
     CGContextSetRGBFillColor(context, 0, 1.0, 0, 1);// 设置填充色
     CGContextSetLineWidth(context, 1.0);// 设置线条宽度
     CGContextSetLineCap(context, kCGLineCapRound);// 设置顶点样式，首尾两个端点是顶点
     CGContextSetLineJoin(context, kCGLineJoinRound);// 设置连接点样式，除了首尾两点之外的中间端点都是是连接点

     // 若设置此项，则将会把线段设置为虚线，虚线的“格式”为一段10像素长的线段加一段5像素长的空白，依次循环。
     // 另外，可以通过对数组定义多个元素来达到多种虚线段样式组合。
     CGFloat lengths[2] = {10, 5};
     CGContextSetLineDash(context, 0, lengths, 2);// 2 是元素个数

     // 若设置此项，则将给绘出的图形设置阴影
     // 在Quartz 2D中，要使用CGColor方法将UIColor转化为CGColorRef
     CGColorRef color = [UIColor grayColor].CGColor;
     // offset:偏移量 blur:模糊度 color:阴影颜色
     CGContextSetShadowWithColor(context, CGSizeMake(2, 2), 0.8, color);

     // 绘制图像到指定图形上下文
     CGContextDrawPath(context, kCGPathFillStroke);// 填充类型(有边框，有填充)
   
}

- (void)forDrow8
{
    // 获取绘图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 初始位置端点
    CGContextMoveToPoint(context, 20, 200);
    
    // 二次贝塞尔曲线
    // cpx:控制点x坐标
    // cpy:控制点y坐标
    // 结束点x坐标
    // 结束点y坐标
    CGContextAddQuadCurveToPoint(context, 160, 60, 300, 100);
    
    CGContextMoveToPoint(context, 20, 400);
    
    // 三次贝塞尔曲线
    // cp1x:第一个控制点x坐标
    // cp1y:第一个控制点y坐标
    // cp2x:第二个控制点x坐标
    // cp2y:第二个控制点y坐标
    // x:结束点x坐标
    // y:结束点y坐标
    CGContextAddCurveToPoint(context, 80, 300, 240, 500, 300, 300);
    //设置图形上下文属性
    [[UIColor brownColor]setFill];
    [[UIColor redColor]setStroke];
    //绘制路径
    CGContextDrawPath(context, kCGPathFillStroke);
}

//
- (void)forDrow9
{
    // 获取绘图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //使用rgb颜色空间
    CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
    
    // compoents:该数组内包含的是RGB值构成的颜色数据，由于RGB值需要四个参数（red、green、blue、alpha），所以假如有三个颜色，则components应该有4*3=12个元素
    CGFloat compoents[12]={
        248.0/255.0,86.0/255.0,86.0/255.0,1,
        249.0/255.0,127.0/255.0,127.0/255.0,1,
        1.0,1.0,1.0,1.0
    };
    // locations:颜色所在位置（范围0~1），这个数组的个数不小于components中存放颜色的个数
    CGFloat locations[3]={0,0.3,1.0};
    // count:渐变个数，等于locations的个数
    // CGGradientCreateWithColorComponents 设置渐变各项参数 获得CGGradientRef对象
    CGGradientRef gradient= CGGradientCreateWithColorComponents(colorSpace, compoents, locations, 3);
    // startPoint:起始位置
    // endPoint:终止位置
    // options:绘制方式,kCGGradientDrawsBeforeStartLocation 开始位置之前就进行绘制，到结束位置之后不再绘制，kCGGradientDrawsAfterEndLocation开始位置之前不进行绘制，到结束点之后继续填充
    CGContextDrawLinearGradient(context, gradient, CGPointZero, CGPointMake(320, 300), kCGGradientDrawsAfterEndLocation);
    //释放颜色空间
    CGColorSpaceRelease(colorSpace);
}


- (void)forDrow10
{
    // 获取绘图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用rgb颜色空间
    CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
    // 同线性渐变
    CGFloat compoents[12]={
        248.0/255.0,86.0/255.0,86.0/255.0,1,
        249.0/255.0,127.0/255.0,127.0/255.0,1,
        1.0,1.0,1.0,1.0
    };
    CGFloat locations[3]={0,0.3,1.0};
    CGGradientRef gradient= CGGradientCreateWithColorComponents(colorSpace, compoents, locations, 3);
    
    // startCenter:起始点位置
    // startRadius:起始半径（通常为0，否则在此半径范围内容无任何填充）
    // endCenter:终点位置（通常和起始点相同，否则会有偏移）
    // endRadius:终点半径（也就是渐变的扩散长度）
    // options:绘制方式,kCGGradientDrawsBeforeStartLocation 开始位置之前就进行绘制，但是到结束位置之后不再绘制，kCGGradientDrawsAfterEndLocation开始位置之前不进行绘制，但到结束点之后继续填充
    CGContextDrawRadialGradient(context, gradient, CGPointMake(160, 284), 0, CGPointMake(165, 289), 150, kCGGradientDrawsAfterEndLocation);
    //释放颜色空间
    CGColorSpaceRelease(colorSpace);
}

//填充图案
- (void)forDrow11
{
    // 获取绘图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 创建填充的颜色空间 有颜色填充 传NULL
    CGColorSpaceRef colorSpace = CGColorSpaceCreatePattern(NULL);
    // 设置颜色空间
    CGContextSetFillColorSpace(context, colorSpace);
    
    // 设置实际创建单位图形的回调函数
    CGPatternCallbacks callback={0, &drawColoredTile, NULL};
    
    // 创建单位图形 参数依次为:
    // info:传递给callback的参数
    // bounds:单位图形绘制大小
    // matrix:形变
    // xStep:单位图形分配宽度
    // yStep:单位图形分配高度
    // tiling:三种模式，控制是否扭曲
    // isClored:绘制的瓷砖是否指定颜色(对于有颜色瓷砖此处指定位true)
    // callbacks:设置回调函数
    CGPatternRef pattern=CGPatternCreate(NULL, CGRectMake(0, 0, 2*TILE_SIZE, 2*TILE_SIZE), CGAffineTransformIdentity, 2*TILE_SIZE,2*TILE_SIZE, kCGPatternTilingNoDistortion, true, &callback);
    
    CGFloat alpha = 1.0;
    // 注意最后一个参数对于有颜色瓷砖指定为透明度的参数地址，对于无颜色瓷砖则指定当前颜色空间对应的颜色数组
    CGContextSetFillPattern(context, pattern, &alpha);
    
    UIRectFill(CGRectMake(0, 0, 320, 568));
    
    // 释放
    CGColorSpaceRelease(colorSpace);
    CGPatternRelease(pattern);
    
    // 有颜色填充，在这里设置填充色
    CGContextSetRGBFillColor(context, 254.0/255.0, 52.0/255.0, 90.0/255.0, 1);
    CGContextFillRect(context, CGRectMake(0, 0, TILE_SIZE, TILE_SIZE));
    CGContextFillRect(context, CGRectMake(TILE_SIZE, TILE_SIZE, TILE_SIZE, TILE_SIZE));
    
    CGContextSetRGBFillColor(context, 0.0/255.0, 160.0/255.0, 190.0/255.0, 1);
    CGContextFillRect(context, CGRectMake(TILE_SIZE, 0, TILE_SIZE, TILE_SIZE));
    CGContextFillRect(context, CGRectMake(0, TILE_SIZE, TILE_SIZE, TILE_SIZE));
}

void drawColoredTile(void *info,CGContextRef context){
    // 有颜色填充，在这里设置填充色
    CGContextSetRGBFillColor(context, 254.0/255.0, 52.0/255.0, 90.0/255.0, 1);
    CGContextFillRect(context, CGRectMake(0, 0, TILE_SIZE, TILE_SIZE));
    CGContextFillRect(context, CGRectMake(TILE_SIZE, TILE_SIZE, TILE_SIZE, TILE_SIZE));
    
    CGContextSetRGBFillColor(context, 0.0/255.0, 160.0/255.0, 190.0/255.0, 1);
    CGContextFillRect(context, CGRectMake(TILE_SIZE, 0, TILE_SIZE, TILE_SIZE));
    CGContextFillRect(context, CGRectMake(0, TILE_SIZE, TILE_SIZE, TILE_SIZE));
}

//旋转图片
- (void)forDrow12
{
    // 获取绘图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 保存初始状态
    CGContextSaveGState(context);
    // 形变第一步：图形上下文向右平移80
    CGContextTranslateCTM(context, 80, 0);
    // 形变第二步：缩放0.8
    CGContextScaleCTM(context, 0.8, 0.8);
    // 形变第三步：旋转
    CGContextRotateCTM(context, M_PI_4/4);
    
    UIImage *image=[UIImage imageNamed:@"IMG_1102.jPG"];
    [image drawInRect:CGRectMake(0, 150, 240, 300)];
    
    //恢复到初始状态
    CGContextRestoreGState(context);
    /*
     
     上面的截图是三种变换共同的效果，这里有必要解释一下CGContextSaveGState(context);和CGContextRestoreGState(context);这一对方法的作用是，前者的调用，将会把当前的上下文状态保存在一个“绘图状态栈”中，后者的作用是，将上一次保存在栈中的上下文状态取出，作为当前的上下文状态。这样做的目的，是因为对上下文进行变换会改变上下文整体坐标系，如果在变换上下文前，不进行保存，之后也不恢复的话，再在此上下文绘图，就会按照新的变化后的坐标系绘图，从而发生混乱。
     */
}

- (void)forDrow13
{
    
    UIImage *image = [UIImage imageNamed:@"IMG_1102.jPG"];
    //此方法只有在 UIView的 drawRect 中才有效果。
    [image drawInRect:CGRectMake(1, 80, 150, 400)];
    
    //对一张图片进行剪裁；CGImageCreateWithImageInRect 后面的参数，是以图片真实大小为参照的（而不是 图片展示的大小）
    CGImageRef imageref = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0, 0, image.size.width, image.size.height/2));
    UIImageView* cropImage = [[UIImageView alloc]initWithFrame:CGRectMake(160, 250, 150, 200)];
    cropImage.image = [UIImage imageWithCGImage:imageref];
    CGImageRelease(imageref);
    [self addSubview:cropImage];
    
}


- (void)forDrow14
{
    
    UIImageView* imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 80, 200, 400)];
    imageV.image = [UIImage imageNamed:@"loginBg"];
    [self addSubview:imageV];
    
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(200, 500, 80, 30)];
    [button addTarget:self action:@selector(toClipImage) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor brownColor]];
    [button setTitle:@"截图并保存" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:button];
}


- (void)toClipImage
{
    //该函数会自动创建一个context，并把它push到上下文栈顶，坐标系也经处理和UIKit的坐标系相同
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //把当前的整个画面导入到context中，然后通过context输出UIImage，这样就可以把整个屏幕转化为图片
    [self.layer renderInContext:context];
    clipImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self saveImage];
    
}
//保存图片
-(void)saveImage
{
    UIImageWriteToSavedPhotosAlbum(clipImage, self, @selector(savedPhotoImage:didFinishSavingWithError:contextInfo:), nil);
}
-(void)savedPhotoImage:(UIImage*)image didFinishSavingWithError: (NSError *)error contextInfo: (void *)contextInfo {
    
    if (error) {
        [self makeToast:@"保存失败"
               duration:1.50
               position:[NSValue valueWithCGPoint:CGPointMake([UIScreen mainScreen].bounds.size.width/2, 240)]];
    }
    else {
        [self makeToast:@"保存成功"
               duration:1.50
               position:[NSValue valueWithCGPoint:CGPointMake([UIScreen mainScreen].bounds.size.width/2, 240)]];    }
}


@end
