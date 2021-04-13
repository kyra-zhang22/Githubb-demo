//
//  ZMXTabBar.m
//  Githubb
//
//  Created by bytedance on 2021/3/28.
//

#import "ZMXTabBar.h"

@interface ZMXTabBar ()

//数组
@property (nonatomic,strong) NSArray* btnArray;//按钮数组
@property (nonatomic,strong) NSArray* image1;//初始图片数组
//@property (nonatomic,strong) NSArray* image2;//点击后图片数组
@property (nonatomic,strong) NSArray* titleArray;//下部标题

@end
@implementation ZMXTabBar

#pragma mark--懒加载
//按钮数组
-(NSArray*)btnArray{

    if (!_btnArray) {
         _btnArray = [[NSArray alloc] initWithObjects:[UIButton buttonWithType:(UIButtonTypeSystem)],[UIButton buttonWithType:(UIButtonTypeSystem)],[UIButton buttonWithType:(UIButtonTypeSystem)],[UIButton buttonWithType:(UIButtonTypeSystem)],[UIButton buttonWithType:(UIButtonTypeSystem)], nil];
    }
    return _btnArray;
}
//初始图片数组
-(NSArray*)image1{
    
    //图片数据且取消渲染
    if (!_image1) {
        _image1 = [[NSArray alloc] initWithObjects:[[UIImage imageNamed:@"homePage1"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)],[[UIImage imageNamed:@"classify1"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)],[[UIImage imageNamed:@"find1"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)],[[UIImage imageNamed:@"shopping1"]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)],[[UIImage imageNamed:@"mine1"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)], nil];
    }
    return _image1;
}
////点击后图片数组
//-(NSArray*)image2{
//
//    //图片数据且取消渲染
//    if (!_image2) {
//       _image2 = [[NSArray alloc] initWithObjects:[[UIImage imageNamed:@"homePage2"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)],[[UIImage imageNamed:@"classify2"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)],[[UIImage imageNamed:@"find2"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)],[[UIImage imageNamed:@"shopping2"]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)],[[UIImage imageNamed:@"mine2"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)], nil];
//    }
//    return _image2;
//}

#pragma mark--初始化方法
-(instancetype)initWithFrame:(CGRect)frame{

    //判断传递的frame高度   默认为50
    if (frame.size.height != 50) {
        frame.size.height = 50;
    }
    //默认宽度为屏宽
    frame.size.width = [UIScreen mainScreen].bounds.size.width;
    //父类继承
    self = [super initWithFrame:frame];
    //是否存在
    if (self) {
        //为当前视图添加子视图方法
        [self mySubViews];
        //背景色
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
   
}

#pragma mark---为当前视图添加子视图
-(void)mySubViews{
    //循环添加 按钮
    for (int i = 0; i < self.btnArray.count; i++) {
        //获取数组中按钮，设置按钮大小
        UIButton* btn = self.btnArray[i];
        btn.frame = CGRectMake(self.frame.size.width / 5 * i, 0, self.frame.size.width / 5, self.frame.size.height );
           //设置按钮图片  tag值    回调方法

        
        [btn setImage:self.image1[i] forState:(UIControlStateNormal)];
        btn.tag = 1000 + i;
        [btn addTarget:self action:@selector(changeIndex:) forControlEvents:(UIControlEventTouchDown)];

        //图片自适应大小
        btn.imageView.contentMode = UIViewContentModeScaleAspectFill;
        btn.imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        btn.imageView.clipsToBounds = YES;
        
        //添加按钮
        [self addSubview:btn];
    }
  
}

#pragma mark--按钮回调方法
-(void)changeIndex:(UIButton*)sender{
    NSLog(@"按钮回调方法");
    
    //恢复初始
    [self initial];
    //设置一个初始值   通过循环获取到该按钮位置
    int num = 0;
    for (int i = 0; i < self.btnArray.count; i++) {
        if (sender == [self viewWithTag:i + 1000]) {
            num = i;
        }
    }
    //更改选中按钮的状态    图片
//    [sender setImage:self.image2[num] forState:(UIControlStateNormal)];
    //调用协议方法
    [self delegateAction:num];
}

#pragma mark--按钮恢复初始状态
-(void)initial{
    //循环恢复按钮初始状态
    for (int i = 0; i < self.btnArray.count; i++) {
        UIButton* btn = self.btnArray[i];
        [btn setImage:self.image1[i] forState:(UIControlStateNormal)];
    }
}

#pragma mark--需要调用协议方法
-(void)delegateAction:(int)index{
    //判断协议是否存在以及是否有协议对应方法
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeViewControllerWithIndex:)]) {
        //带有选中位置参数的协议方法
        [self.delegate changeViewControllerWithIndex:index];
    }
}
@end
