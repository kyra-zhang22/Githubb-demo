//
//  MainViewController.m
//  Githubb
//
//  Created by bytedance on 2021/3/9.
//

#import "ZMXHomePageViewController.h"
#import "ZMXHomePageTableViewCell.h"
#import "ZMXRepoViewController.h"

@interface ZMXHomePageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titlesArray;
@property (nonatomic, strong) NSArray *iconArray;

@end

@implementation ZMXHomePageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Homee" image:nil selectedImage:nil];
    tabBarItem.image = [[UIImage imageNamed:@"home_icon"] imageWithRenderingMode:UIImageRenderingModeAutomatic];
    self.tabBarItem = tabBarItem;
    
    self.title = @"Home";
    self.titlesArray = @[@"Issues", @"Pull Request", @"Repositories", @"Organizations"];
    self.iconArray = @[@"issues.jpeg", @"pull_request.png", @"repo.png", @"organization.png"];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = UIColor.grayColor;
    self.tableView.separatorColor = UIColor.blackColor;
    
    //register the tableview cells so it won't be nill
    [self.tableView registerClass:ZMXHomePageTableViewCell.class forCellReuseIdentifier:NSStringFromClass(ZMXHomePageTableViewCell.class)];
    [self.view addSubview:self.tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

-(nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = UIColor.blackColor;
    [view addSubview:label];
    
    return view;
}

-(ZMXHomePageTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZMXHomePageTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass(ZMXHomePageTableViewCell.class)];
    [cell updateWithText:[self.titlesArray objectAtIndex:indexPath.row] image:[self.iconArray objectAtIndex:indexPath.row]];

    return cell;
}

//?????????????????????button???repositories??????????????????repo page
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    if (indexPath.row == 2) {
        ZMXRepoViewController *repoView = [[ZMXRepoViewController alloc] init];
        [self.navigationController pushViewController:repoView animated:NO];
    }
}

@end

