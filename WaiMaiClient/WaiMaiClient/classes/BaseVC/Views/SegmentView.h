//
//  SegmentView.h
//  Chason
//
//  Created by Chason on 16/6/14.
//  Copyright © 2016年 Chason. All rights reserved.
//



@interface SegmentView : UIView
@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,strong)UIFont *font;
@property(nonatomic,strong)UIColor *titleColor;
@property(nonatomic,strong)UIColor *selectedTitleColor;
@property(nonatomic,strong)UIColor *selectedBackgroundColor;
@property(nonatomic,assign)BOOL showLine;

@property(nonatomic,copy)void (^onClick)(int index);
@end
