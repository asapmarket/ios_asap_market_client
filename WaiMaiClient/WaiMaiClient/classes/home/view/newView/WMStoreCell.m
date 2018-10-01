//
//  WMStoreCell.m
//  WaiMaiClient
//
//  Created by 王 on 2018/8/20.
//  Copyright © 2018年 王. All rights reserved.
//

#import "WMStoreCell.h"

@interface WMStoreCell ()

@property (nonatomic, strong) UIImageView *coverImageV;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;

@property (nonatomic, strong) UIImageView *closeImageV;
@property (nonatomic, strong) UILabel *closeLabel;

@end

@implementation WMStoreCell

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _coverImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (kScreenWidth-40)/3.0, (kScreenWidth-40)/3.0)];
        _coverImageV.clipsToBounds = YES;
        _coverImageV.layer.cornerRadius = 3;
        _coverImageV.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_coverImageV];
        
        _titleLabel = [CYLabel initLabelWithFrame:CGRectMake(5, (kScreenWidth-40)/3.0+10, self.width-10, 14) text:nil textAlignment:NSTextAlignmentLeft font:[UIFont font13] textColor:RGB(51, 51, 51)];
        [self addSubview:_titleLabel];
        
        _descLabel = [CYLabel initLabelWithFrame:CGRectMake(5, (kScreenWidth-40)/3.0+28, self.width-10, 13) text:nil textAlignment:NSTextAlignmentLeft font:[UIFont font12] textColor:RGB(153, 153, 153)];
        [self addSubview:_descLabel];
        
        _closeImageV = [[UIImageView alloc] initWithFrame:_coverImageV.bounds];
        _closeImageV.image = [UIImage imageNamed:@"closeTime"];
        [self addSubview:_closeImageV];
        
        _closeLabel = [CYLabel initLabelWithFrame:_coverImageV.bounds text:nil textAlignment:NSTextAlignmentCenter font:[UIFont boldSystemFontOfSize:23] textColor:[UIColor whiteColor]];
        [_closeImageV addSubview:_closeLabel];
    }
    return self;
}

- (void)setModel:(StoreModel *)model{
    [_coverImageV sd_setImageWithURL:[NSURL URLWithString:model.store_image] placeholderImage:[UIImage imageNamed:@"组-16"]];
    if ([LanguageManager shareManager].language == 0) {
        _titleLabel.text = model.store_name_en;
        _descLabel.text = model.store_desc_en;
        _closeLabel.text = @"Closed";
    }else{
        _titleLabel.text = model.store_name_cn;
        _descLabel.text = model.store_desc_cn;
        _closeLabel.text = @"打烊";
    }
    
    if (model.onwork) {
        _closeLabel.hidden = YES;
        _closeImageV.hidden = YES;
    }else{
        _closeLabel.hidden = NO;
        _closeImageV.hidden = NO;
    }
}

@end
