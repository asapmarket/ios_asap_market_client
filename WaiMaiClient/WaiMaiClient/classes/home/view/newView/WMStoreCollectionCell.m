//
//  WMStoreCollectionCell.m
//  WaiMaiClient
//
//  Created by 王 on 2018/8/20.
//  Copyright © 2018年 王. All rights reserved.
//

#import "WMStoreCollectionCell.h"

@interface WMStoreCollectionCell ()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation WMStoreCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (kScreenWidth-40)/3.0, 48)];
        _imageV.image = [UIImage imageNamed:@"store_bg"];
        [self addSubview:_imageV];

        _titleLabel = [CYLabel initLabelWithFrame:self.imageV.bounds text:nil textAlignment:NSTextAlignmentCenter font:[UIFont font12] textColor:RGB(51, 51, 51)];
        [self addSubview:_titleLabel];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:self];
    if (selected) {
        _imageV.image = [UIImage imageNamed:@"store_bg_sel"];
        _titleLabel.textColor = [UIColor whiteColor];
    }else{
        _imageV.image = [UIImage imageNamed:@"store_bg"];
        _titleLabel.textColor = RGB(51, 51, 51);
    }
}

- (void)setItem:(StoreTypeModel *)item{
    if ([LanguageManager shareManager].language == 0) {
        _titleLabel.text = item.type_name_en;
    }else{
        _titleLabel.text = item.type_name_cn;
    }
}

@end
