//
//  ZMXRepoViewModel.h
//  Githubb
//
//  Created by bytedance on 2021/3/24.
//

#import <Foundation/Foundation.h>
#import "ZMXRepoModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, RepoLoadDataType) {
    LoadDataRefresh,
    LoadDataMore
};

@interface ZMXRepoViewModel : NSObject

@property (nonatomic, strong) NSMutableArray<ZMXRepoModel *> *repoModels;
@property (nonatomic, assign) NSInteger currentOffset;

- (void)loadData:(RepoLoadDataType)loadDataType;

@end

NS_ASSUME_NONNULL_END

