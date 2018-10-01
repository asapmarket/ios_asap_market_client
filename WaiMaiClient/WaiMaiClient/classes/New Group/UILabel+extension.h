//
//  UILabel+extension.h
//  Modao
//
//  Created by chason on 16/3/3.
//  Copyright © 2016年 Senri. All rights reserved.
//



@interface UILabel (extension)
@property (nonatomic,assign) BOOL isCopyable;
@property(nonatomic,strong)NSString *contentText;

-(void)sizeThatFitsWithWidth;
-(void)sizeThatFitsWithHeight;
-(void)sizeThatFitsUnderWidth;
-(void)sizeThatFitsUnderHeight;

- (void)changeFont:(UIFont *)textFont changeText:(NSString *)text;
- (void)changeColor:(UIColor *)textColor changeText:(NSString *)text;
- (void)changeFont:(UIFont *)textFont changeColor:(UIColor *)textColor changeText:(NSString *)text;

@end
