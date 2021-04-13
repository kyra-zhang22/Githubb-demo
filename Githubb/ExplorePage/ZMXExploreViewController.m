//
//  ZMXExploreViewController.m
//  Githubb
//
//  Created by bytedance on 2021/3/30.
//

#import "ZMXExploreViewController.h"
#import "ZMXSearchResultsViewController.h"
#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface ZMXExploreViewController ()<UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UISearchBar *exploreSearchBar;
@property (nonatomic, strong) NSMutableArray *searchHistoryArr;
@property (nonatomic, strong) UITableView *searchHistoryTable;
@property (nonatomic, strong) UITableView *suggestionTable;
@property (nonatomic, strong) NSArray *suggestionArray;
@property (nonatomic, strong) UILabel *recentSearches;
@end

@implementation ZMXExploreViewController

//use as the key for saving last ten search history items in UserDefaults
static NSString *historyIdentifier = @"historyIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.blackColor;
    
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Explore" image:nil selectedImage:nil];
    tabBarItem.image = [[UIImage imageNamed:@"explore_icon"] imageWithRenderingMode:UIImageRenderingModeAutomatic];
    self.tabBarItem = tabBarItem;
    
    self.exploreSearchBar = [[UISearchBar alloc] init];
    self.exploreSearchBar.delegate = self;
    [self.view addSubview:self.exploreSearchBar];    
    self.exploreSearchBar.placeholder = @"Search Github";
    [self.exploreSearchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(30 + 44);
        make.left.mas_equalTo(self.view).mas_offset(16);
        make.right.mas_equalTo(self.view).mas_offset(-16);
        make.height.mas_equalTo(30);
    }];
    
    self.searchHistoryTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 150, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.searchHistoryTable.delegate = self;
    self.searchHistoryTable.dataSource = self;
    self.searchHistoryTable.backgroundColor = UIColor.whiteColor;
    self.searchHistoryTable.separatorColor = UIColor.blackColor;
    [self.view addSubview:self.searchHistoryTable];
    self.searchHistoryTable.alpha = 0;
    self.searchHistoryArr = [[NSMutableArray alloc] init];
    
    self.suggestionTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 88) style:UITableViewStylePlain];
    self.suggestionTable.delegate = self;
    self.suggestionTable.dataSource = self;
    self.suggestionTable.backgroundColor = UIColor.grayColor;
    self.suggestionTable.separatorColor = UIColor.blackColor;
    [self.view addSubview:self.suggestionTable];
    self.suggestionArray = [NSArray arrayWithObjects:@"Repositories with:", @"People with:", nil];
    self.suggestionTable.alpha = 0;
    
    self.recentSearches = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, self.view.frame.size.width, 50)];
    self.recentSearches.font = [UIFont systemFontOfSize:20];
    self.recentSearches.text = @"Recent Searches";
    self.recentSearches.textColor = UIColor.whiteColor;
    [self.view addSubview:self.recentSearches];
    self.recentSearches.alpha = 0;
}

#pragma mark - UISearchBar History

- (NSArray *)readHistory
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.searchHistoryArr = [NSMutableArray arrayWithArray:[userDefaults arrayForKey:historyIdentifier]];
    return [self.searchHistoryArr copy];
}

- (void)saveSearchInfo:(NSString *)newSearchString
{
    if (self.searchHistoryArr.count >= 10) {
        [self.searchHistoryArr removeObjectAtIndex:0];
    }
    
    for (NSString *tmp in self.searchHistoryArr) {
        if ([tmp isEqualToString:newSearchString]) {
            [self.searchHistoryArr removeObject:tmp];
            break;
        }
    }
    
    [self.searchHistoryArr addObject:newSearchString];
    NSArray *saveArr = [NSArray arrayWithArray:self.searchHistoryArr];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:saveArr forKey:historyIdentifier];
    [userDefaults synchronize];
    
    [self.searchHistoryTable reloadData];
}

- (void)cleanHistory
{
    [self.searchHistoryArr removeAllObjects];
    NSArray *saveArr = [NSArray array];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:saveArr forKey:historyIdentifier];
    [userDefaults synchronize];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    self.exploreSearchBar.text = @"";
    self.exploreSearchBar.showsCancelButton = NO;
    [UIView animateWithDuration:1 animations:^{
        self.searchHistoryTable.alpha = 0.f;
        self.searchHistoryTable.alpha = 0.f;
        self.recentSearches.alpha = 0.f;
    }];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    NSString *searchText = self.exploreSearchBar.text;
    if ([searchText isEqual:@""]){
        [UIView animateWithDuration:1 animations:^{
            self.searchHistoryTable.alpha = 1-0.f;
            self.recentSearches.alpha = 1-0.f;
        }];
        [searchBar setShowsCancelButton:YES animated:YES];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [UIView animateWithDuration:1 animations:^{
        self.searchHistoryTable.center = CGPointMake(self.searchHistoryTable.center.x, 100);
        self.searchHistoryTable.alpha = 0.f;
        self.recentSearches.center = CGPointMake(self.recentSearches.center.x, 80);
        self.recentSearches.alpha = 0.f;
        self.suggestionTable.center = CGPointMake(self.suggestionTable.center.x, 150);
        self.suggestionTable.alpha = 1-0.f;
    }];
    
    NSString *repoString = [@"Repositories with: " stringByAppendingString:searchText];
    NSString *peopleString = [@"People with: " stringByAppendingString:searchText];
    self.suggestionArray = [NSArray arrayWithObjects:repoString, peopleString, nil];
    [self.suggestionTable reloadData];
    
    if ([searchText isEqual:@""]){
        [UIView animateWithDuration:1 animations:^{
            self.searchHistoryTable.center = CGPointMake(self.searchHistoryTable.center.x, 430);
            self.searchHistoryTable.alpha = 1-0.f;
            self.recentSearches.center = CGPointMake(self.recentSearches.center.x, 125);
            self.recentSearches.alpha = 1-0.f;
            self.suggestionTable.center = CGPointMake(self.suggestionTable.center.x, 200);
            self.suggestionTable.alpha = 0.f;
        }];
    }
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.searchHistoryTable]) {
        return self.searchHistoryArr.count;
    }else {
        return 2;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    if ([tableView isEqual:self.searchHistoryTable]) {
        NSArray* reversedArray = [[[NSArray arrayWithArray:self.searchHistoryArr] reverseObjectEnumerator] allObjects];
        cell.textLabel.text = [reversedArray objectAtIndex:indexPath.row];
        return cell;
    } else {
        cell.textLabel.text = [self.suggestionArray objectAtIndex:indexPath.row];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.suggestionTable]) {
        ZMXSearchResultsViewController *resultsView = [[ZMXSearchResultsViewController alloc] init];
        NSString *text = self.exploreSearchBar.text;
        [self saveSearchInfo:text];
        resultsView.searchText = text;
        
        if (indexPath.row == 0) {
            resultsView.queryType = SearchRepo;
            [resultsView reloadInputViews];
            [self.navigationController pushViewController:resultsView animated:NO];
        } else if (indexPath.row == 1) {
            resultsView.queryType = SearchUser;
            [self.navigationController pushViewController:resultsView animated:NO];
        }
    }
}

@end
