//
//  UIImage+extension.h
//  ProjectFramework
//
//  Created by chason on 16/3/2.
//  Copyright © 2016年 Senri. All rights reserved.
//



@interface UIImage (extension)
+ (UIImage*)imageWithView:(UIView*) view;
+ (UIImage*)captureView:(UIView *)theView frame:(CGRect)frame;
+ (UIImage *)imageWithColor: (UIColor *) color imageSize:(CGSize)imageSize;

+ (UIImage *)generateQRCode:(NSString *)code bounds:(CGRect)bounds;
+(UIImage *)generateBarCode:(NSString *)code bounds:(CGRect)bounds;

+(NSMutableArray *)imageArrayFromGIF:(NSString *)fileName;

+ (UIImage*)imageFromPixelBuffer:(CVPixelBufferRef)pixelBuffer;

@end
