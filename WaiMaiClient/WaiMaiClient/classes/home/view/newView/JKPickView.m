//
//  JKPickView.m
//  JKOCPickView
//
//  Created by 王冲 on 2018/5/15.
//  Copyright © 2018年 希艾欧科技有限公司. All rights reserved.
//

#import "JKPickView.h"

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define JKRGBCOLOR(r,g,b,p) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:p]
#define TitleTwoBlackCOLOR [UIColor colorWithRed:(140)/255.0 green:(140)/255.0 blue:(140)/255.0 alpha:1]
#define TitleBtnCOLOR [UIColor colorWithRed:(102)/255.0 green:(102)/255.0 blue:(102)/255.0 alpha:1]
#define jkzhuBlueCOLOR [UIColor colorWithRed:(0)/255.0 green:(150)/255.0 blue:(255)/255.0 alpha:1]
#define fenBlackCOLOR [UIColor colorWithRed:(205)/255.0 green:(205)/255.0 blue:(205)/255.0 alpha:1]
#define TitleBlackCOLOR [UIColor colorWithRed:(51)/255.0 green:(51)/255.0 blue:(51)/255.0 alpha:1]
#define KWindowWidth   [UIScreen mainScreen].bounds.size.width
#define KWindowHeight   [UIScreen mainScreen].bounds.size.height
@interface JKPickView ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIPickerView *pickview;
    UIButton *backView;
    NSArray *array1;
    
    NSInteger selectRow;
}

@end
@implementation JKPickView

+(instancetype)setPickViewDate
{
    return [[self alloc]init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUI];
    }
    
    return self;
}

#pragma mark
-(void)setUI{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    backView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, KWindowWidth, KWindowHeight)];
    backView.backgroundColor = JKRGBCOLOR(0, 0, 0, 0.48);
    //viewPandle.alpha = 0.3;
    [backView addTarget:self action:@selector(clickcancle) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:backView];
    
    self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-240, [UIScreen mainScreen].bounds.size.width, 240);
    self.alpha = 1.0;
    [backView addSubview:self];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, 40)];
    topView.backgroundColor = RGBCOLOR(245,245,245);
    [self addSubview:topView];
    
    UIButton *buttonCancle = [[UIButton alloc]initWithFrame:CGRectMake(16,2, 36, 36)];
    [buttonCancle setTitle:NSLocalizedString(kCancel, nil) forState:UIControlStateNormal];
    buttonCancle.titleLabel.font = [UIFont systemFontOfSize:14];
    [buttonCancle setTitleColor:TitleBtnCOLOR forState:UIControlStateNormal];
    [buttonCancle addTarget:self action:@selector(clickcancle) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview: buttonCancle];
    
    UIButton *buttonSure = [[UIButton alloc]initWithFrame:CGRectMake(KWindowWidth-56,2, 36, 36)];
    buttonSure.titleLabel.font = [UIFont systemFontOfSize:14];
    [buttonSure setTitleColor:jkzhuBlueCOLOR forState:UIControlStateNormal];
    [buttonSure setTitle:NSLocalizedString(kVerify, nil) forState:UIControlStateNormal];
    [buttonSure addTarget:self action:@selector(clicksure) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview: buttonSure];
    
    pickview = [[UIPickerView alloc]initWithFrame:CGRectMake(0,40, self.frame.size.width, self.frame.size.height-40)];
    pickview.backgroundColor = [UIColor whiteColor];
    pickview.delegate = self;
    pickview.dataSource = self;
    [self addSubview:pickview];
}

#pragma mark 取消的的方法
-(void)clickcancle{
    
    [backView removeFromSuperview];
}

#pragma mark  确定的方法
-(void)clicksure{
    
    [backView removeFromSuperview];
    //获取选中的列中的所在的行
    NSInteger row=[pickview selectedRowInComponent:0];
    //然后是获取这个行中的值，就是数组中的值
    NSString *value= [_dataArray objectAtIndex:row];
    
    NSLog(@"选中的值===%@",value);
    
    if (self.back) {
        
        self.back(row);
    }
    
}

//UIPickerViewDataSource中定义的方法，该方法的返回值决定该控件包含的列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 1; // 返回1表明该控件只包含1列
}

//UIPickerViewDataSource中定义的方法，该方法的返回值决定该控件指定列包含多少个列表项
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    // 由于该控件只包含一列，因此无须理会列序号参数component
    // 该方法返回teams.count，表明teams包含多少个元素，该控件就包含多少行
    
    return self.dataArray.count;
}

/*
 *  UIPickerViewDelegate中定义的方法，该方法返回的NSString将作为UIPickerView中指定列和列表项的标题文本
 */
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    // 由于该控件只包含一列，因此无须理会列序号参数component
    // 该方法根据row参数返回teams中的元素，row参数代表列表项的编号，
    // 因此该方法表示第几个列表项，就使用teams中的第几个元素
    
    return self.dataArray[row];
}

-(UIView*)pickerView:(UIPickerView*)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView*)view {
    
    //设置分割线的颜色
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
            singleLine.backgroundColor = fenBlackCOLOR;
        }
    }
    
    UILabel *genderLabel = (UILabel *)view;
    if (!genderLabel)
    {
        genderLabel = [[UILabel alloc] init];
        genderLabel.textAlignment = NSTextAlignmentCenter;
        //[genderLabel setBackgroundColor:[UIColor clearColor]];
    }
    
    genderLabel.text = self.dataArray[row];
    
    NSLog(@"打印selectedRow=%ld",(long)selectRow);
    
    if (row == selectRow){
        
        genderLabel.font = [UIFont boldSystemFontOfSize:20];
        genderLabel.textColor = TitleBlackCOLOR;
        
    } else {
        
        genderLabel.font = [UIFont systemFontOfSize:19];
        genderLabel.textColor = RGBCOLOR(153, 153, 153);
    }
    
    return genderLabel;
}


// 自定义行高
-(CGFloat)pickerView:(UIPickerView*)pickerView rowHeightForComponent:(NSInteger)component {
    return 40;
}
// 自定义列宽
-(CGFloat)pickerView:(UIPickerView*)pickerView widthForComponent:(NSInteger)component {
    
    return KWindowWidth;
}

// 当用户选中UIPickerViewDataSource中指定列和列表项时激发该方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component
{
    selectRow = row;
    [pickview reloadComponent:component];
}


-(NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

#pragma mark 选择的哪一个
-(void)setSelectedRow:(NSString *)selectedRow{
    
    [pickview reloadAllComponents];
    _selectedRow = selectedRow;
    selectRow = [_selectedRow integerValue];
    [pickview selectRow:selectRow inComponent:0 animated:NO];
}



@end


