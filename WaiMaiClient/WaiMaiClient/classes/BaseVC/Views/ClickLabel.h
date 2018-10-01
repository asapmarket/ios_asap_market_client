//
//  ClickLabel.h
//  Chason
//
//  Created by Chason on 16/4/26.
//  Copyright © 2016年 Chason. All rights reserved.
//



@interface ClickLabel : UILabel
@property(nonatomic,strong)UIColor *clickColor;
-(void)onClick:(void (^)(void))onClick;
@end
