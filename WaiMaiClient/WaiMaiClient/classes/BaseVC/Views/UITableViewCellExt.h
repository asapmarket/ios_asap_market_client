//
//  UITableViewCellExt.h
//  ProjectFramework
//
//  Created by Chason on 16/3/2.
//  Copyright © 2016年 Chason. All rights reserved.
//



@interface UITableViewCellExt : UITableViewCell
@property(nonatomic,strong)UILine *separatorLine;

-(void)initView;

+(CGFloat)cellHeight;
@end
