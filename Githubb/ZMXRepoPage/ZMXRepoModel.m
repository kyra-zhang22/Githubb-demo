//
//  ZMXRepoModel.m
//  Githubb
//
//  Created by bytedance on 2021/3/15.
//

#import "ZMXRepoModel.h"

@implementation ZMXRepoModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
        @"name": @"name",
        @"picture": @"owner.avatar_url",
    };
}

@end
