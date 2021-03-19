//
//  ZMXRepoModel.h
//  Githubb
//
//  Created by bytedance on 2021/3/15.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
NS_ASSUME_NONNULL_BEGIN

@interface ZMXRepoModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *picture;

@end

NS_ASSUME_NONNULL_END
