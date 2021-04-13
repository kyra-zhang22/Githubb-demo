//
//  ZMXSearchResultTableModel.m
//  Githubb
//
//  Created by bytedance on 2021/4/8.
//

#import "ZMXSearchResultTableModel.h"

@implementation ZMXSearchResultTableModel

- (CGFloat)cellHeight
{
    // 必须有这个判断，否则每次刷新cell都会不断重算cellHeight
    if (self.cellHeight == 0) {
        // ... 计算所有子控件的frame、cell的高度，并记录下来

        // 尺寸不变的控件frame计算，例如图片
        CGFloat iconX = 10;
        CGFloat iconY = 10;
        CGFloat iconW = 50;
        CGFloat iconH = 50;
        self.iconFrame =CGRectMake(iconX, iconY, iconW, iconH);// 记录控件大小

//        CGFloat nameX = CGRectGetMaxX(self.iconImageViewFrame) + margin;
//        CGFloat nameY = CGRectGetMaxY(self.iconImageViewFrame) + margin;
//        CGFloat nameW = [UIScreen mainScreen].bounds.size.width - 2 * nameX;
//        NSDictionary *nameAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:14]};
//        CGSize nameMaxSize = CGSizeMake(TEXTW, MAXFLOAT);
//        CGFloat nameH = [self.text boundingRectWithSize:TEXTMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:nameAttributes context:nil].size.height;
//        self.nameLabelFrame =CGRectMake(nameX, nameY, nameW, nameH);

        // cellHeight等于最后一个控件的最大Y值 + 间隔值
        // _cellHeight = ...
    }
    return self.cellHeight;
}
@end
