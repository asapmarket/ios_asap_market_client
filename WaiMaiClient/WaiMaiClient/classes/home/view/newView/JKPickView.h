//
//  JKPickView.h
//  JKOCPickView
//
//  Created by 王冲 on 2018/5/15.
//  Copyright © 2018年 希艾欧科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JKPickView : UIView

@property(nonatomic,strong) void(^back)(NSInteger row);

@property(nonatomic,strong) NSMutableArray *dataArray;
@property(nonatomic,strong) NSString *selectedRow;

+(instancetype)setPickViewDate;

@end
