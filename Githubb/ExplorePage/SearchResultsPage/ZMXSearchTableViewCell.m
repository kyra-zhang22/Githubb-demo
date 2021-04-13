//
//  ZMXSearchTableViewCell.m
//  Githubb
//
//  Created by bytedance on 2021/4/8.
//

#import "ZMXSearchTableViewCell.h"
#import <Masonry/Masonry.h>

@implementation ZMXSearchTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:NSStringFromClass(ZMXSearchTableViewCell.class)]) {
        self.userName = [[UILabel alloc] init];
        self.userName.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.userName];
        
        self.userAvatar = [[UIImageView alloc] init];
        [self.contentView addSubview:self.userAvatar];
        
        self.projectName = [[UILabel alloc] init];
        self.projectName.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.projectName];
        
        self.projectDescription = [[UILabel alloc] init];
        self.projectDescription.numberOfLines = 0;
        self.projectDescription.lineBreakMode = NSLineBreakByWordWrapping;
        self.projectDescription.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.projectDescription];
        

        [self.userAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10.0);
            make.left.equalTo(self.contentView.mas_left).offset(20.0);
            make.size.mas_equalTo(CGSizeMake(25.0, 25.0));
        }];
        
        [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.userAvatar.mas_right).offset(10.0);
            make.bottom.equalTo(self.userAvatar.mas_bottom);
            make.right.lessThanOrEqualTo(self.contentView.mas_right).offset(-20.0);
        }];
        
        [self.projectName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.userAvatar.mas_left);
            make.top.equalTo(self.userAvatar.mas_bottom).offset(10.0);
            make.right.lessThanOrEqualTo(self.contentView.mas_right).offset(-20.0);
        }];
        
        [self.projectDescription mas_makeConstraints:^(MASConstraintMaker *make) {            make.top.equalTo(self.projectName.mas_bottom).offset(10.0);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10.0);
            make.left.equalTo(self.contentView.mas_left).offset(20.0);
            make.right.equalTo(self.contentView.mas_right).offset(-20.0);
        }];
    }
    return self;
}

@end
