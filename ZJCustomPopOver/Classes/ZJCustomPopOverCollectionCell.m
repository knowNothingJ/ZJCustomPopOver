//
//  ZJCustomPopOverCollectionCell.m
//
//  Created by knowNothingJ on 2021/4/27.
//

#import "ZJCustomPopOverCollectionCell.h"

@interface ZJCustomPopOverCollectionCell ()

@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UIImageView *contentImageView;
@property (strong, nonatomic) UIView *lineView;

@property (assign, nonatomic) ZJCustomPopOverItemImageTextType layoutType;

@end

@implementation ZJCustomPopOverCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    CGSize contentSize = [_contentLabel.text sizeWithAttributes:@{NSFontAttributeName : self.contentLabel.font}];
    CGSize imageSize = self.contentImageView.image.size;

    CGFloat width = self.contentView.frame.size.width;
    CGFloat height = self.contentView.frame.size.height;
    switch (_layoutType) {
        case ZJCustomPopOverItemOnlyText:
            self.contentImageView.hidden = YES;
            self.contentLabel.hidden = NO;
            self.contentLabel.frame = CGRectMake((width - contentSize.width)/2.0, (height - contentSize.height)/2.0, contentSize.width, contentSize.height);
            break;
        case ZJCustomPopOverItemOnlyImage:
            self.contentImageView.hidden = NO;
            self.contentLabel.hidden = YES;
            self.contentImageView.frame = CGRectMake((width - imageSize.width)/2.0, (height - imageSize.height)/2.0, imageSize.width, imageSize.height);
            break;
        case ZJCustomPopOverItemTopImageBottomText:
            self.contentImageView.frame = CGRectMake((width - imageSize.width)/2.0, 0, imageSize.width, imageSize.height);
            self.contentLabel.frame = CGRectMake((width - contentSize.width)/2.0, imageSize.height + 3, contentSize.width, contentSize.height);
            break;
        case ZJCustomPopOverItemTopTextBottomImage:
            self.contentLabel.frame = CGRectMake((width - contentSize.width)/2.0, 0, contentSize.width, contentSize.height);
            self.contentImageView.frame = CGRectMake((width - imageSize.width)/2.0, contentSize.height + 3, imageSize.width, imageSize.height);
            break;
    }
    self.lineView.frame = CGRectMake(0, height - 0.5, width, 0.5);
}

#pragma mark - public method

-(void)configCellTitle:(NSString *)title withImage:(UIImage *)image withItemImageTextType:(ZJCustomPopOverItemImageTextType)type {
    self.contentImageView.image = image;
    self.contentLabel.text = title;
    [self setNeedsLayout];
}

-(void)configCellAttTitle:(NSAttributedString *)attTitle withImage:(UIImage *)image withItemImageTextType:(ZJCustomPopOverItemImageTextType)type {
    self.contentImageView.image = image;
    self.contentLabel.attributedText = attTitle;
    [self setNeedsLayout];
}

-(void)updateLineHidden:(BOOL)isHide {
    self.lineView.hidden = isHide;
}

#pragma mark - private method

- (void)configUI {
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.contentImageView];
    [self.contentView addSubview:self.lineView];
}

#pragma mark - setter/getter

-(void)setLineColor:(UIColor *)lineColor {
    _lineView.backgroundColor = lineColor;
}

-(void)setTitleColor:(UIColor *)titleColor {
    self.contentLabel.textColor = titleColor;
}

-(void)setTitleFont:(UIFont *)titleFont {
    self.contentLabel.font = titleFont;
}

-(UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = UIColor.whiteColor;
    }
    return _lineView;
}

-(UILabel *)contentLabel {
    if(!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
    }
    return _contentLabel;
}

-(UIImageView *)contentImageView {
    if(!_contentImageView) {
        _contentImageView = [[UIImageView alloc]init];
    }
    return _contentImageView;
}

@end
