//
//  SSRefreshGifHeader.m
//  SSWG
//
//  Created by DaLei on 2017/10/13.
//  Copyright © 2017年 ThreeSquirrels. All rights reserved.
//

#import "RefreshHeader.h"

@implementation RefreshHeader

#pragma mark 基本设置
- (void)prepare {
    [super prepare];
    self.backgroundColor=[UIColor clearColor];
    //隐藏时间
    self.lastUpdatedTimeLabel.hidden = YES;
    //状态
    self.stateLabel.font=[UIFont font15];
    self.stateLabel.textColor=[UIColor color];
}

@end
