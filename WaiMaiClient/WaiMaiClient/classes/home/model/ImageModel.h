//
//  ImageModel.h
//  WaiMaiClient
//
//  Created by 王 on 2017/7/25.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageModel : NSObject

/** imgURl */
@property (nonatomic, strong) NSString *image;

/** 跳转链接 */
@property (nonatomic, strong) NSString *url;

///** 标题 */
//@property (nonatomic, strong) NSString *title;

@end
