//
//  SpecificationView.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/5.
//  Copyright © 2017年 王. All rights reserved.
//

#import "SpecificationView.h"
#import "SpecViewCell.h"
#import "SpecListUtil.h"
#import "SpecIDBaseModel.h"
#import "HomeServer.h"

#define ViewW (_bgView.bounds.size.width)
#define ViewH (_bgView.bounds.size.height)

@interface SpecificationView ()<UITableViewDelegate, UITableViewDataSource, SpecViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *specLabel;
@property (nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, strong) UIButton *cancleBtn;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UIButton *minusBtn;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) NSString *price;

@property (nonatomic, assign) int foodCount;
@property (nonatomic, strong) SpecIDBaseModel *id_base_model;

@end

@implementation SpecificationView

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _id_base_model = [[SpecIDBaseModel alloc] init];
        _foodCount = 0;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.layer.cornerRadius = 5;
        _bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bgView];
        _specLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:17] textColor:[UIColor hexStringToColor:@"#333333"] textAlignment:NSTextAlignmentCenter];
        [_bgView addSubview:_specLabel];
        
        _line = [[UIView alloc] initWithFrame:CGRectZero];
        _line.backgroundColor = ThemeBgColor;
        [_bgView addSubview:_line];
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = ThemeBgColor;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_bgView addSubview:_tableView];

        
        _priceLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:15] textColor:ButtonColor textAlignment:NSTextAlignmentLeft];
        [_bgView addSubview:_priceLabel];
        
        _addBtn = [CreateButton initWithimage:[UIImage imageNamed:@"add_click"] target:self action:@selector(addButtonClick:)];
        [_bgView addSubview:_addBtn];
        
        _minusBtn = [CreateButton initWithimage:[UIImage imageNamed:@"minus_click"] target:self action:@selector(minusButtonClick:)];
//        _minusBtn.hidden = YES;
        [_bgView addSubview:_minusBtn];
        
        _countLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:17] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter];
//        _countLabel.hidden = YES;
        [_bgView addSubview:_countLabel];
        
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleBtn.frame = CGRectZero;
        _cancleBtn.backgroundColor = [UIColor hexStringToColor:@"#999999"];
        [_cancleBtn setTitle:NSLocalizedString(kCancel,nil) forState:UIControlStateNormal];
        [_cancleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:_cancleBtn];
        
        
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.frame = CGRectZero;
        _confirmBtn.backgroundColor = ButtonColor;
        [_confirmBtn setTitle:NSLocalizedString(kVerify,nil) forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:_confirmBtn];
        
        
        NSLog(@"%@",NSLocalizedString(kVerify,@"Localizablex"));
       

    }
    return self;
}

- (void)setListModel:(FoodsListModel *)listModel{
    _listModel = listModel;
    _price = _listModel.price;
    _id_base_model = [SpecListUtil getDefaultSpecClassIDModel:listModel];
    [self getFoodPrice];
    CGFloat Height = 0;
    if (listModel.spec_class_list.count == 0){
        Height = 0;
    }else{
        Height = [self tableViewHeight:listModel.spec_class_list];
    }

    _bgView.frame = CGRectMake(10, (SCREEN_HEIGHT-64-(Height+160))/2.0, SCREEN_WIDTH-20, Height+160);
    _line.frame = CGRectMake(10, 54, ViewW-20, 1);
    _specLabel.frame = CGRectMake(10, 0, ViewW-20, 54);
    _tableView.frame = CGRectMake(0, 55, ViewW, Height);
    _priceLabel.frame = CGRectMake(10, Height+75, 80, 17);
    _addBtn.frame = CGRectMake(ViewW-34, Height+75, 24, 24);
    _countLabel.frame = CGRectMake(ViewW-84, Height+75, 50, 24);
    _minusBtn.frame = CGRectMake(ViewW-108, Height+75, 24, 24);
    _cancleBtn.frame = CGRectMake(0, ViewH-49, ViewW/2.0, 49);
    _confirmBtn.frame = CGRectMake(ViewW/2.0, ViewH-49, ViewW/2.0, 49);
    
    _foodCount = 1;
    _countLabel.text = @"1";
    _specLabel.text = NSLocalizedString(kSelectSpec, nil);
    
    _priceLabel.text = [NSString stringWithFormat:@"$%.2f",[listModel.price doubleValue]];
    
    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:_confirmBtn.bounds byRoundingCorners:UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0, 5.0)];
    
    CAShapeLayer *maskLayer1 = [CAShapeLayer layer];
    
    maskLayer1.frame = _confirmBtn.bounds;
    maskLayer1.path = maskPath1.CGPath;
    _confirmBtn.layer.mask = maskLayer1;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_cancleBtn.bounds byRoundingCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(4.5, 4.5)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    
    maskLayer.frame = _cancleBtn.bounds;
    maskLayer.path = maskPath.CGPath;
    _cancleBtn.layer.mask = maskLayer;

    
    [_tableView reloadData];
}


- (CGFloat)tableViewHeight:(NSArray *)array{
    CGFloat height = 0;
    for (int i= 0; i<array.count; i++) {
        SpecClassListModel *model = array[i];
        if (model.spec_list.count > 4){
            height += 96;
        }else{
            height += 60;
        }
    }
    if (height > 220){
        return 220;
    }else{
        return height;
    }
}

#pragma UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listModel.spec_class_list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SpecClassListModel *model = _listModel.spec_class_list[indexPath.row];
    if (model.spec_list.count > 4) {
        return 60+36*(model.spec_list.count/4);
    }else{
        return 60;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SpecViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (cell == nil) {
        cell = [[SpecViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    }
    [cell setClassModel:_listModel.spec_class_list[indexPath.row]];
    cell.delegate = self;
    return cell;
}

- (void)specButtonClick:(SpecListModel *)model classModel:(SpecClassListModel *)classModel{

    _id_base_model = [SpecListUtil getSpecWithFoodListModel:_listModel classModel:classModel listModel:model specIdModel:_id_base_model];
    [self getFoodPrice];
}

- (void)getFoodPrice{
    NSString *spec_id_list = [SpecListUtil getSpecWithIDBaseModel:_id_base_model];
    [HomeServer getFoodsPriceUrlWithFoodId:_listModel.foods_id specIdList:spec_id_list Success:^(NSString *result) {
        _listModel.price = result;
        _priceLabel.text = [NSString stringWithFormat:@"$%.2f",[result doubleValue]];
    } failure:^(NSError *error) {
        NSLog(@"获取规格单价失败");
    }];
}

- (void)addButtonClick:(UIButton *)btn{
    _foodCount ++;
    if (_foodCount > 0) {
        _minusBtn.hidden = NO;
        _countLabel.hidden = NO;
        _countLabel.text = [NSString stringWithFormat:@"%d",_foodCount];
    }
}

- (void)minusButtonClick:(UIButton *)btn{
    _foodCount --;
    if (_foodCount <= 0) {
        _minusBtn.hidden = YES;
        _countLabel.hidden = YES;
        _foodCount = 0;
    }
    _countLabel.text = [NSString stringWithFormat:@"%d",_foodCount];

}

- (void)cancleBtnClick{
    _id_base_model = nil;
    [self removeFromSuperview];
    
}

- (void)confirmBtnClick{
    [self removeFromSuperview];
    if (_foodCount <= 0) {
        return;
    }
    NSString *specAllID = [SpecListUtil getSpecWithIDBaseModel:_id_base_model];
    if (_listModel.specCount == 0) {
        _listModel.specCount = _foodCount;
    }else{
        _listModel.specCount = _foodCount;
    }
    _listModel.specCount += [SpecListUtil stringComparison:specAllID];

    _listModel.count += _foodCount;
    _listModel.specAllID = specAllID;
    _listModel.specName_cn = [SpecListUtil getSpecNameCNWithIDBaseModel:_id_base_model];
    _listModel.specName_en = [SpecListUtil getSpecNameENWithIDBaseModel:_id_base_model];
    if ([self.delegate respondsToSelector:@selector(confirmBtnClickWithListModel:)]) {
        [self.delegate confirmBtnClickWithListModel:_listModel];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
