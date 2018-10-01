//
//  ShopCollectionViewCell.m
//  WaiMaiClient
//
//  Created by 王 on 2017/7/25.
//  Copyright © 2017年 王. All rights reserved.
//

#import "ShopCollectionViewCell.h"

@implementation ShopCollectionViewCell


- (void)setModel:(StoreModel *)model{
    _model = model;
    [_picImageView sd_setImageWithURL:[NSURL URLWithString:model.store_image] placeholderImage:[UIImage imageNamed:@"组-16"]];
    if ([LanguageManager shareManager].language == 0) {
        _titleLabel.text = model.store_name_en;
        _descLabel.text = model.store_desc_en;
    }else{
        _titleLabel.text = model.store_name_cn;
        _descLabel.text = model.store_desc_cn;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
