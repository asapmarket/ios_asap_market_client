//
//  RectButton.h
//  PointsLife
//
//  Created by Chason on 16/3/9.
//  Copyright © 2016年 Chason. All rights reserved.
//



@interface UIButtonCustom : UIButton
@property(nonatomic,assign)CGRect imageRect;
@property(nonatomic,assign)CGRect titleRect;

-(void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;
@end
