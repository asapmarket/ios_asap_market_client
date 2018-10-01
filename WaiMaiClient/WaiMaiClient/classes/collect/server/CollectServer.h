//
//  CollectServer.h
//  WaiMaiClient
//
//  Created by 王 on 2017/8/10.
//  Copyright © 2017年 王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WHttpTool.h"
#import "StoreListModel.h"
#import "WalletModel.h"

@interface CollectServer : NSObject

+ (void)getCollectListWithPage:(int)page Success:(void (^)(StoreListModel *result))success failure:(void(^)(NSError *error))failure;

//饭点
+ (void)getWalletPageSuccess:(void (^)(WalletModel *result))success failure:(void(^)(NSError *error))failure;

//税换饭点
+ (void)exchangeSuccess:(void (^)(id result))success failure:(void(^)(NSError *error))failure;
@end
