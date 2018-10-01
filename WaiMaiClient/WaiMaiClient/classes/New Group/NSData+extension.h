//
//  NSData+extension.h
//  ProjectFramework
//
//  Created by chason on 16/3/2.
//  Copyright © 2016年 Senri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (extension)

-(NSString *)md5;

-(NSData *)AES128EncryptWithKey:(NSString *)key;
-(NSData *)AES128DecryptWithKey:(NSString *)key;

+(NSData *)dataWithBase64EncodedString:(NSString *)string;
+(NSString *)base64EncodedStringFrom:(NSData *)data;
@end
