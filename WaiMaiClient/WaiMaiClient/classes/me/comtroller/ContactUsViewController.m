//
//  ContactUsViewController.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/10/11.
//  Copyright © 2017年 王. All rights reserved.
//

#import "ContactUsViewController.h"

@interface ContactUsViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;

@end

@implementation ContactUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTopBarTitle:NSLocalizedString(kContactUs,nil)];
    [self setupUI];
}

- (void)setupUI{
    _label1 = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:16] textColor:[UIColor hexStringToColor:@"#333333"] textAlignment:NSTextAlignmentCenter];
    _label1.frame = CGRectMake(10, 120, SCREEN_WIDTH-20, 20);
    _label1.text = NSLocalizedString(kWeChatPublic, nil);
    [self.view addSubview:_label1];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-215)/2.0, 160, 215, 215)];
    _imageView.image = [UIImage imageNamed:@"qr_code"];
    [self.view addSubview:_imageView];
    
    _label2 = [CreateLabel createLabelWithFont:[UIFont systemFontOfSize:16] textColor:[UIColor hexStringToColor:@"#333333"] textAlignment:NSTextAlignmentCenter];
    _label2.frame = CGRectMake(10, 400, SCREEN_WIDTH-20, 40);
    _label2.text = [NSString stringWithFormat:@"%@:customercare@baozou.nyc",NSLocalizedString(kContactEmail, nil)];
    [self.view addSubview:_label2];

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
