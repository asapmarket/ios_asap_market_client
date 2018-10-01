//
//  RunViewController.m
//  WaiMaiClient
//
//  Created by 王 on 2018/3/14.
//  Copyright © 2018年 王. All rights reserved.
//

#import "RunViewController.h"
#import "UIView+extension.h"
#import "UITextViewExt.h"
#import "RunAddrView.h"
#import "ShopAddrViewController.h"
#import "AddressModel.h"
#import "RunOrderParam.h"
#import "HomeServer.h"
#import "RunCreateOrderParam.h"
#import "RunUploadFileParam.h"
#import "WHttpTool.h"
#import "ShopCartManager.h"
#import "SCUtil.h"
#import "RunInstructionView.h"

@interface RunViewController()<UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIAlertViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageV;

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UITextViewExt *textView;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) UIView *imageBgView;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIButton *cameraButton;
@property (nonatomic, assign) int imageCount;
@property (nonatomic, strong) RunAddrView *addessView;
@property (nonatomic, strong) AddressModel *addrModel;
@property (nonatomic, assign) BOOL isAddress;
@property (nonatomic, strong) UIButton *rpButton;
@property (nonatomic, strong) RunCreateOrderParam *param;
@property (nonatomic, strong) RunUploadFileParam *fileParam;
@property (nonatomic, strong) UILabel *pointLabel;

@property (nonatomic, strong) UIButton *getRpButton;

@property (nonatomic, assign) BOOL isAllowOrder;

@property (nonatomic, strong) NSString *instructions;

@property (nonatomic, strong) RunInstructionView *insView;

@property (nonatomic, strong) UILabel *remarkLabel;

@property (nonatomic, strong) UILabel *priceRemarkLabel;


@end

@implementation RunViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self isLogin];
    [[ShopCartManager shareManager] setShopCartCount:[SCUtil getGoodsCount]];;
}

- (void)isLogin{
    UserInfo *userInfo = [UserInfoTool loadLoginAccount];
    if (userInfo == nil) {
        [LoginManager toLogin];
        return;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTopBarTitle:NSLocalizedString(kRunErrands, nil)];
    _imageArray = [NSMutableArray array];
    _imageCount = 0;
    _isAllowOrder = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectAddress:) name:kSelectAddress object:nil];
    [self setUpUI];

    _param = [[RunCreateOrderParam alloc] init];
    RunUserPointParam *userParam = [[RunUserPointParam alloc] init];
    [HomeServer postRunUserPointParam:userParam Success:^(RunUerPointModel *result) {
        if (result.use_point > result.user_point) {
            _pointLabel.text = NSLocalizedString(@"InsufficientMealBalance", nil);
            _isAllowOrder = NO;
        }else{
            _isAllowOrder = YES;
        }
        
        if ([LanguageManager shareManager].language == 1) {
            [_rpButton setTitle:[NSString stringWithFormat:@"每次私人定制订单将消耗%.0f饭点",result.use_point] forState:UIControlStateNormal];
            
        }else{
            [_rpButton setTitle:[NSString stringWithFormat:@"Each Personalized Order will consume %.0f Reward Point.",result.use_point] forState:UIControlStateNormal];
        }
    } failure:^(NSError *error) {
        [self errorResponsText:error];
    }];
    
    [HomeServer postHowToGetRPSuccess:^(NSString *result) {
        _instructions = result;
    } failure:^(NSError *error) {
        [self errorResponsText:error];
    }];
    
}

- (void)selectAddress:(NSNotification *)nofi{
    _addrModel = [nofi object];
    _isAddress = YES;
    _addessView.titleLabel.text = _addrModel.address;
}

- (void)setUpUI{
    CGFloat scrollViewH = SCREEN_HEIGHT;
    if (IS_IPHONE_5 || IS_IPHONE_6) {
        scrollViewH = 667+70;
    }

    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, TopBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-TopBarHeight)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, scrollViewH-TopBarHeight);
    [self.view addSubview:_scrollView];
    
    _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    _imageV.image = [UIImage imageNamed:@"run_banner"];
    [_scrollView addSubview:_imageV];
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 160, SCREEN_WIDTH-20, 425)];
    _bgView.backgroundColor = [UIColor whiteColor];
    [_bgView drawShadow:[UIColor darkGrayColor] offset:CGSizeMake(0.6, 0.6) radius:4];
    _bgView.layer.cornerRadius = 8;
    [_scrollView addSubview:_bgView];
    
    _textView = [[UITextViewExt alloc] initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH-50, 150)];
    _textView.placeholder = NSLocalizedString(@"RunTextViewPlaceholder", nil);
//    _textView.delegate = self;
    [_bgView addSubview:_textView];
    
    _imageBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 180, SCREEN_WIDTH-40, 62)];
    _imageBgView.userInteractionEnabled = YES;
    _imageBgView.backgroundColor = [UIColor whiteColor];
    [_bgView addSubview:_imageBgView];
    
    _descLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:10] textColor:[UIColor hexStringToColor:@"#999999"] textAlignment:NSTextAlignmentLeft];
    _descLabel.frame = CGRectMake(20, 238, SCREEN_WIDTH-70, 30);
    _descLabel.numberOfLines = 2;
    _descLabel.text = NSLocalizedString(@"RunDescLabelText", nil);
    [_bgView addSubview:_descLabel];
    
    _cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cameraButton.frame = CGRectMake(20, 0, 52, 52);
    [_cameraButton setImage:[UIImage imageNamed:@"run_photo"] forState:UIControlStateNormal];
    [_cameraButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [_cameraButton addTarget:self action:@selector(cameraButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_imageBgView addSubview:_cameraButton];
    
    __weak typeof(self) weakSelf = self;
    
    _addessView = [[RunAddrView alloc] initWithFrame:CGRectMake(0, 270, SCREEN_WIDTH-40, 55)];
    _addessView.addressItemBlock = ^(NSString *title) {
        ShopAddrViewController *shopAdr = [[ShopAddrViewController alloc] init];
        shopAdr.isSelAddr = YES;
        [weakSelf.navigationController pushViewController:shopAdr animated:YES];
    };
    [_bgView addSubview:_addessView];
    
    _pointLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:10] textColor:[UIColor hexStringToColor:@"#ff0000"] textAlignment:NSTextAlignmentCenter];
    _pointLabel.frame = CGRectMake(10, 325, SCREEN_WIDTH-40, 20);
    [_bgView addSubview:_pointLabel];
    
    _remarkLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:11] textColor:[UIColor hexStringToColor:@"#999999"] textAlignment:NSTextAlignmentLeft];
    _remarkLabel.frame = CGRectMake(20, 345, SCREEN_WIDTH-70, 30);
    _remarkLabel.numberOfLines = 2;
    if ([LanguageManager shareManager].language == 0){
        _remarkLabel.text = @"Tip: We dont process unpaid order,you can pay for your order after we calculate the price";
    }else{
        _remarkLabel.text = @"提示： 尚未支付的订单不算作有效订单，请等待快递员反馈价格后尽快支付";
    }
    [_bgView addSubview:_remarkLabel];
    
    UIButton *orderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    orderBtn.frame = CGRectMake(0, _bgView.height-44, SCREEN_WIDTH-20, 44);
    orderBtn.backgroundColor = ButtonColor;
    [orderBtn setTitle:NSLocalizedString(@"PlaceTheOrder",nil) forState:UIControlStateNormal];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:orderBtn.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = orderBtn.bounds;
    maskLayer.path = maskPath.CGPath;
    orderBtn.layer.mask = maskLayer;
    [orderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [orderBtn addTarget:self action:@selector(orderButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:orderBtn];
    
    _getRpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _getRpButton.frame = CGRectMake(10, 585, SCREEN_WIDTH-20, 20);
    [_getRpButton setTitle:NSLocalizedString(@"HowToGetRewardPoint", nil) forState:UIControlStateNormal];
    [_getRpButton setTitleColor:ButtonColor forState:UIControlStateNormal];
    _getRpButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [_getRpButton addTarget:self action:@selector(getRpButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_getRpButton];
    
    _rpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rpButton.frame = CGRectMake(10, 605, SCREEN_WIDTH-20, 40);
    [_rpButton setTitleColor:[UIColor hexStringToColor:@"#999999"] forState:UIControlStateNormal];
    _rpButton.titleLabel.font = [UIFont systemFontOfSize:11];
    [_rpButton setImage:[UIImage imageNamed:@"run_!"] forState:UIControlStateNormal];
    [_rpButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [_rpButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
    [_scrollView addSubview:_rpButton];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
    [_scrollView addGestureRecognizer:tap];
    
    
    _priceRemarkLabel = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:11] textColor:[UIColor hexStringToColor:@"#999999"] textAlignment:NSTextAlignmentCenter];
    _priceRemarkLabel.frame = CGRectMake(20, 640, SCREEN_WIDTH-40, 30);
    _priceRemarkLabel.numberOfLines = 2;
    if ([LanguageManager shareManager].language == 0){
        _priceRemarkLabel.text = @"The minimum charge for personalized order will be $20";
    }else{
        _priceRemarkLabel.text = @"私人定制订单最低消费20 usd";
    }
    [_scrollView addSubview:_priceRemarkLabel];
}

- (void)getRpButtonClick{
    if (!_insView) {
        _insView = [[RunInstructionView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [_insView setInstruction:_instructions];
        [self.view.window addSubview:_insView];
    }else{
        _insView.hidden = NO;
        [_insView setInstruction:_instructions];
    }
}

- (void)orderButtonClick{
    if (_textView.text.length == 0) {
        [self arlertShowWithText:NSLocalizedString(@"PlaceTheOrder",nil)];
        return;
    }
//    if (_imageCount == 0) {
//        [self arlertShowWithText:NSLocalizedString(@"UploadPic", nil)];
//        return;
//    }
    if (!_addrModel) {
        [self arlertShowWithText:NSLocalizedString(kAppendAddress, nil)];
        return;
    }
    
    if (!_isAllowOrder) {
        [self arlertShowWithText:NSLocalizedString(@"InsufficientMealBalance", nil)];
        return;
    }
    [MBProgressHUD showMessage:nil];
    _param.order = [[RunOrderContentParam alloc] init];
    _param.order.remark = _textView.text;
    _param.order.extm_id = _addrModel.extm_id;
    if (_imageCount == 0) {
        [MBProgressHUD hideHUD];
        [self.navigationController popViewControllerAnimated:YES];
    }
    [HomeServer postRunOrderParam:_param Success:^(NSString *result) {
        NSLog(@"result = %@",result);
        _fileParam = [[RunUploadFileParam alloc] init];
        _fileParam.table_name = @"tb_order_errands";
        _fileParam.field_order = 1;
        _fileParam.foreign_key_id = result;
        for (int i=0; i<_imageCount; i++) {
            WFormData *formData = [[WFormData alloc] init];
            NSData *data = UIImageJPEGRepresentation(_imageArray[i], 0.0001);
            NSLog(@"上传图片的大小：%lu",(unsigned long)UIImageJPEGRepresentation(_imageArray[i], 0.0001).length);
            _fileParam.sort = i+1;

            formData.data = data;
            formData.name = @"file";
            formData.filename = @"jpg";
            formData.mimeType = @"image/jpeg";
            // 上传图片
            NSArray *ary = [[NSArray alloc] initWithObjects:formData, nil];
            [HomeServer postRunUploadFileParam:_fileParam uploadFormDataArray:ary Success:^(id result) {
                NSLog(@"====%@",result);
                if (i ==_imageCount-1){
                    [MBProgressHUD hideHUD];
                    [self.navigationController popViewControllerAnimated:YES];
                }
                
            } failure:^(NSError *error) {
                [self errorResponsText:error];
                [MBProgressHUD hideHUD];

            }];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [self errorResponsText:error];
    }];
    
}


- (void)onTap{
    [self.view endEditing:YES];
}

- (void)cameraButtonClick{
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
    if (_imageCount == 5) {
        return;
    }
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.allowsEditing = NO;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark - 图片选择控制器的代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
    _imageCount += 1;
    [_imageArray addObject:image];
    [self setUpImageViewUI];
    
}

- (void)setUpImageViewUI{
    for (UIView *subView in _imageBgView.subviews) {
        if (![subView isKindOfClass:[_cameraButton class]]) {
            [subView removeFromSuperview];
        }
    }
    if (_imageArray.count == 0) {
        _cameraButton.frame = CGRectMake(10, 0, 52, 52);
        return;
    }
    
    for (int i=0; i<_imageCount; i++) {
        UIImageView *imageV = [self imageView];
        imageV.frame = CGRectMake(20+((SCREEN_WIDTH-100)/5.0+10)*i, 10, (SCREEN_WIDTH-100)/5.0, (SCREEN_WIDTH-100)/5.0);
        imageV.image = _imageArray[i];
        [_imageBgView addSubview:imageV];
        if (_imageCount < 5) {
            _cameraButton.frame = CGRectMake(20+((SCREEN_WIDTH-100)/5.0+10)*(i+1), 10, (SCREEN_WIDTH-100)/5.0, (SCREEN_WIDTH-100)/5.0);
        }else{
            [_cameraButton removeFromSuperview];
        }
    }
}

- (UIImageView *)imageView{
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageV.userInteractionEnabled = YES;
    [self.view addSubview:imageV];
    return imageV;
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
