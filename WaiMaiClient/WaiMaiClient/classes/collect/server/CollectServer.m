//
//  CollectServer.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/10.
//  Copyright © 2017年 王. All rights reserved.
//

#import "CollectServer.h"

@implementation CollectServer

+ (void)getCollectListWithPage:(int)page Success:(void (^)(StoreListModel *result))success failure:(void(^)(NSError *error))failure{
    NSString *url = [UrlsManager getColletListUrlWithPage:[NSString stringWithFormat:@"%d",page]];
    
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        StoreListModel *result = [StoreListModel mj_objectWithKeyValues:json];
        success(result);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getWalletPageSuccess:(void (^)(WalletModel *))success failure:(void (^)(NSError *))failure{
    NSString *url = [UrlsManager getWalletPageURL];
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        WalletModel *result = [WalletModel mj_objectWithKeyValues:json];
        success(result);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)exchangeSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSString *url = [UrlsManager getExchangeURL];
    [WHttpTool getWithURL:url params:nil success:^(id json) {
        success(json);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


@end
