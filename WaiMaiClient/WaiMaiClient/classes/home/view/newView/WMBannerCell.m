//
//  WMBannerCell.m
//  WaiMaiClient
//
//  Created by 王 on 2018/8/17.
//  Copyright © 2018年 王. All rights reserved.
//

#import "WMBannerCell.h"
#import "ImageModel.h"
#import "HomeDetailViewController.h"

@interface WMBannerCell ()

@property (nonatomic, strong) UIImageView *defaultImageV;


@end

@implementation WMBannerCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
        
        _defaultImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, AutoFit(224))];
        _defaultImageV.image = [UIImage imageNamed:@"home_banner"];
        _defaultImageV.hidden = YES;
        [self addSubview:_defaultImageV];
        
        _bannerView = [[CYHomeBannerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, AutoFit(210))];
        _bannerView.autoTime = [NSNumber numberWithFloat:5.0f];
        [self addSubview:_bannerView];
        
        
    }
    return self;
}

- (void)setBannerArray:(NSMutableArray *)bannerArray{
    __weak typeof(self) weakSelf = self;
    
    if (bannerArray.count > 0) {
        _defaultImageV.hidden = YES;
        _bannerView.hidden = NO;
        NSMutableArray *imageArray = [NSMutableArray array];
        for (int i=0; i<bannerArray.count; i++) {
            ImageModel *item = bannerArray[i];
            [imageArray addObject:item.image];
        }
        _bannerView.slideImagesArray = imageArray;
        [_bannerView startLoading];
        
        _bannerView.cyEcrollViewSelectAction = ^(NSInteger i) {
            ImageModel *item = bannerArray[i];
            [weakSelf pushHoneDetailViewControllerWithUrl:item.url];
        };
    }else{
        _bannerView.hidden = YES;
        _defaultImageV.hidden = NO;
    }
    
    
}

- (void)pushHoneDetailViewControllerWithUrl:(NSString *)urlString{
    
    if (![urlString hasPrefix:@"https://"] && ![urlString hasPrefix:@"http://"]) {
        return;
    }
    
    HomeDetailViewController *detailCtrl = [[HomeDetailViewController alloc] init];
    detailCtrl.detailUrl = urlString;
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
