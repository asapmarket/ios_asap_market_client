//
//  RunUploadFileParam.h
//  WaiMaiClient
//
//  Created by 王 on 2018/3/26.
//  Copyright © 2018年 王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RunUploadFileParam : NSObject

@property (nonatomic, strong) NSString *table_name;
@property (nonatomic, strong) NSString *foreign_key_id;
@property (nonatomic, assign) int field_order;
@property (nonatomic, assign) int sort;
@end
