//
//  UIButton+ImageTitleV.m
//  WaiMaiKuaiDi
//
//  Created by 王 on 2017/7/26.
//  Copyright © 2017年 王. All rights reserved.
//

#import "UIButton+ImageTitleV.h"

@implementation UIButton (ImageTitleV)

- (void)verticalImageAndTitle:(CGFloat)spacing {
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGSize textSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
}

- (void)letfTextRightImage{
    CGSize textSize = [self boundingRectWithSize:self.titleLabel.text Font:self.titleLabel.font Size:CGSizeMake(1000, 22)];;
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, self.bounds.size.width-textSize.width-self.imageView.image.size.width);
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.imageEdgeInsets = UIEdgeInsetsMake((self.height-self.imageView.image.size.height)/2.0, self.bounds.size.width+3-(self.imageView.image.size.width), (self.height-self.imageView.image.size.height)/2.0, self.width-textSize.width-3-self.imageView.image.size.width);
}

- (void)rightImageLeftText{
    CGSize textSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font];

    self.imageEdgeInsets = UIEdgeInsetsMake(0, -CGRectGetMaxX(self.imageView.frame), 0, CGRectGetMaxX(self.imageView.frame));
    self.titleEdgeInsets = UIEdgeInsetsMake(0,-CGRectGetWidth(self.imageView.frame)-10, 0, self.bounds.size.width-(CGRectGetWidth(self.imageView.frame)+textSize.width + 20) );
}

-(CGSize) boundingRectWithSize:(NSString*) txt Font:(UIFont*) font Size:(CGSize) size{
    
    CGSize _size;
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    
    NSDictionary *attribute = @{NSFontAttributeName: font};
    
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine |
    
    NSStringDrawingUsesLineFragmentOrigin |
    
    NSStringDrawingUsesFontLeading;
    
    _size = [txt boundingRectWithSize:size options: options attributes:attribute context:nil].size;
    
#else
    
    _size = [txt sizeWithFont:font constrainedToSize:size];
    
#endif
    
    return _size;
}



@end
