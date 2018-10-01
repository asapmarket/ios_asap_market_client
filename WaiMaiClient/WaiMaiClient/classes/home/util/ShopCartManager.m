//
//  ShopCartManager.m
//  WaiMaiClient
//
//  Created by 王 on 2017/8/2.
//  Copyright © 2017年 王. All rights reserved.
//

#import "ShopCartManager.h"
#import "SCUtil.h"


@implementation ShopCartManager

+ (ShopCartManager *)shareManager{
    static ShopCartManager *manager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        if (nil == manager) {
            manager = [[ShopCartManager alloc] init];
        }
    });
    return manager;
}

- (void)addObjectWithShopCartModel:(ShopCartModel *)model{
    
    ShopCartBaseModel *baseModel = [self loadShopCartBaseModel];

    if (model) {
        baseModel = [SCUtil updateWithshopCartBaseModel:baseModel shopCartModel:model];
    }
    [baseModel saveModelWithPath:ShopCartResponseFile];
}

- (void)removeObjectWithShopCartModel:(ShopCartModel *)model{
    ShopCartBaseModel *baseModel = [self loadShopCartBaseModel];

    if (model) {
        baseModel = [SCUtil removeWithShopCartBaseModel:baseModel shopCartModel:model];
    }
    [baseModel saveModelWithPath:ShopCartResponseFile];
}

- (ShopCartBaseModel *)loadShopCartBaseModel{
    ShopCartBaseModel *model = [ShopCartBaseModel getModelWithPath:ShopCartResponseFile];
    if (model == nil) {
        return [[ShopCartBaseModel alloc] init];
    }else{
        return model;
    }
}

- (void)clearShopCart{
    ShopCartBaseModel *baseModel = [[ShopCartBaseModel alloc] init];
    [baseModel saveModelWithPath:ShopCartResponseFile];
    [ShopCartManager shareManager].tabBar.badge = nil;
}

- (void)deleteUnWorkStoreWithArray:(NSArray *)array{
    ShopCartBaseModel *model = [ShopCartBaseModel getModelWithPath:ShopCartResponseFile];
    NSMutableArray *storeArray = [NSMutableArray arrayWithArray:model.dataArray];
    for (NSString *sotreId in array) {
        for (ShopCartModel *shopMode in storeArray) {
            if ([shopMode.store_id isEqualToString:sotreId]) {
                [model.dataArray removeObject:shopMode];
            }
        }
    }
    [model saveModelWithPath:ShopCartResponseFile];
}

- (void)setShopCartCount:(int)count{
    if (count<10) {
        [self.tabBar setNumberBadgeMarginTop:15 centerMarginRight:10 titleHorizonalSpace:2 titleVerticalSpace:2];
        self.tabBar.badge = [NSString stringWithFormat:@"%d",count];
    }else if (count < 99){
         [self.tabBar setNumberBadgeMarginTop:15 centerMarginRight:10 titleHorizonalSpace:7 titleVerticalSpace:2];
        self.tabBar.badge = [NSString stringWithFormat:@"%d",count];
    }else{
         [self.tabBar setNumberBadgeMarginTop:15 centerMarginRight:10 titleHorizonalSpace:10 titleVerticalSpace:2];
        self.tabBar.badge = [NSString stringWithFormat:@"99+"];
    }
}

@end
