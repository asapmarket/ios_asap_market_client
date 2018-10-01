//
//  UIImageView+extension.m
//  chason
//
//  Created by chason on 16/8/18.
//  Copyright © 2016年 Senri. All rights reserved.
//

#import "UIImageView+extension.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (extension)

- (void)imageWithURL:(NSURL *)url{
//    CGFloat scale=self.height/self.width;
    UIImage *placeholderImage = [UIImage imageNamed:@"home_banner"];
//    if (scale<=0.224+(0.328-0.224)/2) {
//        placeholderImage=[UIImage imageNamed:@"default380_85"];
//    }
//    else if (scale<(0.625-0.328)/2+0.328){
//        placeholderImage=[UIImage imageNamed:@"default335_110"];
//    }
//    else if (scale<(0.667-0.625)/2+0.625){
//        placeholderImage=[UIImage imageNamed:@"default160_100"];
//    }
//    else if (scale<(1-0.667)/2+0.667){
//        placeholderImage=[UIImage imageNamed:@"default150_100"];
//    }
//    else{
//        placeholderImage=[UIImage imageNamed:@"default200_200"];
//    }
    [self sd_setImageWithURL:url placeholderImage:placeholderImage options:SDWebImageAllowInvalidSSLCertificates];
}

- (void)rectangleImageWithURL:(NSURL *)url{
    UIImage *placeholderImage = [UIImage imageNamed:@"default_rectangle"];
    [self sd_setImageWithURL:url placeholderImage:placeholderImage options:SDWebImageAllowInvalidSSLCertificates];
}

- (void)userHeaderImageWithURL:(NSURL *)url{
    UIImage *placeholderImage = [UIImage imageNamed:@"headImage"];
    [self sd_setImageWithURL:url placeholderImage:placeholderImage options:SDWebImageAllowInvalidSSLCertificates];
}


-(void)imageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage;{
    
    if (placeholderImage==nil) {
        placeholderImage = [UIImage imageNamed:@"default"];
    }
    
    [self sd_setImageWithURL:url placeholderImage:placeholderImage options:SDWebImageAllowInvalidSSLCertificates];
}

-(void)imageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage completed:(void(^)(UIImage * _Nullable image,NSURL * _Nullable imageURL))completed {
    if (placeholderImage==nil) {
        placeholderImage = [UIImage imageNamed:@"default"];

    }
    [self sd_setImageWithURL:url placeholderImage:placeholderImage options:SDWebImageAllowInvalidSSLCertificates completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        completed(image,imageURL);
    }];
}

@end
