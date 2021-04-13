//
//  ZMXSearchResultsViewModel.h
//  Githubb
//
//  Created by bytedance on 2021/4/2.
//

#import <Foundation/Foundation.h>
#import "ZMXSearchResultsModel.h"

NS_ASSUME_NONNULL_BEGIN

//这个typedef应该写在哪
typedef NS_ENUM(NSInteger, SearchType) {
    SearchRepo,
    SearchUser
};

@interface ZMXSearchResultsViewModel : NSObject

@property (nonatomic, strong) NSMutableArray<ZMXSearchResultsModel *> *resultsModels;

- (void)loadDataWithSearchType:(SearchType)queryType andSearchText:(NSString *)searchText;

@end

NS_ASSUME_NONNULL_END
