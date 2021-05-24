//
//  ZJCustomPopOverManager.h
//  Pods-ZJCustomPopOver_Example
//
//  Created by knowNothingJ on 2021/4/27.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZJCustomPopOverSingleItem;

@interface ZJCustomPopOverSingleItem : NSObject

@property (copy, nonatomic, readonly) NSString *itemName;
@property (strong, nonatomic, readonly, nullable) UIImage *itemImage;
/// 操作type，可以用作判断操作按钮
@property (assign, nonatomic) NSInteger operationType;

/// 默认为黑色
@property (strong, nonatomic) UIColor *itemColor;

/// 默认为15字体
@property (strong, nonatomic) UIFont *itemFont;

+ (ZJCustomPopOverSingleItem *)createItemWithName:(NSString *)name
                                        withImage:(UIImage * __nullable)image;

+ (ZJCustomPopOverSingleItem *)createItemWithName:(NSString *)name
                                        withImage:(UIImage * __nullable)image
                                         withType:(NSInteger)type;

+ (ZJCustomPopOverSingleItem *)createItemWithName:(NSString *)name
                                        withImage:(UIImage * __nullable)image
                                    withItemColor:(UIColor *)itemColor
                                     withItemFont:(UIFont *)font
                                         withType:(NSInteger)type;

@end

@interface ZJCustomPopOverManager : NSObject

/// 默认为UIPopoverArrowDirectionRight
@property (assign, nonatomic) UIPopoverArrowDirection arrowDirection;

/// 默认为 (78 90) 配置该气泡大小时，内部会自动根据是横向还是竖屏排布，计算cell显示大小
@property (assign, nonatomic) CGSize preferSize;

/// 指定气泡箭头在soucrView中的位置 默认为CGRectZero
@property (assign, nonatomic) CGRect sourceRect;

/// 默认为NO 表示是横向选择还是竖向选择排列
@property (assign, nonatomic) BOOL isHorizon;

/// 弹窗背景色
@property (strong, nonatomic) UIColor *bgColor;

+ (ZJCustomPopOverManager *)createDefaultManage;

- (void)showPopOverWithSourceArr:(NSArray *)sourceArr
                  withSourceView:(UIView *)sourceView
                withPresentingVC:(UIViewController<UIPopoverPresentationControllerDelegate> *)presentingVc
                 withSelectBlock:(void (^)(NSString *, NSInteger))selectBlock;


@end

NS_ASSUME_NONNULL_END
