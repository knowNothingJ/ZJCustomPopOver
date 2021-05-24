//
//  ZJCustomPopOverCollectionCell.h
//
//  Created by ZJCustomPopOver on 2021/4/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ZJCustomPopOverItemImageTextType) {
    ZJCustomPopOverItemTopTextBottomImage,   //文字在上，图片在下
    ZJCustomPopOverItemTopImageBottomText,    //图片在上，文字在下
    ZJCustomPopOverItemOnlyText,            //只有文字
    ZJCustomPopOverItemOnlyImage,           //只有图片
};

@interface ZJCustomPopOverCollectionCell : UICollectionViewCell

/// 分割线颜色
@property (strong, nonatomic) UIColor *lineColor;

/// 标题颜色
@property (strong, nonatomic) UIColor *titleColor;
@property (strong, nonatomic) UIFont *titleFont;

- (void)configCellTitle:(NSString *)title
              withImage:(UIImage * __nullable)image
  withItemImageTextType:(ZJCustomPopOverItemImageTextType)type;

- (void)configCellAttTitle:(NSAttributedString *)attTitle
                 withImage:(UIImage *)image
     withItemImageTextType:(ZJCustomPopOverItemImageTextType)type;

- (void)updateLineHidden:(BOOL)isHide;

@end

NS_ASSUME_NONNULL_END
