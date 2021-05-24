//
//  ZJCustomPopOverManager.m
//  Pods-ZJCustomPopOver_Example
//
//  Created by knowNothingJ on 2021/4/27.
//

#import "ZJCustomPopOverManager.h"
#import "ZJCustomPopOverSelectController.h"

@interface ZJCustomPopOverSingleItem ()

@property (copy, nonatomic, readwrite) NSString *itemName;
@property (strong, nonatomic, readwrite, nullable) UIImage *itemImage;

@end

@implementation ZJCustomPopOverSingleItem

+(ZJCustomPopOverSingleItem *)createItemWithName:(NSString *)name withImage:(UIImage *)image {
    return [self createItemWithName:name withImage:image withItemColor:UIColor.blackColor withItemFont:[UIFont systemFontOfSize:14] withType:0];
}

+(ZJCustomPopOverSingleItem *)createItemWithName:(NSString *)name withImage:(UIImage *)image withType:(NSInteger)type {
    return [self createItemWithName:name withImage:image withItemColor:UIColor.blackColor withItemFont:[UIFont systemFontOfSize:14] withType:type];
}

+(ZJCustomPopOverSingleItem *)createItemWithName:(NSString *)name withImage:(id)image withItemColor:(UIColor *)itemColor withItemFont:(UIFont *)font withType:(NSInteger)type {
    ZJCustomPopOverSingleItem *item = [[ZJCustomPopOverSingleItem alloc]init];
    item.itemName = name;
    item.itemImage = image;
    item.operationType = type;
    item.itemColor = itemColor;
    item.itemFont = font;
    return item;
}

@end

@implementation ZJCustomPopOverManager

+(ZJCustomPopOverManager *)createDefaultManage {
    ZJCustomPopOverManager *config = [[ZJCustomPopOverManager alloc]init];
    config.arrowDirection = UIPopoverArrowDirectionRight;
    config.preferSize = CGSizeMake(78, 90);
    config.isHorizon = NO;
    config.sourceRect = CGRectZero;
    config.bgColor = UIColor.whiteColor;
    return config;
}

-(void)showPopOverWithSourceArr:(NSArray *)sourceArr withSourceView:(id)sourceView withPresentingVC:(id)presentingVc withSelectBlock:(void (^)(NSString * _Nonnull, NSInteger))selectBlock {
    if (![presentingVc conformsToProtocol:@protocol(UIPopoverPresentationControllerDelegate)]) {
        NSLog(@"ZJCustomPopOverManager------传入的presentingVc未遵守popover协议");
        return;
    }
    ZJCustomPopOverSelectController *selct = [[ZJCustomPopOverSelectController alloc]initWithConfig:self];
    selct.operationTypeArr = sourceArr;
    selct.chooseBlock = ^(NSString *selectTitle, NSInteger type) {
        if (selectBlock) {
            selectBlock(selectTitle, type);
        }
    };
    selct.preferredContentSize = self.preferSize;
    selct.modalPresentationStyle = UIModalPresentationPopover;
    UIPopoverPresentationController *popController = selct.popoverPresentationController;
    popController.delegate = presentingVc;
    popController.backgroundColor = self.bgColor;
    popController.permittedArrowDirections = self.arrowDirection;
    popController.sourceView = sourceView;
    popController.sourceRect = self.sourceRect;
    [presentingVc presentViewController:selct animated:YES completion:NULL];
}

@end
