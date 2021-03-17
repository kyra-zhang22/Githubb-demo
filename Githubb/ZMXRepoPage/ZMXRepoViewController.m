//
//  ZMXRepoViewController.m
//  Githubb
//
//  Created by bytedance on 2021/3/12.
//

#import "ZMXRepoViewController.h"
#import "ZMXRepoModel.h"


@interface ZMXRepoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<ZMXRepoModel *> *repoModels;

@end

@implementation ZMXRepoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Repositories";

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = UIColor.clearColor;
    self.tableView.separatorColor = UIColor.grayColor;
    [self.view addSubview:self.tableView];
    
    //用MJRefresh实现下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.mj_header beginRefreshing];
    
    //上滑加载更多（没有实现，先留着吧）
    //  self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

#pragma mark - Private Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.repoModels.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"indexpath";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
    
    cell.textLabel.text = [self.repoModels objectAtIndex:indexPath.row].name;
    NSString *image = [self.repoModels objectAtIndex:indexPath.row].picture;
    
    //using async image downloader SDWebImage
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:image]
                 placeholderImage:[UIImage imageNamed:@"github_icon.png"]];

    return cell;
}

- (void)loadNewData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"https://api.github.com/users/WhatTheNathan/repos?access_token="
      parameters:nil
         headers:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *dictionaryArray = responseObject;
        NSMutableArray *repoModels = [[MTLJSONAdapter modelsOfClass:ZMXRepoModel.class fromJSONArray:dictionaryArray error:nil] mutableCopy];
        self.repoModels = repoModels;
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    }
         failure:nil];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
            [self.repoModels removeObjectAtIndex:indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section], nil]
                                              withRowAnimation:UITableViewRowAnimationLeft];
        }
}

@end
