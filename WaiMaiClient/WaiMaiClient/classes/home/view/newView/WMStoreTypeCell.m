//
//  WMStoreTypeCell.m
//  WaiMaiClient
//
//  Created by 王 on 2018/8/20.
//  Copyright © 2018年 王. All rights reserved.
//

#import "WMStoreTypeCell.h"
#import "WMStoreCollectionCell.h"

@interface WMStoreTypeCell ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UIButton *listButton;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation WMStoreTypeCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
        self.backgroundColor = [UIColor whiteColor];
        
        _line = [[UIView alloc] initWithFrame:CGRectZero];
        _line.backgroundColor = ButtonColor;
        [self addSubview:_line];
        
        _titleLabel = [CYLabel initLabelWithFrame:CGRectZero text:nil textAlignment:NSTextAlignmentLeft font:[UIFont boldSystemFontOfSize:19] textColor:[UIColor blackColor]];
        [self addSubview:_titleLabel];
        
        _listButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_listButton setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
        [_listButton setImage:[UIImage imageNamed:@"store_up"] forState:UIControlStateNormal];
        [_listButton setImage:[UIImage imageNamed:@"store_down"] forState:UIControlStateSelected];
        _listButton.selected = YES;
        _listButton.titleLabel.font = [UIFont font13];
        [_listButton addTarget:self action:@selector(listButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_listButton];
        
        if ([LanguageManager shareManager].language == 0){
            _titleLabel.text = @"Restaurant List";
            [_listButton setTitle:@"        fold" forState:UIControlStateNormal];
            [_listButton setTitle:@"    unfold" forState:UIControlStateSelected];
        }else{
            _titleLabel.text = @"餐厅列表";
            [_listButton setTitle:@"收起分类" forState:UIControlStateNormal];
            [_listButton setTitle:@"展开分类" forState:UIControlStateSelected];
        }

        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake((kScreenWidth-40)/3.0, 48);
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
        [self.collectionView registerClass:[WMStoreCollectionCell class] forCellWithReuseIdentifier:@"WMStoreCollectionCell"];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _line.frame = CGRectMake(20, 31, 2, 18);
    _titleLabel.frame = CGRectMake(41, 30, 170, 20);
    _listButton.frame = CGRectMake(self.width-90, 30, 80, 20);
    [_listButton letfTextRightImage];

    _collectionView.frame = CGRectMake(0, 70, kScreenWidth, self.height-75);
    [self.collectionView reloadData];
    [_collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:_index inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    
}

- (void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
}

- (void)listButtonClicked:(UIButton *)button{
    button.selected = !button.isSelected;
    _collectionView.hidden = button.selected;
    if (self.listButtonDidTouchBlock) {
        self.listButtonDidTouchBlock(button);
    }
}

+ (CGFloat)cellHeightWithArray:(NSMutableArray *)array{
    return ((array.count%3)==0)?((array.count/3)*63+55):((array.count/3.0+1)*63+55);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WMStoreCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WMStoreCollectionCell" forIndexPath:indexPath];
    StoreTypeModel *item = _dataArray[indexPath.row];
    [cell setItem:item];
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    StoreTypeModel *item = _dataArray[indexPath.row];
    if (self.sessionViewDidTouchBlock) {
        self.sessionViewDidTouchBlock(item, indexPath.row);
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
