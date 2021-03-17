//
//  ZMXRepoTableViewCell.h
//  Githubb
//
//  Created by bytedance on 2021/3/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZMXRepoTableViewCell : UITableViewCell

- (void)updateWithProjectInfo:(NSString *)text image:(NSString *)image;

@end

NS_ASSUME_NONNULL_END
