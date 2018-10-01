//
//  RunAddrView.h
//  WaiMaiClient
//
//  Created by 王 on 2018/3/26.
//  Copyright © 2018年 王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RunAddrView : UIView

@property (nonatomic, strong)UIView *line1;
@property (nonatomic, strong)UIView *line2;
@property (nonatomic, strong)UIImageView *leftIcon;
@property (nonatomic, strong)UIImageView *rightIcon;
@property (nonatomic, strong)UILabel *titleLabel;

@property (nonatomic, copy) void (^addressItemBlock)(NSString *title);


@end
