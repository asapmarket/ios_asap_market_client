//
//  WMStoreListCell.m
//  WaiMaiClient
//
//  Created by 王 on 2018/8/20.
//  Copyright © 2018年 王. All rights reserved.
//

#import "WMStoreListCell.h"
#import "WMStoreCell.h"
#import "StoreModel.h"
#import "StoreDetailViewController.h"

@interface WMStoreListCell ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end


@implementation WMStoreListCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
        self.backgroundColor = [UIColor whiteColor];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake((kScreenWidth-40)/3.0, (kScreenWidth-40)/3.0+51);
        layout.minimumLineSpacing = 5;
        layout.sectionInset = UIEdgeInsetsMake(10, 5, 10, 5);
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.scrollEnabled = NO;
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        [self addSubview:self.collectionView];
        
        [self.collectionView registerClass:[WMStoreCell class] forCellWithReuseIdentifier:@"WMStoreCell"];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];

    _collectionView.frame = CGRectMake(0, 10, kScreenWidth, self.height-10);
    [self.collectionView reloadData];
}

+ (CGFloat)cellHeightWithDataArray:(NSMutableArray *)dataArray{
    if (dataArray.count == 0) {
        return 0;
    }else{
        return (((dataArray.count%3 == 0) ? (dataArray.count/3) : (dataArray.count/3+1))*((kScreenWidth-40)/3.0+61))+10;
    }
}

#pragma mark -UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WMStoreCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WMStoreCell" forIndexPath:indexPath];
    StoreModel *item = _dataArray[indexPath.row];
    [cell setModel:item];
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    StoreModel *item = _dataArray[indexPath.row];
    
    StoreDetailViewController *detailCtrl = [[StoreDetailViewController alloc] init];
    detailCtrl.storeId = item.store_id;
    [[AppDelegate shared].curNav pushViewController:detailCtrl animated:YES];
    
    
    
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
