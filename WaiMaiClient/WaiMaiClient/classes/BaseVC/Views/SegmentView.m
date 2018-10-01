//
//  SegmentView.m
//  Chason
//
//  Created by Chason on 16/6/14.
//  Copyright © 2016年 Chason. All rights reserved.
//

#import "SegmentView.h"

@interface ItemButton :UIButton
@property(nonatomic,strong)UILine *line;
@end

@implementation ItemButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _line=[[UILine alloc]initWithFrame:CGRectMake(0, self.height-1, self.width,1)];
        [self addSubview:_line];
        _line.hidden=YES;
    }
    return self;
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    CGSize size=[title boundingRectWithSize:CGSizeMake(self.width, self.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleLabel.font} context:nil].size;
    _line.width=size.width;
    _line.bottomCenter=CGPointMake(self.width/2, self.height-10);
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    _line.hidden= !selected;
}

@end

@interface SegmentView()
@property(nonatomic,assign)int index;
@property(nonatomic,strong)NSMutableArray *buttons;
@end

@implementation SegmentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font=[UIFont font15];
        self.backgroundColor=[UIColor whiteColor];
        self.titleColor=[UIColor text3];;
        self.selectedTitleColor=[UIColor blackColor];;
        self.selectedBackgroundColor=[UIColor clearColor];
    }
    return self;
}

-(void)setTitles:(NSArray *)titles{
    _titles=titles;
    [self initView];
}

-(void)initView{
    _buttons=[[NSMutableArray alloc]init];
    UILine *line=[[UILine alloc]initWithFrame:CGRectMake(0, 0, self.width, 0.5)];
    [self addSubview:line];
    CGFloat width=self.width/_titles.count;
    for (int i=0; i<_titles.count; i++) {
        ItemButton *button=[[ItemButton alloc]initWithFrame:CGRectMake(i*width+1, 0.5, width, self.height-0.5)];
        button.titleLabel.font=self.font;
        [button setTitle:_titles[i] forState:UIControlStateNormal];
        [button setTitleColor:self.titleColor forState:UIControlStateNormal];
        [button setTitleColor:self.selectedTitleColor forState:UIControlStateSelected];
        UIImage *imageNormal=[UIImage imageWithColor:self.backgroundColor imageSize:button.size];
        UIImage *imageSelected=[UIImage imageWithColor:self.selectedBackgroundColor imageSize:button.size];
        [button setBackgroundImage:imageNormal forState:UIControlStateNormal];
        [button setBackgroundImage:imageSelected forState:UIControlStateSelected];
        if (i==0) {
            button.selected=YES;
        }
        [button onClick:^(id sender) {
            if (_index==i){
                return ;
            }
            for (UIButton *obj in _buttons) {
                obj.selected=NO;
            }
            UIButton *btn=(UIButton *)sender;
            btn.selected=YES;
            _index=i;
            if (self.onClick) {
                self.onClick(i);
            }
        }];
        
        if (self.showLine) {
            if (i<_titles.count-1) {
                UILine *line=[[UILine alloc]initWithFrame:CGRectMake(i*width, 0, 0.5, self.height)];
                [button addSubview:line];
                line.rightCenter=CGPointMake(button.width, button.height/2);
            }
        }
        [_buttons addObject:button];
        [self addSubview:button];
    }
}

@end
