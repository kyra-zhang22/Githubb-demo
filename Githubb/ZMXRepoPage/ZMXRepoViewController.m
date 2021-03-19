//
//  ZMXRepoViewController.m
//  Githubb
//
//  Created by bytedance on 2021/3/12.
//

#import "ZMXRepoViewController.h"
#import "ZMXRepoModel.h"
#import <Masonry/Masonry.h>
#import <AFNetworking/AFHTTPSessionManager.h>
#import <Mantle/Mantle.h>
#import <MJRefresh/MJRefresh.h>
#import <SDWebImage/SDWebImage.h>

@interface ZMXRepoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<ZMXRepoModel *> *repoModels;
@property (nonatomic, assign) NSInteger currentOffset;

@end

@implementation ZMXRepoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Repositories";
    self.currentOffset = 0;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = UIColor.clearColor;
    self.tableView.separatorColor = UIColor.grayColor;
    [self.view addSubview:self.tableView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData:@"refresh"];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadData:@"loadMore"];
    }];
    
    [self.tableView.mj_header beginRefreshing];
  
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
    static NSString *str = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    cell.textLabel.text = [self.repoModels objectAtIndex:indexPath.row].name;
    NSString *image = [self.repoModels objectAtIndex:indexPath.row].picture;
    
    //using async image downloader SDWebImage
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:image]
                 placeholderImage:[UIImage imageNamed:@"github_icon.png"]];

    return cell;
}

- (void)loadData:(NSString *)loadType
{
    
    if ([loadType isEqualToString:@"refresh"]){
        self.currentOffset = 0;
    }
    //else, the loadType is loadMore so we keep the current offset
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"https://api.github.com/users/WhatTheNathan/repos?access_token="
      parameters:nil
         headers:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *dictionaryArray = responseObject;
        NSMutableArray *repoModels = [[MTLJSONAdapter modelsOfClass:ZMXRepoModel.class fromJSONArray:dictionaryArray error:nil] mutableCopy];
        
        //load ten more items
        if (repoModels.count >= (self.currentOffset + 1)*10){
            repoModels = [[repoModels subarrayWithRange:NSMakeRange((self.currentOffset - 1)*10, 10)] mutableCopy];
            self.repoModels = repoModels;
        } else if (repoModels.count >= self.currentOffset*10){
            repoModels = [[repoModels subarrayWithRange:NSMakeRange((self.currentOffset - 1)*10, repoModels.count - ((self.currentOffset - 1)*10)-1)] mutableCopy];
            [self.repoModels addObjectsFromArray:repoModels];
        } else{
            self.repoModels = repoModels;
        }
        
        [self.tableView reloadData];
    }
         failure:nil];
    
    self.currentOffset = self.currentOffset + 1;
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
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
