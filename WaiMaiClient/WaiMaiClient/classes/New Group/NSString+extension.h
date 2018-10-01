//
//  NSString+extension.h
//  ProjectFramework
//
//  Created by chason on 16/3/2.
//  Copyright © 2016年 Senri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (extension)

-(NSDate *)date;
-(NSDate *)dateFromFormatter:(NSString *)formatter;

-(int)hexValue;

-(NSString *)toUTF8String;
-(NSString *)stringFromUTF8;
-(id)objectFromJSON;
-(NSString *)md5;
+(NSString*)deviceString;

-(BOOL)isEmpty;
-(BOOL)isNumber;
-(BOOL)isPhoneNumber;
-(BOOL)isEmail;
-(BOOL)isPassword;
-(BOOL)isPostcode;
-(BOOL)isIDCardNumber;
-(BOOL)isContrainsEmoji;

-(NSString *)taskStatus;

+(BOOL)isDeviceIPhoneX;

+(NSURL *)fileAbsoluteUrl:(NSString *)filePath;
+(NSString *)filePath:(NSString *)mediaType;

@end
