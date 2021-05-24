//
//  ZJCustomPopOverSelectController.h
//
//  Created by knowNothingJ on 2021/4/27.
//

#import <UIKit/UIKit.h>
#import "ZJCustomPopOverManager.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^PopOverChooseBlock)(NSString *selectTitle, NSInteger type);

@interface ZJCustomPopOverSelectController : UIViewController

/// 当前popOVer弹出的选项数组，是ZJCustomPopOverSingleItem对象数组
@property (copy, nonatomic) NSArray *operationTypeArr;

-(instancetype)initWithConfig:(ZJCustomPopOverManager *)popManager;

@property (copy, nonatomic) PopOverChooseBlock chooseBlock;

@end

NS_ASSUME_NONNULL_END
