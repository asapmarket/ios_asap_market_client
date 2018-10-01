//
//  CreditCardTextView.h
//  WaiMaiClient
//
//  Created by 王 on 2018/1/12.
//  Copyright © 2018年 王. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CreditCardTextView;

@protocol CreditCardTextViewDelegate <NSObject>

- (void)textFieldReturn:(UITextField *)textField textView:(CreditCardTextView *)textView;

@end

@interface CreditCardTextView : UIView

@property (nonatomic, weak) id<CreditCardTextViewDelegate>delegate;

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSString *descStr;

@end
