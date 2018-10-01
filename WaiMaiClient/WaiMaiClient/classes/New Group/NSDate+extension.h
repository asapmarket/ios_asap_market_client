//
//  NSDate+extension.h
//  ProjectFramework
//
//  Created by chason on 16/3/2.
//  Copyright © 2016年 Senri. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SECONDFROMMINUTE  60
#define SECONDFROMHOUR  (60*60)
#define SECONDFROMDAY  (60*60*24)
#define SECONDFROMWEEK  (60*60*24*7)
#define SECONDFROMYEAR  (60*60*24*365)

@interface NSDate (extension)
-(NSString *)string;
-(NSString *)stringFromFormatter:(NSString *)formatter;

+(NSDate *)date:(NSString *)dateStr;
+(NSDate *)date:(NSString *)dateStr fromFormatter:(NSString *)formatter;
-(NSDate *)dateAfterDaysFromNow:(NSInteger)days;
-(NSDate *)dateBeforeDaysFromNow:(NSInteger)days;
+(NSDate *)localityDate;
-(NSTimeInterval)timeInterval;
+(NSTimeInterval)timeInterval:(NSString *)dataStr;
-(BOOL)isToday;
@end
