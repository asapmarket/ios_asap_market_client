//
//  CustomCell.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/13.
//  Copyright © 2017年 王. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"CustomCell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
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
