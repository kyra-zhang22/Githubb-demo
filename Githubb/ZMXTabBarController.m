//
//  ZMXTabBarController.m
//  Githubb
//
//  Created by bytedance on 2021/3/28.
//

//自定义的MyTabBarController   在该TabBarController上添加自定义tabbar视图  （CustomTabBar）
#import "ZMXTabBarController.h"
#import "ZMXTabBar.h"//自定义tabbar视图

@interface ZMXTabBarController ()<ZMXTabBarDelegate>

@property (nonatomic,strong) NSArray* allNavcTitleArray;//所有导航控制器的storyboard文件名
@property (nonatomic,strong) NSArray* allSBArray;//所有的storyboard文件名  (左侧文件夹中storyboard的创建名)
@end

@implementation ZMXTabBarController

#pragma mark--懒加载
//所有导航控制器的storyboard文件名
-(NSArray*)allNavcTitleArray{
    if (!_allNavcTitleArray) {
        _allNavcTitleArray = [[NSArray alloc] initWithObjects:@"SquareNavc",@"PrivateLetterNavc",@"ChoiceNavc",@"MineNavc", nil];
    }
    return _allNavcTitleArray;
}
//所有的storyboard文件名
-(NSArray*)allSBArray{
    if (!_allSBArray) {
        _allSBArray = [[NSArray alloc] initWithObjects:@"Square",@"PrivateLetter",@"Choice",@"Mine", nil];
    }
    return _allSBArray;
}
#pragma mark--加载视图
- (void)viewDidLoad {
    [super viewDidLoad];
    //循环添加UINavigationController  至自定义的MyTabBarController 中
    for (int i = 0; i < self.allSBArray.count; i++) {
        //获取storyboard
        UIStoryboard* SB = [UIStoryboard storyboardWithName:self.allSBArray[i] bundle:nil];
        //获取导航控制器
        UINavigationController* navc = [SB instantiateViewControllerWithIdentifier:self.allNavcTitleArray[i]];
        //添加导航控制器
        [self addChildViewController:navc];
    }
    //隐藏系统的tabBar隐藏掉
    self.tabBar.hidden = YES;
    //自定义tabbar
    //初始化自己的tabbar，并且添加到当前视图
    ZMXTabBar* initialTabBar = [[ZMXTabBar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, 0, 50)];
    [self.view addSubview:initialTabBar];
    //声明该协议
    initialTabBar.delegate = self;
}
#pragma mark--内存出错
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark--协议方法
-(void) changeViewControllerWithIndex:(NSInteger)index{
    NSLog(@"%ld",index);
    //跳转对应的导航控制器中
    self.selectedIndex = index;
}
@end
