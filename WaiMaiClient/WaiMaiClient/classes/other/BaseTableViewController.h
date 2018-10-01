//
//  BaseTableViewController.h
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/20.
//  Copyright © 2017年 王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewController : UITableViewController

- (void)errorResponsText:(NSError *)error;

- (void)arlertShowWithText:(NSString *)text;

@end
