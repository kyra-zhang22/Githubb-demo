//
//  ZMXSearchResultsModel.h
//  Githubb
//
//  Created by bytedance on 2021/4/2.
//

#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZMXSearchResultsModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *userName;
@property (nonatomic, copy, readonly) NSString *userAvatar;
@property (nonatomic, copy, readonly) NSString *projectName;
@property (nonatomic, copy, readonly) NSString *projectDescription;
@property (nonatomic, copy, readonly) NSNumber *numOfStars;
@property (nonatomic, copy, readonly) NSString *projectLang;

@end

NS_ASSUME_NONNULL_END
