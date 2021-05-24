//
//  ZJPopOverSelectController.m
//
//  Created by knowNothingJ on 2021/4/27.
//

#import "ZJCustomPopOverSelectController.h"
#import "ZJCustomPopOverCollectionCell.h"

@interface ZJCustomPopOverSelectController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *collectView;
@property (strong, nonatomic) ZJCustomPopOverManager *popOverConfig;

@end

@implementation ZJCustomPopOverSelectController

- (instancetype)initWithConfig:(ZJCustomPopOverManager *)popManager {
    self = [super init];
    if (self) {
        _popOverConfig = popManager;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = _popOverConfig.bgColor;
    [self.view addSubview:self.collectView];
    
    if (@available(iOS 11.0, *)) {
        //iOS11 popOver控制器的frame默认会把箭头的位置也算上，为了保持collectionView的显示正确，设置约束在不包含箭头区域的安全区域
        NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.collectView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view.safeAreaLayoutGuide attribute:NSLayoutAttributeLeft multiplier:0 constant:0];
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.collectView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view.safeAreaLayoutGuide attribute:NSLayoutAttributeTop multiplier:0 constant:0];
        NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.collectView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view.safeAreaLayoutGuide attribute:NSLayoutAttributeBottom multiplier:0 constant:0];
        NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.collectView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view.safeAreaLayoutGuide attribute:NSLayoutAttributeRight multiplier:0 constant:0];
        
        [self.collectView addConstraints:@[leftConstraint, rightConstraint, topConstraint, bottomConstraint]];
    } else {
        NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.collectView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:0 constant:0];
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.collectView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:0 constant:0];
        NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.collectView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:0 constant:0];
        NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.collectView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:0 constant:0];
        
        [self.collectView addConstraints:@[leftConstraint, rightConstraint, topConstraint, bottomConstraint]];
    }
    [self.collectView reloadData];
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _operationTypeArr.count;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZJCustomPopOverCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZJCustomPopOverCollectionCell" forIndexPath:indexPath];
    ZJCustomPopOverSingleItem *item = _operationTypeArr[indexPath.row];
    [cell configCellTitle:item.itemName withImage:item.itemImage withItemImageTextType:ZJCustomPopOverItemTopImageBottomText];
    cell.titleColor = item.itemColor;
    cell.titleFont = item.itemFont;
    if (!_popOverConfig.isHorizon) {
        //竖向排列 控制分割线显示隐藏
        BOOL isLast = (indexPath.row == (_operationTypeArr.count - 1))?YES:NO;
        [cell updateLineHidden:isLast];
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ZJCustomPopOverSingleItem *item = _operationTypeArr[indexPath.row];
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.chooseBlock) {
            self.chooseBlock(item.itemName, item.operationType);
        }
    }];
}

#pragma mark - setter/getter

-(UICollectionView *)collectView {
    if (!_collectView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumInteritemSpacing = CGFLOAT_MIN;
        layout.minimumLineSpacing = CGFLOAT_MIN;
        CGFloat itemWidth = _popOverConfig.isHorizon?(_popOverConfig.preferSize.width/5.0  - 2):(_popOverConfig.preferSize.width);
        NSInteger rowNumber = _popOverConfig.isHorizon?(ceil(_operationTypeArr.count/5.0)):_operationTypeArr.count;
        CGFloat itemHeight = _popOverConfig.preferSize.height/rowNumber;
        layout.itemSize = CGSizeMake(itemWidth, itemHeight);
        _collectView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectView registerClass:[ZJCustomPopOverCollectionCell class] forCellWithReuseIdentifier:@"ZJCustomPopOverCollectionCell"];
        _collectView.showsHorizontalScrollIndicator = NO;
        _collectView.delegate = self;
        _collectView.dataSource = self;
        _collectView.scrollEnabled = NO;
    }
    return _collectView;
}


@end
