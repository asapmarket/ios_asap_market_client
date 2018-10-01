//
//  StoreViewCell.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/1.
//  Copyright © 2017年 王. All rights reserved.
//

#import "StoreViewCell.h"
#import "ShopCollectionViewCell.h"

@interface StoreViewCell ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation StoreViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"StoreViewCell";
    StoreViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"StoreViewCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;

    }
    return cell;
}

- (void)initView{
    _collectionView.backgroundColor = [UIColor whiteColor];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.minimumInteritemSpacing = 10;
    layout.itemSize = CGSizeMake((SCREEN_WIDTH-30)/2.0, 220);
    layout.scrollDirection = 0;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.height) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.scrollEnabled = NO;
    [_collectionView registerNib:[UINib nibWithNibName:@"ShopCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cellID"];
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_collectionView];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _collectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.height);
}

- (void)setStoreArray:(NSArray *)storeArray{
    _storeArray = storeArray;
    [self initView];
    [_collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _storeArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ShopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    cell.layer.borderColor = [UIColor hexStringToColor:@"#ebebeb"].CGColor;
    cell.layer.borderWidth = 0.5;
    cell.model = _storeArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(storeViewDidClick:)]) {
        [self.delegate storeViewDidClick:_storeArray[indexPath.row]];
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
