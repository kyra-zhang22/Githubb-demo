//
//  ZMXSearchTableViewCell.h
//  Githubb
//
//  Created by bytedance on 2021/4/8.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZMXSearchTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *userName;
@property (nonatomic, strong) UIImageView *userAvatar;
@property (nonatomic, strong) UILabel *projectName;
@property (nonatomic, strong) UILabel *projectDescription;
@property (nonatomic, strong) NSNumber *numOfStars;
@property (nonatomic, strong) UILabel *projectLang;

@end

NS_ASSUME_NONNULL_END
