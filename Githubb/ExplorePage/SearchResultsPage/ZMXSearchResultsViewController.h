//
//  ZMXSearchResultsViewController.h
//  Githubb
//
//  Created by bytedance on 2021/4/2.
//

#import <UIKit/UIKit.h>
#import "ZMXSearchResultsViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZMXSearchResultsViewController : UIViewController

@property (nonatomic, strong)  NSString *searchText;
//这个括号里应该是啥
@property (nonatomic)  SearchType queryType;

@end

NS_ASSUME_NONNULL_END
