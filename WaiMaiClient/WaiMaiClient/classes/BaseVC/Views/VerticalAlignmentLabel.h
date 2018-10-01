//
//  VerticalAlignmentLabel.h
//  WaiMaiClient
//
//  Created by 王 on 2017/12/26.
//  Copyright © 2017年 王. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;

@interface VerticalAlignmentLabel : UILabel

@property (nonatomic, assign) VerticalAlignment verticalAlignment;
@property (assign, nonatomic) CGFloat topMargin; //仅 VerticalAlignmentTop 模式下有效

- (void)setLineSpaceWithSpac:(CGFloat)space text:(NSString *)text;

@end
