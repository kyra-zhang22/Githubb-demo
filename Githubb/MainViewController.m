//
//  MainViewController.m
//  Githubb
//
//  Created by bytedance on 2021/3/9.
//

#import "ZMXHomePageViewController.h"
#import "MainTableViewCell.h"

@interface ZMXHomePageViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UITableView *tableView;
//@property (nonatomic, strong) NSArray *titlesArray;

@end

@implementation ZMXHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Home";
//    _titlesArray = @[@"My Work"];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.backgroundColor = UIColor.grayColor;
    _tableView.separatorColor = UIColor.blackColor;
    
    _tableView.userInteractionEnabled = YES;//设置tableView可滑动(默认yes)
    [self.view addSubview:_tableView];
    
}

//返回行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 4;
}
////返回区数
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return _titlesArray.count;
//}
//设置行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
//设置区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
//设置区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
//设置区头视图
-(nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]init];
    view.backgroundColor=[UIColor clearColor];//透明颜色
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
//    lbl.text = _titlesArray[section];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.textColor= UIColor.blackColor;
    [view addSubview:lbl];
    
    return view;
}

//设置区尾视图
-(nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    UIView *view=[[UIView alloc]init];
    view.backgroundColor=[UIColor clearColor];//透明颜色
    return view;
}

//设置cell
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//static NSString *str=@"indexpath";
//    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
//    if (!cell) {
//        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
//    }
//    //将cell设置为可点击(默认yes)
//   // cell.userInteractionEnabled = YES;
//
//    cell.textLabel.text=[NSString stringWithFormat:@"我是第%ld区 第%ld行",indexPath.section,indexPath.row];
//    cell.textLabel.textAlignment=NSTextAlignmentCenter;
//
//    return cell;
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *showUserInfoCellIdentifier = @"ShowUserInfoCell";
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:showUserInfoCellIdentifier];
    
    // Configure the cell.
    [cell updateWithText:@"text" image:nil];
    return cell;
}



//点击cell执行该方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//反选

}

////根据UI设计师给的颜色值返回出UIColor
//-(UIColor *) colorWithHexString: (NSString *)color{
//    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
//    if ([cString length] <6) {
//        return [UIColor clearColor];
//    }
//    if ([cString hasPrefix:@"0X"])
//        cString = [cString substringFromIndex:2];
//    if ([cString hasPrefix:@"#"])
//        cString = [cString substringFromIndex:1];
//    if ([cString length] !=6)
//        return [UIColor clearColor];
//    NSRange range;
//    range.location =0;
//    range.length =2;
//    NSString *rString = [cString substringWithRange:range];
//    range.location =2;
//    NSString *gString = [cString substringWithRange:range];
//    range.location =4;
//    NSString *bString = [cString substringWithRange:range];
//    unsigned int r, g, b;
//    [[NSScanner scannerWithString:rString] scanHexInt:&r];
//    [[NSScanner scannerWithString:gString] scanHexInt:&g];
//    [[NSScanner scannerWithString:bString] scanHexInt:&b];
//    return [UIColor colorWithRed:((float) r /255.0f) green:((float) g /255.0f) blue:((float) b /255.0f) alpha:1.0f];
//}


@end
