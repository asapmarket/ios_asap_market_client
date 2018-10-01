//
//  CourierLocationCell.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/4.
//  Copyright © 2017年 王. All rights reserved.
//

#import "CourierLocationCell.h"
@import GoogleMaps;

@interface CourierLocationCell ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *iconImageV;

@property (nonatomic, strong) UIButton *mapButton;

@property (nonatomic, strong) UIView *mapBgView;

@property (nonatomic, strong) GMSMapView *mapView;

@property (nonatomic, strong) GMSMarker *marker;

@end

@implementation CourierLocationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = ThemeBgColor;

        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 275)];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bgView];
        
        _mapBgView = [[UIView alloc] initWithFrame:CGRectMake(10, 45, SCREEN_WIDTH-20, 230)];
        _mapBgView.backgroundColor = [UIColor whiteColor];
        [_bgView addSubview:_mapBgView];
        
        _iconImageV = [[UIImageView alloc] initWithFrame:CGRectZero];
        _iconImageV.image = [UIImage imageNamed:@"location"];
        [_bgView addSubview:_iconImageV];
        
        _mapButton = [CreateButton creatButtonWithFrame:CGRectZero title:NSLocalizedString(kDeliveryLocation, nil) backCoclor:[UIColor whiteColor] tittleColor:[UIColor hexStringToColor:@"#333333"] font:[UIFont systemFontOfSize:15] image:[UIImage imageNamed:@"up"] target:self action:@selector(mapViewHiden:)];
        _mapButton.selected = NO;
        [_mapButton setImage:[UIImage imageNamed:@"down"] forState:UIControlStateSelected];
        [_bgView addSubview:_mapButton];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _iconImageV.frame = CGRectMake(10, 15, 15, 17);
    _mapButton.frame = CGRectMake(35, 0, SCREEN_WIDTH-35, 45);
    [_mapButton letfTextRightImage];

}

- (void)mapViewHiden:(UIButton *)btn{
    if (btn.isSelected){
        btn.selected = NO;
        _mapBgView.hidden = NO;
    }else{
        btn.selected = YES;
        _mapBgView.hidden = YES;
    }
}

- (void)setBaseModel:(OrderDetailBaseModel *)baseModel{
    
    double lat = 0;
    double lng = 0;
    
    if (baseModel.exp_lat != 0 && baseModel.exp_lng != 0) {
        lat = baseModel.exp_lat;
        lng = baseModel.exp_lng;
    }else{
        lat = baseModel.lat;
        lng = baseModel.lng;
    }

    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:lat longitude:lng zoom:16];
    _mapView = [GMSMapView mapWithFrame:_mapBgView.bounds camera:camera];
    [_mapBgView addSubview:_mapView];
    
    if (baseModel.exp_lat != 0 && baseModel.exp_lng != 0) {
        CLLocationCoordinate2D coords;

        coords.latitude = baseModel.exp_lat;
        coords.longitude = baseModel.exp_lng;
        
        self.marker = [GMSMarker markerWithPosition:coords];
        self.marker.title = NSLocalizedString(kDeliveryLocation, nil);
        self.marker.icon = [UIImage imageNamed:@"mapLocation"];
        self.marker.tracksViewChanges = YES;
        [_mapView setSelectedMarker:self.marker];
        self.marker.map = _mapView;
    }

}

- (void)setRunModel:(RunOrderDetailModel *)runModel{
    double lat = 0;
    double lng = 0;
    
    if (runModel.exp_lat != 0 && runModel.exp_lng != 0) {
        lat = runModel.exp_lat;
        lng = runModel.exp_lng;
    }
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:lat longitude:lng zoom:16];
    _mapView = [GMSMapView mapWithFrame:_mapBgView.bounds camera:camera];
    [_mapBgView addSubview:_mapView];
    
    if (runModel.exp_lat != 0 && runModel.exp_lng != 0) {
        CLLocationCoordinate2D coords;
        
        coords.latitude = runModel.exp_lat;
        coords.longitude = runModel.exp_lng;
        
        self.marker = [GMSMarker markerWithPosition:coords];
        self.marker.title = NSLocalizedString(kDeliveryLocation, nil);
        self.marker.icon = [UIImage imageNamed:@"mapLocation"];
        self.marker.tracksViewChanges = YES;
        [_mapView setSelectedMarker:self.marker];
        self.marker.map = _mapView;
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
