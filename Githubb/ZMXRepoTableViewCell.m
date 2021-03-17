//
//  ZMXRepoTableViewCell.m
//  Githubb
//
//  Created by bytedance on 2021/3/15.
//

#import "ZMXRepoTableViewCell.h"
#import "Masonry.h"

@implementation ZMXRepoTableViewCell

- (void)updateWithProjectInfo:(NSString *)projectname projectName:(NSString *)name picture:(NSString *)image
{

    
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 2, 20, 20)];
    icon.image = [UIImage imageNamed:image];;
    [self.contentView addSubview:icon];
//
//    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.contentView).mas_offset(10);
//        make.left.mas_equalTo(self.contentView).mas_offset(10);
//        make.right.mas_equalTo(self.contentView).mas_offset(-10);
//        make.height.mas_equalTo(15);
//    }];
//
    UILabel *title = [[UILabel alloc] init];
    title.text = text;
    title.textColor = UIColor.blackColor;
    [self.contentView addSubview:title];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).mas_offset(2);
        make.left.mas_equalTo(icon.mas_right).mas_offset(20);
        make.right.mas_equalTo(self.contentView).mas_offset(-10);
        make.height.mas_equalTo(self.contentView);
    }];
    
}

@end
