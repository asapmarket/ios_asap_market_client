//
//  UIImageView+extension.h
//  chason
//
//  Created by chason on 16/8/18.
//  Copyright © 2016年 Senri. All rights reserved.
//



@interface UIImageView (extension)

-(void)imageWithURL:(NSURL *_Nullable)url placeholderImage:(UIImage *_Nullable)placeholderImage;

-(void)imageWithURL:(NSURL *_Nullable)url placeholderImage:(UIImage *_Nullable)placeholderImage completed:(void(^_Nullable)(UIImage * _Nullable image,NSURL * _Nullable imageURL))completed;

-(void)imageWithURL:(NSURL *_Nullable)url;

-(void)rectangleImageWithURL:(NSURL *_Nullable)url;

- (void)userHeaderImageWithURL:(NSURL *_Nullable)url;




@end
