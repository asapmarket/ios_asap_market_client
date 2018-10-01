//
//  SetPersonalViewController.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/21.
//  Copyright © 2017年 王. All rights reserved.
//

#import "SetPersonalViewController.h"
#import "HeadPhotoCell.h"
#import "NickNameCell.h"
#import "SetPwdCell.h"
#import "LanguageCell.h"
#import "WHttpTool.h"
#import "AmendViewController.h"
#import "MeServer.h"
#import "ShopCartManager.h"

@interface SetPersonalViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) UIButton *logOutBtn;

@end

@implementation SetPersonalViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTopBarTitle:NSLocalizedString(kAccountSettings,nil)];
    
    [self updateView];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}


- (void)updateView{
    _logOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _logOutBtn.frame = CGRectMake(0, SCREEN_HEIGHT-IPhoneBottomOffset-45, SCREEN_WIDTH, 45);
    _logOutBtn.backgroundColor = ButtonColor;
    [_logOutBtn setTitle:NSLocalizedString(kOutLogin,nil) forState:UIControlStateNormal];
    [_logOutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_logOutBtn addTarget:self action:@selector(logOutBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_logOutBtn];
    [self.view bringSubviewToFront:_logOutBtn];
}

- (void)logOutBtnClick{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(kConfirmExit,nil) message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *verifyAction = [UIAlertAction actionWithTitle:NSLocalizedString(kVerify,nil) style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
        [UserInfoTool saveLoginAccount:nil];
        [[ShopCartManager shareManager] clearShopCart];
        [LoginManager toLogin];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(kCancel,nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

    }];
    [alert addAction:verifyAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma tableViewDelegate
static NSString *PhotoCell = @"PhotoCell";
static NSString *nickNameCell = @"nickNameCell";
static NSString *ChangePwdCell = @"ChangePwdCell";
static NSString *LanguageCellID = @"LanguageCellID";

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    UserInfo *userInfo = [UserInfoTool loadLoginAccount];
    if (indexPath.row == 0) {
        HeadPhotoCell *photoCell = [tableView dequeueReusableCellWithIdentifier:PhotoCell];
        if (photoCell == nil) {
            photoCell = [[HeadPhotoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PhotoCell];
        }
        photoCell.imageUrl = userInfo.head_image;
        cell = photoCell;
    }else if (indexPath.row == 1){
        NickNameCell *nickCell = [tableView dequeueReusableCellWithIdentifier:nickNameCell];
        if (nickCell == nil) {
            nickCell = [[NickNameCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nickNameCell];
        }
        nickCell.nickName = userInfo.nick_name;

        cell = nickCell;
    }else if (indexPath.row == 2){
        SetPwdCell *pwdCell = [tableView dequeueReusableCellWithIdentifier:ChangePwdCell];
        if (pwdCell == nil) {
            pwdCell = [[SetPwdCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ChangePwdCell];
        }
        cell = pwdCell;
    }else{
        LanguageCell *langCell = [tableView dequeueReusableCellWithIdentifier:LanguageCellID];
        if (langCell == nil){
            langCell = [[LanguageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LanguageCellID];
        }
        cell = langCell;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        UIAlertController *sheetController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:nil
                                                                          preferredStyle:(UIAlertControllerStyleActionSheet)];
        
        
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(kCancel, nil) style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:NSLocalizedString(kTakingPictures, nil)
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 
                                                                 [self openCamera];
                                                                 NSLog(@"cameraAction");
                                                                 
                                                             }];
        UIAlertAction *photoLibraryAction = [UIAlertAction actionWithTitle:NSLocalizedString(kFromPhotoAlbum, nil)
                                                                     style:UIAlertActionStyleDefault
                                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                                       
                                                                       [self openPhotoLibrary];
                                                                       NSLog(@"photoLibraryAction");
                                                                       
                                                                   }];
        
        [sheetController addAction:cancelAction];
        [sheetController addAction:cameraAction];
        [sheetController addAction:photoLibraryAction];
        [self presentViewController:sheetController animated:YES completion:nil];
    }else if (indexPath.row == 2){
        AmendViewController *amendCtrl = [[AmendViewController alloc] init];
        [self.navigationController pushViewController:amendCtrl animated:YES];
        
    }

}

/**
 *  打开相机
 */
- (void)openCamera
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.allowsEditing = YES;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

/**
 *  打开相册
 */
- (void)openPhotoLibrary
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.allowsEditing = YES;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark - 图片选择控制器的代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 1.销毁picker控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 2.去的图片(裁剪后的)
    UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    // 上传图片
    //    self.userPhotoBtn.image = image;
    
    WFormData *formData = [[WFormData alloc] init];
    NSData *data = UIImageJPEGRepresentation(image, 0.0001);
    
    NSLog(@"上传图片的大小：%lu",(unsigned long)UIImageJPEGRepresentation(image, 0.0001).length);
    
    formData.data = data;
    formData.name = @"file";
    formData.filename = @"jpg";
    formData.mimeType = @"image/jpeg";
    
    // 上传图片
    NSArray *ary = [[NSArray alloc] initWithObjects:formData, nil];
    [MeServer meUploadFormDataArray:ary success:^(CodeModel *result) {
        [MBProgressHUD showSuccess:@""];
        
        NSLog(@"result:%@",result.mj_keyValues);
        NSString *headImage = result.fullPath;
        // 上传成功 --> 修改用户头像
        [MeServer upDateHeadImage:result.showImgPath Success:^(CodeModel *result) {
            UserInfo *userInfo = [UserInfoTool loadLoginAccount];
            userInfo.head_image = headImage;
            [UserInfoTool saveLoginAccount:userInfo];
            [self.tableView reloadData];
            [[NSNotificationCenter defaultCenter] postNotificationName:UserInfoChange object:nil];
            
        } failure:^(NSError *error) {
            [self errorResponsText:error];
        }];
        
    } failure:^(NSError *error) {
        [self errorResponsText:error];
    }];}


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
