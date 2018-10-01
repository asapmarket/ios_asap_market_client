//
//  NoDataView.m
//  SSKingdom
//
//  Created by chason on 2017/12/28.
//  Copyright © 2017年 3Songshu. All rights reserved.
//

#import "NoDataView.h"

@interface NoDataView ()
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *label;
@property(nonatomic, strong) UIButton *reloadBtn;
@end

@implementation NoDataView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame=CGRectMake(0, 0, kScreenWidth, kScreenWidth);
        _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 220, 256)];
        [self addSubview:_imageView];
        _label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, _imageView.width, 30)];
        _label.numberOfLines=0;
        _label.textAlignment=NSTextAlignmentCenter;
        _label.font=[UIFont font14];
        _label.textColor=[[UIColor blackColor] colorWithAlphaComponent:0.2];
        _label.topCenter=CGPointMake(self.width/2, _imageView.bottom);
        [self addSubview:_label];
        self.type=NoDataTypeData;
        
        _reloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_reloadBtn setTitle:@"重新加载" forState:UIControlStateNormal];
        _reloadBtn.frame = CGRectMake((self.width-164)/2.0, _label.bottom, 164, 40);
        _reloadBtn.backgroundColor = [UIColor whiteColor];
        _reloadBtn.titleLabel.font = [UIFont font13];
        [_reloadBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_reloadBtn.layer setMasksToBounds:YES];
        [_reloadBtn.layer setCornerRadius:1.0];
        [_reloadBtn.layer setBorderWidth:1.0];
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 229/255.0, 229/255.0, 229/255.0, 1 });
        [_reloadBtn.layer setBorderColor:colorref];
        _reloadBtn.hidden = YES;
        [_reloadBtn addTarget:self action:@selector(reloadButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_reloadBtn];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reloadButtonClick)];
        [_imageView addGestureRecognizer:tap];
        _imageView.userInteractionEnabled=YES;
    }
    return self;
}

-(void)setType:(NoDataType)type{
    _type=type;
    if (type==NoDataTypeNetwork) {
        _imageView.image=[UIImage imageNamed:@"noNetwork"];
        _label.text=@"网络出错，请点击按钮重新加载";
        [_imageView sizeToFit];
        _imageView.topCenter=CGPointMake(kScreenWidth/2, 0);
        _label.width=kScreenWidth-20;
        [_label sizeThatFitsUnderWidth];
        _label.topCenter=CGPointMake(_imageView.center.x, _imageView.bottom+29);
        self.height=_label.bottom;
        _reloadBtn.hidden = NO;
        _reloadBtn.topCenter = CGPointMake(_label.center.x, _label.bottom+20);
        self.height = _reloadBtn.bottom+10;
    }
    else if (type==NoDataTypeData){
        _imageView.image=[UIImage imageNamed:@"MineXiaoJian"];
        _label.text=@"主人暂时没有数据哦!";
        [_imageView sizeToFit];
        _imageView.topCenter=CGPointMake(kScreenWidth/2, 0);
        _label.width=_imageView.width;
        [_label sizeThatFitsUnderWidth];
        _label.topCenter=CGPointMake(_imageView.center.x, _imageView.bottom+10);
        self.height=_label.bottom+10;
    }
    else if(type==NoDataTypeCustom){
        _imageView.image=[UIImage imageNamed:@"nonet"];
        _label.text=self.message;
        [_imageView sizeToFit];
        _imageView.topCenter=CGPointMake(kScreenWidth/2, 0);
        _label.width=_imageView.width;
        [_label sizeThatFitsUnderWidth];
        _label.topCenter=CGPointMake(_imageView.center.x, _imageView.bottom+10);
        self.height=_label.bottom+10;
    }else if (type==NoDataTypeProduction){
        _imageView.image=[UIImage imageNamed:@"nonet"];
        _label.text=self.message;
        [_imageView sizeToFit];
        _imageView.topCenter=CGPointMake(kScreenWidth/2, 0);
        _label.width=_imageView.width;
        [_label sizeThatFitsUnderWidth];
        _label.topCenter=CGPointMake(_imageView.center.x, _imageView.bottom+10);
        self.height=_label.bottom+10;
    }
}

-(void)setMessage:(NSString *)message{
    _message=message;
    _imageView.image=[UIImage imageNamed:@"nonet"];
    _label.text=message;
    [_imageView sizeToFit];
    _imageView.topCenter=CGPointMake(kScreenWidth/2, 0);
    [_label sizeToFit];
    _label.topCenter=CGPointMake(_imageView.center.x, _imageView.bottom+10);
    self.height=_label.bottom+10;
}

- (void)reloadButtonClick{
    NSLog(@"reloadButtonClick");
    if (self.reloadButtonClickBlock){
        self.reloadButtonClickBlock(_reloadBtn);
    }
}
@end
