//
//  ShopCartCell.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/8.
//  Copyright © 2017年 王. All rights reserved.
//

#import "ShopCartCell.h"

@interface ShopCartCell ()

@property (weak, nonatomic) IBOutlet UIImageView *foodImageV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *specLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@end

@implementation ShopCartCell


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"ShopCartCell";
    ShopCartCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ShopCartCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setSection:(MyShopCartSection *)section{
    _section = section;
}

- (void)setListModel:(FoodsListModel *)listModel{
    _listModel = listModel;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
    [self addGestureRecognizer:tap];
    
    if (_listModel.isSelect) {
        _selectBtn.selected = YES;
    }else{
        _selectBtn.selected = NO;
    }
    
    if ([LanguageManager shareManager].language == 0) {
        [_foodImageV sd_setImageWithURL:[NSURL URLWithString:listModel.foods_name_en] placeholderImage:[UIImage imageNamed:@"组-16"]];
        _nameLabel.text = listModel.foods_name_en;
        if (listModel.specAllID.length > 0) {
            _specLabel.text = listModel.specName_en;
            _countLabel.text = [NSString stringWithFormat:@"*%d",listModel.specCount];
        }else{
            _specLabel.text = @"";
            _countLabel.text = [NSString stringWithFormat:@"*%d",listModel.count];
        }
        
    }else{
        [_foodImageV sd_setImageWithURL:[NSURL URLWithString:listModel.foods_name_cn] placeholderImage:[UIImage imageNamed:@"组-16"]];
        _nameLabel.text = listModel.foods_name_cn;
        if (listModel.specAllID.length > 0) {
            _specLabel.text = listModel.specName_cn;
            _countLabel.text = [NSString stringWithFormat:@"%d",listModel.specCount];
        }else{
            _specLabel.text = @"";
            _countLabel.text = [NSString stringWithFormat:@"%d",listModel.count];
        }
    }
    
    _priceLabel.text = [NSString stringWithFormat:@"$%@",listModel.price];

}

- (void)onTap{
    if (_selectBtn.isSelected) {
        _selectBtn.selected = NO;
        _listModel.isSelect = NO;
    }else{
        _selectBtn.selected = YES;
        _listModel.isSelect = YES;
    }
    
    if ([self.delegate respondsToSelector:@selector(shopCartCellTap:)]) {
        [self.delegate shopCartCellTap:_section];
    }
}
- (IBAction)minusButton:(UIButton *)sender {
    if (_listModel.count == 1) {
        return;
    }else{
        _listModel.count --;
    }
    if ([self.delegate respondsToSelector:@selector(shopCartCellTap:)]) {
        [self.delegate shopCartCellTap:_section];
    }
}
- (IBAction)addButton:(UIButton *)sender {
    _listModel.count ++;

    if ([self.delegate respondsToSelector:@selector(shopCartCellTap:)]) {
        [self.delegate shopCartCellTap:_section];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
