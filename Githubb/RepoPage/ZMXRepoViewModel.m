//
//  ZMXRepoViewModel.m
//  Githubb
//
//  Created by bytedance on 2021/3/24.
//

#import "ZMXRepoViewModel.h"
#import "ZMXRepoModel.h"
#import <AFNetworking/AFHTTPSessionManager.h>

@implementation ZMXRepoViewModel
static NSInteger const numOfItemsInPage = 10;

- (void)loadData:(RepoLoadDataType)loadDataType
{
    //如果是refresh，重现加载，currentoffset为0
    if (loadDataType == LoadDataRefresh) {
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
        self.repoModels = [self contentArray:repoModels atPageNum:self.currentOffset];
        self.currentOffset = self.currentOffset + 1;
    }
         failure:nil];
}

- (NSMutableArray<ZMXRepoModel *> *)contentArray:(NSArray *)models atPageNum:(NSInteger)num
{
    NSMutableArray<ZMXRepoModel *> *refreshContents = nil;
    if (models.count >= (num + 1) * numOfItemsInPage) {
        refreshContents = [[models subarrayWithRange:NSMakeRange(0, numOfItemsInPage)] mutableCopy];
    } else if (models.count >= num * numOfItemsInPage) {
        NSInteger numOfItemsLeft = models.count - (num - 1) * numOfItemsInPage - 1;
        refreshContents = [[models subarrayWithRange:NSMakeRange(0, numOfItemsLeft)] mutableCopy];
    } else {
        refreshContents = [models mutableCopy];
    }
    return refreshContents;
}

@end
