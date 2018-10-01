//
//  UpStoreListModel.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/13.
//  Copyright © 2017年 王. All rights reserved.
//

#import "UpStoreListModel.h"

@implementation UpStoreListModel

- (NSMutableArray *)foods_list{
    if(!_foods_list){
        _foods_list = [NSMutableArray array];
    }
    return _foods_list;
}

@end
