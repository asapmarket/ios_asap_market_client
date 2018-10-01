//
//  RunView.h
//  WaiMaiClient
//
//  Created by 王 on 2018/3/14.
//  Copyright © 2018年 王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RunView : UITableViewCell

@property (nonatomic, copy) void (^runViewDidTouchBlock)(RunView *runView);

@end
