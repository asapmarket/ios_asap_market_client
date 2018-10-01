//
//  CFBaseModel.h
//  LiteratureOnLine
//
//  Created by TheMoon on 16/1/15.
//  Copyright (c) 2016年 CFJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CFPicModel : NSObject
/**
 *  网络图片链接
 */
@property (nonatomic, copy)NSString *picUrl;

/**
 * 本地图片名称
 */
@property (nonatomic, copy)NSString *picName;

- (id)initWithDictionary:(NSDictionary*)dict;

@end
