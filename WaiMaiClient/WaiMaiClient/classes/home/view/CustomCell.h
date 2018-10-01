//
//  CustomCell.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/13.
//  Copyright © 2017年 王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *customTextView;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
