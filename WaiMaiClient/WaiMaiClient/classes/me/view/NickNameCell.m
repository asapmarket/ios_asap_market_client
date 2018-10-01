//
//  NickNameCell.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/21.
//  Copyright © 2017年 王. All rights reserved.
//

#import "NickNameCell.h"
#import "MeServer.h"

@interface NickNameCell ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *nickNameTextField;
@property (nonatomic, strong) UIView *line;

@end

@implementation NickNameCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor hexStringToColor:@"#333333"];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.text= NSLocalizedString(kNickName,nil);
        [self addSubview:_titleLabel];
        
        _nickNameTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        _nickNameTextField.delegate = self;
        _nickNameTextField.font = [UIFont systemFontOfSize:15.0f];
        _nickNameTextField.textAlignment = NSTextAlignmentLeft;
        _nickNameTextField.textColor = [UIColor hexStringToColor:@"#999999"];
        _nickNameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _nickNameTextField.returnKeyType =UIReturnKeyDone;
        [self addSubview:_nickNameTextField];
        
        _line = [[UIView alloc] initWithFrame:CGRectZero];
        _line.backgroundColor = [UIColor hexStringToColor:@"#f5f5f5"];
        [self addSubview:_line];
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    _titleLabel.frame = CGRectMake(TableBorder, CellBorder, 80, 35);
    
    _nickNameTextField.frame = CGRectMake(110, CellBorder, SCREEN_WIDTH-130, 35);
    
    _line.frame = CGRectMake(TableBorder, self.bounds.size.height-1, SCREEN_WIDTH-20, 1);

}

- (void)setNickName:(NSString *)nickName{
    _nickName = nickName;
    _nickNameTextField.text = nickName;
}


//UITextField的代理方法，点击键盘return按钮退出键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    if (textField.text.length > 0) {
        [MeServer upDateNickName:textField.text Success:^(id result) {
            NSLog(@"%@",result);
            UserInfo *userInfo = [UserInfoTool loadLoginAccount];
            userInfo.nick_name = textField.text;
            [UserInfoTool saveLoginAccount:userInfo];
            [[NSNotificationCenter defaultCenter] postNotificationName:UserInfoChange object:nil];
            
        } failure:^(NSError *error) {
            
        }];
    }

    return YES;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
