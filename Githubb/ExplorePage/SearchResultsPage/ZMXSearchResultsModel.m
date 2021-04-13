//
//  ZMXSearchResultsModel.m
//  Githubb
//
//  Created by bytedance on 2021/4/2.
//

#import "ZMXSearchResultsModel.h"

@implementation ZMXSearchResultsModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
        @"userName": @"owner.login",
        @"userAvatar": @"owner.avatar_url",
        @"projectName": @"name",
        @"projectDescription": @"description",
        @"numOfStars": @"stargazers_count",
        @"projectLang": @"language",
    };
}

@end
