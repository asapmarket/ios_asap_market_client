//
//  ClickLabel.m
//  Chason
//
//  Created by Chason on 16/4/26.
//  Copyright © 2016年 Chason. All rights reserved.
//

#import "ClickLabel.h"

@interface ClickLabel ()
@property(nonatomic,copy)void (^onClick)(void);
@property(nonatomic,strong)UIColor *oldColor;
@property(nonatomic,assign)CGFloat oldAlpha;
@end

@implementation ClickLabel

-(void)onClick:(void (^)(void))onClick{
    self.onClick=onClick;
}

-(void)setOnClick:(void (^)(void))onClick{
    _onClick=onClick;
    if (onClick) {
        self.userInteractionEnabled=YES;
    }
    else{
        self.userInteractionEnabled=NO;
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.onClick) {
        self.onClick();
        self.oldColor=self.textColor;
        self.oldAlpha=self.alpha;
        if (self.clickColor) {
            self.textColor=self.clickColor;
           
        }
        else{
            self.alpha=self.alpha*0.5;
        }
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.onClick) {
        if (self.clickColor) {
            self.textColor=self.oldColor;
        }
        else{
            self.alpha=self.oldAlpha;
        }
        self.onClick();
    }
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.onClick) {
        if (self.clickColor) {
            self.textColor=self.oldColor;
        }
        else{
            self.alpha=self.oldAlpha;
        }
    }
}

@end
