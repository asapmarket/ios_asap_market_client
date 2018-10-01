//
//  LanguageCell.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/28.
//  Copyright © 2017年 王. All rights reserved.
//

#import "LanguageCell.h"
#import "SearchViewButton.h"

@interface LanguageCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *en_btn;
@property (nonatomic, strong) UIButton *cn_btn;

@end

@implementation LanguageCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(TableBorder, CellBorder, SCREEN_WIDTH/2.0-30, 35)];
        _titleLabel.textColor = [UIColor hexStringToColor:@"#333333"];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.text= NSLocalizedString(kLanguage,nil);
        [self addSubview:_titleLabel];
        
        _cn_btn  = [SearchViewButton initWithFrame:CGRectMake(SCREEN_WIDTH/2.0-30, 0, (SCREEN_WIDTH/2.0+30)/2.0-20, 55) title:NSLocalizedString(kChinese,nil) image:[UIImage imageNamed:@"circle_click"] target:self action:@selector(cnButtonClick:)];
        [self addSubview:_cn_btn];
        
        _en_btn = [SearchViewButton initWithFrame:CGRectMake(SCREEN_WIDTH/2.0+(SCREEN_WIDTH/2.0+30)/2.0-50, 0, (SCREEN_WIDTH/2.0+30)/2.0-20, 55) title:NSLocalizedString(kEnglish,nil) image:[UIImage imageNamed:@"circle"] target:self action:@selector(enButtonClick:)];
        [self addSubview:_en_btn];
        
        if ([[LanguageManager shareManager].userLanguage isEqualToString:kSetEnglish]){
            _en_btn.selected = YES;
            [_en_btn setImage:[UIImage imageNamed:@"circle_click"] forState:UIControlStateNormal];
            
            _cn_btn.selected = NO;
            [_cn_btn setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
        }else{
            _cn_btn.selected = YES;
            [_cn_btn setImage:[UIImage imageNamed:@"circle_click"] forState:UIControlStateNormal];
            _en_btn.selected = NO;
            [_en_btn setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];

        }
        
    }
    return self;
}

- (void)cnButtonClick:(UIButton *)btn{
    if (!btn.isSelected) {
        _cn_btn.selected = YES;
        [_cn_btn setImage:[UIImage imageNamed:@"circle_click"] forState:UIControlStateNormal];
        
        _en_btn.selected = NO;
        [_en_btn setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:LanguageChange object:kSetChinese];
    }
}

- (void)enButtonClick:(UIButton *)btn{
    if (!btn.isSelected) {
        _en_btn.selected = YES;
        [_en_btn setImage:[UIImage imageNamed:@"circle_click"] forState:UIControlStateNormal];
        
        _cn_btn.selected = NO;
        [_cn_btn setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
        [[NSNotificationCenter defaultCenter] postNotificationName:LanguageChange object:kSetEnglish];
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
