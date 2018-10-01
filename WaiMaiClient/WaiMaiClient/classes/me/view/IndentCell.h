//
//  IndentCell.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/23.
//  Copyright © 2017年 王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndentModel.h"

@interface IndentCell : UITableViewCell

@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *distance;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *location;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *indentNo;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UILabel *indentStatus;

@property (nonatomic, strong) UIView *circle1;
@property (nonatomic, strong) UIView *circle2;
@property (nonatomic, strong) IndentModel *item;

@end
