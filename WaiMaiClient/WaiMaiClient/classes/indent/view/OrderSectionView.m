//
//  OrderSectionView.m
//  WaiMaiClient
//
//  Created by 王 on 2017/7/31.
//  Copyright © 2017年 王. All rights reserved.
//

#import "OrderSectionView.h"
#import "StringColor.h"

@implementation OrderSectionView

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor hexStringToColor:@"#CCE8FF"];
        _label = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:15] textColor:ButtonColor textAlignment:NSTextAlignmentLeft];
        _label.frame = CGRectMake(10, 0, SCREEN_WIDTH-20, self.bounds.size.height);
        [self addSubview:_label];
    }
    return self;
}

- (void)setOrder_id:(NSString *)order_id{
    _label.attributedText = [StringColor setTextColorWithString:[NSString stringWithFormat:@"%@%@",NSLocalizedString(kOrderNO, nil),order_id] index:NSLocalizedString(kOrderNO, nil).length textColor:[UIColor hexStringToColor:@"#333333"]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
