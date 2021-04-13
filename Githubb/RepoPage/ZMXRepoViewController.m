//
//  ZMXRepoViewController.m
//  Githubb
//
//  Created by bytedance on 2021/3/12.
//

#import "ZMXRepoViewController.h"
#import "ZMXRepoModel.h"
#import "ZMXRepoViewModel.h"
#import <Masonry/Masonry.h>
#import <AFNetworking/AFHTTPSessionManager.h>
#import <Mantle/Mantle.h>
#import <MJRefresh/MJRefresh.h>
#import <SDWebImage/SDWebImage.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface ZMXRepoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZMXRepoViewModel *repoViewModel;

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

    self.repoViewModel = [[ZMXRepoViewModel alloc] init];
//    [self addObserver:self
//           forKeyPath:@"self.repoViewModel.repoModels"
//              options:NSKeyValueObservingOptionNew
//              context:nil];
//
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.repoViewModel loadData:LoadDataRefresh];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self.repoViewModel loadData:LoadDataMore];
    }];
    [self.tableView.mj_header beginRefreshing];
    
    [RACObserve(self.repoViewModel, repoModels) subscribeNext:^(id  _Nullable x) {
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.repoViewModel.repoModels.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
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
    
    cell.textLabel.text = [self.repoViewModel.repoModels objectAtIndex:indexPath.row].name;
    NSString *image = [self.repoViewModel.repoModels objectAtIndex:indexPath.row].picture;

    //using async image downloader SDWebImage
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:image]
                      placeholderImage:[UIImage imageNamed:@"github_icon.png"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.repoViewModel.repoModels removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section], nil]
                              withRowAnimation:UITableViewRowAnimationLeft];
        }
}

#pragma mark - KVO

//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
//    [self.tableView reloadData];
//    [self.tableView.mj_header endRefreshing];
//    [self.tableView.mj_footer endRefreshing];
//}

@end
