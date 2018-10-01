//
//  AddAddressViewController.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/1.
//  Copyright © 2017年 王. All rights reserved.
//

#import "AddAddressViewController.h"
#import "SearchViewButton.h"
#import "MeServer.h"

@interface AddAddressViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) AddressModel *addressModel;
@property (nonatomic, strong) UIButton *recevieBtn;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *man_btn;
@property (weak, nonatomic) IBOutlet UIButton *woman_btn;

@property (weak, nonatomic) IBOutlet UILabel *contactLabel;
@property (weak, nonatomic) IBOutlet UITextField *contactTextField;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;
@property (weak, nonatomic) IBOutlet UITextField *codeTextFiled;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;



@property (nonatomic, assign) BOOL isAddr;

@end

@implementation AddAddressViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        _addressModel = [[AddressModel alloc] init];
        _addressModel.sex = @"1";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTopBarTitle:_navTitle];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createButton];
    [self initView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(codeTextFieldDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:_codeTextFiled];
    
}

- (void)createButton{
    _recevieBtn = [CreateButton initWithFrame:CGRectMake(10, 334, (SCREEN_WIDTH-20), 44) title:NSLocalizedString(kRecieve, nil) target:self action:@selector(recieveButtonClick)];
    [_recevieBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_recevieBtn setBackgroundColor:ButtonColor];
    [self.view addSubview:_recevieBtn];
    if ([_navTitle isEqualToString:NSLocalizedString(kEditAddress, nil)]) {
        _deleteBtn = [CreateButton initWithFrame:CGRectMake(10, 388, (SCREEN_WIDTH-20), 44) title:NSLocalizedString(kDeleteAddress, nil) target:self action:@selector(deleteButtonClick)];
        [self.view addSubview:_deleteBtn];
    }
    
    [_man_btn setTitle:NSLocalizedString(kMan,nil) forState:UIControlStateNormal];
    [_man_btn setImage:[UIImage imageNamed:@"circle_click"] forState:UIControlStateNormal];
    _man_btn.selected = YES;
    _man_btn.imageEdgeInsets = UIEdgeInsetsMake(20, 5, 20, 30);
    _man_btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [_man_btn addTarget: self action:@selector(manButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_woman_btn setTitle:NSLocalizedString(kWoman,nil) forState:UIControlStateNormal];
    [_woman_btn setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
    _woman_btn.selected = NO;
    _woman_btn.imageEdgeInsets = UIEdgeInsetsMake(20, 5, 20, 30);
    _woman_btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [_woman_btn addTarget: self action:@selector(womanButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if (_model == nil) {
        return;
    }
    if ([_model.sex isEqualToString:@"1"]) {
        _man_btn.selected = YES;
        [_man_btn setImage:[UIImage imageNamed:@"circle_click"] forState:UIControlStateNormal];
        _woman_btn.selected = NO;
        [_woman_btn setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
    }else{
        _woman_btn.selected = YES;
        [_woman_btn setImage:[UIImage imageNamed:@"circle_click"] forState:UIControlStateNormal];
        _man_btn.selected = NO;
        [_man_btn setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
    }
    
    
}

- (void)initView{
    
    
    _contactLabel.text = NSLocalizedString(kContact, nil);
    _phoneLabel.text = NSLocalizedString(kPhoneNo, nil);
    _codeLabel.text = NSLocalizedString(kCodeNO, nil);
    _addressLabel.text = NSLocalizedString(kAddAddress, nil);
    
    
    _contactTextField.delegate = self;
    _contactTextField.tag = 1000;
    _phoneTextField.delegate = self;
    _phoneTextField.tag = 1001;
    _codeTextFiled.delegate = self;
    _codeTextFiled.tag = 1002;
    _addressTextField.delegate = self;
    _addressTextField.tag = 1003;
    
    _contactTextField.text = _model.extm_name;
    _phoneTextField.text = _model.extm_phone;
    _codeTextFiled.text = _model.zip_code;
    _addressTextField.text = _model.address;
    
}

- (void)setNavTitle:(NSString *)navTitle{
    _navTitle = navTitle;
    if ([navTitle isEqualToString:NSLocalizedString(kAddAddress, nil)]) {
        _isAddr = NO;
    }
}

- (void)setModel:(AddressModel *)model{
    _model = model;
    _isAddr = YES;
    _addressModel.extm_phone = model.extm_phone;
    _addressModel.zip_code = model.zip_code;
    _addressModel.sex = model.sex;
    _addressModel.extm_id = model.extm_id;
    _addressModel.extm_name = model.extm_name;
    _addressModel.is_default = model.is_default;
    _addressModel.address = model.address;
    
}

- (void)manButtonClick:(UIButton *)btn{
    if (!btn.isSelected) {
        _man_btn.selected = YES;
        [_man_btn setImage:[UIImage imageNamed:@"circle_click"] forState:UIControlStateNormal];
        
        _woman_btn.selected = NO;
        [_woman_btn setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
        
        _addressModel.sex = @"1";
    }
    
}

- (void)womanButtonClick:(UIButton *)btn{
    if (!btn.isSelected) {
        _woman_btn.selected = YES;
        [_woman_btn setImage:[UIImage imageNamed:@"circle_click"] forState:UIControlStateNormal];
        
        _man_btn.selected = NO;
        [_man_btn setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
        _addressModel.sex = @"0";
    }
}

- (void)recieveButtonClick{
    [self.view endEditing:YES];
    
    if (_addressModel.extm_name.length == 0){
        [self arlertShowWithText:NSLocalizedString(kContactsCantEmpty, nil)];
        return;
    }
    
    if (_addressModel.extm_phone.length == 0){
        [self arlertShowWithText:NSLocalizedString(kEnterPhoneNO, nil)];
        return;
    }
    
    if (_addressModel.zip_code.length == 0) {
        [self arlertShowWithText:NSLocalizedString(kZipCodeIsNotDelivery, nil)];
        return;
    }
    
    
    if (_addressModel.address.length == 0){
        [self arlertShowWithText:NSLocalizedString(kLocationCantEmpty, nil)];
        return;
    }
    
    if (_model && _isAddr) {
        [MeServer getEditAddressWithExtmId:_addressModel.extm_id extmName:_addressModel.extm_name sex:_addressModel.sex address:_addressModel.address zipCode:_addressModel.zip_code extm_phone:_addressModel.extm_phone Success:^(AddressModel *result) {
            NSLog(@"%@",result.mj_keyValues);
            [self.navigationController popViewControllerAnimated:YES];
            
        } failure:^(NSError *error) {
            [self errorResponsText:error];
            
        }];
        
    }else{
        [MeServer getIsEffZipCodeWithZipCodel:_codeTextFiled.text Success:^(NSString *result) {
            [MBProgressHUD hideHUD];
            if ([result isEqualToString:@"0"]) {
                [self arlertShowWithText:NSLocalizedString(kZipCodeIsNotDelivery, nil)];
            }else{
                if (_model) {
                    [MeServer getEditAddressWithExtmId:_addressModel.extm_id extmName:_addressModel.extm_name sex:_addressModel.sex address:_addressModel.address zipCode:_addressModel.zip_code extm_phone:_addressModel.extm_phone Success:^(AddressModel *result) {
                        NSLog(@"%@",result.mj_keyValues);
                        [self.navigationController popViewControllerAnimated:YES];
                        
                    } failure:^(NSError *error) {
                        [self errorResponsText:error];
                        
                    }];
                    
                }else{
                    [MeServer getAddAddressWithExtmName:_addressModel.extm_name sex:_addressModel.sex address:_addressModel.address zipCode:_addressModel.zip_code extm_phone:_addressModel.extm_phone Success:^(AddressModel *result) {
                        NSLog(@"%@",result.mj_keyValues);
                        [self.navigationController popViewControllerAnimated:YES];
                        
                    } failure:^(NSError *error) {
                        [self errorResponsText:error];
                    }];
                }
            }
        } failure:^(NSError *error) {
            [self errorResponsText:error];
        }];
    }

    
}

- (void)deleteButtonClick{
    [self.view endEditing:YES];
    
    if (_model) {
        [MeServer getDeleteAddressWithExtmId:_model.extm_id Success:^(id result) {
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSError *error) {
            [self errorResponsText:error];
        }];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
}

- (void)codeTextFieldDidEndEditing:(NSNotification *)nofi{
    _isAddr = NO;
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    if (textField.tag == 1000) {
        _addressModel.extm_name = textField.text;
    }else if (textField.tag == 1001){
        _addressModel.extm_phone = textField.text;
    }else if (textField.tag == 1002){
        _addressModel.zip_code = textField.text;
    }else{
        _addressModel.address = textField.text;
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
