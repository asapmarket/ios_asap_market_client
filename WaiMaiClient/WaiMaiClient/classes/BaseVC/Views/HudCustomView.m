//
//  HudCustomView.m
//  SSKingdom
//
//  Created by chason on 2017/12/28.
//  Copyright © 2017年 3Songshu. All rights reserved.
//

#import "HudCustomView.h"

@implementation HudCustomView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame=CGRectMake(0,0,kScreenWidth, kScreenWidth);
        _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, AutoFit(120), AutoFit(120))];
        _imageView.topCenter=CGPointMake(self.width/2, (self.height-AutoFit(120))/2);
        NSMutableArray *images=[[NSMutableArray alloc]init];
        for (int i=1; i<40; i++) {
//            [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"dropdown%zd",i]]];
        }
        _imageView.animationImages=images;
        [self addSubview:_imageView];
        [_imageView startAnimating];
        
        _label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
        _label.font=[UIFont font12];
        _label.textColor=[UIColor text3];
        _label.text=@"正在加载...";
        [self addSubview:_label];
        [_label sizeToFit];
        _label.topCenter=CGPointMake(self.width/2, _imageView.bottom);
    }
    return self;
}

-(void)setIsLoading:(BOOL)isLoading{
    _isLoading=isLoading;
    if (_isLoading) {
        _imageView.topCenter=CGPointMake(self.width/2, (self.height-AutoFit(120))/2);
        _label.topCenter=CGPointMake(self.width/2, _imageView.bottom);
        [_imageView startAnimating];
    }
    else{
        [_imageView stopAnimating];
    }
}

@end
