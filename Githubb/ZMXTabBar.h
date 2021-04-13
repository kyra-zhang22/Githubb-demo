//
//  ZMXTabBar.h
//  Githubb
//
//  Created by bytedance on 2021/3/28.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZMXTabBarDelegate <NSObject>

//参数就是传递当前点击的是哪一个按钮，controller根据index来切换子视图控制器
-(void) changeViewControllerWithIndex:(NSInteger) index;

@end

@interface ZMXTabBar : UIView

@property (nonatomic,assign) id <ZMXTabBarDelegate> delegate;//协议代理

@end

NS_ASSUME_NONNULL_END
