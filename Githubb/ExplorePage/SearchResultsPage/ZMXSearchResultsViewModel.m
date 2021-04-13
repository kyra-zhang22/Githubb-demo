//
//  ZMXSearchResultsViewModel.m
//  Githubb
//
//  Created by bytedance on 2021/4/2.
//

#import "ZMXSearchResultsViewModel.h"
#import "ZMXSearchResultsModel.h"
#import <AFNetworking/AFHTTPSessionManager.h>

@implementation ZMXSearchResultsViewModel

- (void)loadDataWithSearchType:(SearchType)queryType andSearchText:(NSString *)searchText
{
    NSString *get = @"https://api.github.com/search/users?q=";
    if (queryType == SearchRepo){
        get = @"https://api.github.com/search/repositories?q=";
    }
    NSString *getAddress = [get stringByAppendingString:searchText];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:getAddress
      parameters:nil
         headers:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *dictionaryArray = [responseObject objectForKey:@"items"];
        NSError *error;
        NSArray *test = [MTLJSONAdapter modelsOfClass:ZMXSearchResultsModel.class fromJSONArray:dictionaryArray error:&error];
        self.resultsModels = [test mutableCopy];
    }
         failure:nil];
}

@end
