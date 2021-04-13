//
//  ZMXSearchResultTableModel.h
//  Githubb
//
//  Created by bytedance on 2021/4/8.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZMXSearchResultTableModel : NSObject

@property (nonatomic, copy, readonly) NSString *userName;
@property (nonatomic, copy, readonly) NSString *userAvatar;
@property (nonatomic, copy, readonly) NSString *projectName;
@property (nonatomic, copy, readonly) NSString *projectDescription;
@property (nonatomic, copy, readonly) NSNumber *numOfStars;
@property (nonatomic, copy, readonly) NSString *projectLang;

/**** 所有子控件的frame数据 ****/
/** 头像的frame */
@property (nonatomic, assign) CGRect iconFrame;
// 其他子控件的frame

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;
@end

NS_ASSUME_NONNULL_END
