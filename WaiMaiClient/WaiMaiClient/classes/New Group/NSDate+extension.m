//
//  NSDate+extension.m
//  ProjectFramework
//
//  Created by chason on 16/3/2.
//  Copyright © 2016年 Senri. All rights reserved.
//

#import "NSDate+extension.h"

@implementation NSDate (extension)

-(NSString *)string{
    return  [self stringFromFormatter:@"yyyy-MM-dd HH:mm:ss"];
}

-(NSString *)stringFromFormatter:(NSString *)formatter{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:formatter];
    return [dateFormatter stringFromDate:self];
}

+(NSDate *)date:(NSString *)dateStr{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter dateFromString:dateStr];
}

+(NSDate *)date:(NSString *)dateStr fromFormatter:(NSString *)formatter{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:formatter];
    return [dateFormatter dateFromString:dateStr];
}

-(NSDate *)dateAfterDaysFromNow:(NSInteger)days{
    NSDate *dateNow=[NSDate date];
    return  [dateNow dateByAddingTimeInterval:(days*SECONDFROMDAY+SECONDFROMHOUR*8)];
}

-(NSDate *)dateBeforeDaysFromNow:(NSInteger)days{
    NSDate *dateNow=[NSDate date];
    return  [dateNow dateByAddingTimeInterval:-(days*SECONDFROMDAY+SECONDFROMHOUR*8)];
}

+(NSDate *)localityDate{
    return [NSDate dateWithTimeIntervalSinceNow:SECONDFROMHOUR*8];
}

-(BOOL)isToday{
    return YES;
}

-(NSTimeInterval)timeInterval{
    return [self timeIntervalSince1970];
}

+(NSTimeInterval)timeInterval:(NSString *)dataStr{
    NSDate *date=[NSDate date:dataStr];
    return [date timeInterval];
}
@end
