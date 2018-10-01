//
//  SpecClassListModel.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/5.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SpecListModel.h"

@interface SpecClassListModel : QKCoding

@property (nonatomic, strong) NSString *spec_class_id;
@property (nonatomic, strong) NSString *spec_class_name_cn;
@property (nonatomic, strong) NSString *spec_class_name_en;

@property (nonatomic, strong) NSMutableArray *spec_list;

@end
