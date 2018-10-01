//
//  SpecViewCell.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/5.
//  Copyright © 2017年 王. All rights reserved.
//

#import "SpecViewCell.h"

#define ViewW (SCREEN_WIDTH-20)

@interface SpecViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation SpecViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;

        _titleLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor hexStringToColor:@"#333333"] textAlignment:NSTextAlignmentLeft];
        [self addSubview:_titleLabel];
    }
    return self;
}

- (void)setClassModel:(SpecClassListModel *)classModel{
    _classModel = classModel;
    _titleLabel.frame = CGRectMake(10, 9, ViewW-20, 15);
    if ([LanguageManager shareManager].language == 0) {
        _titleLabel.text = classModel.spec_class_name_en;
    }else{
        _titleLabel.text = classModel.spec_class_name_cn;
    }
    [self createButtonWithClassModel:classModel index:0];
    
    if ([self.delegate respondsToSelector:@selector(specButtonClick:classModel:)]) {
        [self.delegate specButtonClick:classModel.spec_list[0] classModel:classModel];
    }
}

- (void)createButtonWithClassModel:(SpecClassListModel *)classModel index:(NSInteger)index{
    for (int i=0; i<classModel.spec_list.count; i++) {
        SpecListModel *model = classModel.spec_list[i];
        NSString *title;
        if ([LanguageManager shareManager].language == 0) {
            title = model.spec_name_en;
        }else{
            title = model.spec_name_cn;
        }
        
        
        UIButton *btn = [CreateButton initWithFrame:CGRectMake(10+((ViewW-50)/4.0+10)*(i%4), 33+ 36*(i/4), (ViewW-50)/4.0, 26) title:title titleColor:[UIColor hexStringToColor:@"#333333"] target:self action:@selector(specButtonClick:)];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];

        btn.tag = 1000+i;
        if (i == index) {
            btn.selected = YES;
            [btn setBackgroundColor:ButtonColor];
        }else{
            btn.selected = NO;
            [btn.layer setBorderColor:[UIColor hexStringToColor:@"#999999"].CGColor];
            [btn setBackgroundColor:[UIColor whiteColor]];
        }
        [self addSubview:btn];
    }
}

- (void)specButtonClick:(UIButton *)btn{
    NSInteger index = btn.tag - 1000;
    if (!btn.isSelected) {
        btn.selected = YES;
        [btn setBackgroundColor:ButtonColor];
        for (int i=0; i<_classModel.spec_list.count; i++) {
            if (btn.tag != 1000+i) {
                UIButton *un_btn = (UIButton *)[self viewWithTag:1000+i];
                un_btn.selected = NO;
                [un_btn.layer setBorderColor:[UIColor hexStringToColor:@"#999999"].CGColor];
                [un_btn setBackgroundColor:[UIColor whiteColor]];
            }
        }
        if ([self.delegate respondsToSelector:@selector(specButtonClick:classModel:)]) {
            [self.delegate specButtonClick:_classModel.spec_list[index] classModel:_classModel];
        }
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
