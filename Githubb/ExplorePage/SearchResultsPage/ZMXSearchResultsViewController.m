//
//  ZMXSearchResultsViewController.m
//  Githubb
//
//  Created by bytedance on 2021/4/2.
//

#import "ZMXSearchResultsViewController.h"
#import "ZMXSearchResultsViewModel.h"
#import "ZMXExploreViewController.h"
#import "ZMXSearchTableViewCell.h"
#import <SDWebImage/SDWebImage.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface ZMXSearchResultsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZMXSearchResultsViewModel *resultsViewModel;
@property (nonatomic, strong) ZMXExploreViewController *exploreVC;

@end

@implementation ZMXSearchResultsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = UIColor.clearColor;
    self.tableView.separatorColor = UIColor.grayColor;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 60;
    [self.tableView registerClass:ZMXSearchTableViewCell.class forCellReuseIdentifier:NSStringFromClass(ZMXSearchTableViewCell.class)];
    [self.view addSubview:self.tableView];
    
    self.resultsViewModel = [[ZMXSearchResultsViewModel alloc] init];
    [self.resultsViewModel loadDataWithSearchType:self.queryType andSearchText:self.searchText];

    [RACObserve(self.resultsViewModel, resultsModels) subscribeNext:^(id  _Nullable x) {
        [self.tableView reloadData];
    }];
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultsViewModel.resultsModels.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZMXSearchTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass(ZMXSearchTableViewCell.class)];

    cell.userName.text = [self.resultsViewModel.resultsModels objectAtIndex:indexPath.row].userName;
    
    NSString *userAvatarImage = [self.resultsViewModel.resultsModels objectAtIndex:indexPath.row].userAvatar;
    [cell.userAvatar sd_setImageWithURL:[NSURL URLWithString:userAvatarImage]
                      placeholderImage:[UIImage imageNamed:@"github_icon.png"]];
    
    cell.projectName.text = [self.resultsViewModel.resultsModels objectAtIndex:indexPath.row].projectName;
    
    cell.projectDescription.text = [self.resultsViewModel.resultsModels objectAtIndex:indexPath.row].projectDescription;
    return cell;
}

@end
