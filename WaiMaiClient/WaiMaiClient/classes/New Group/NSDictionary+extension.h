//
//  NSDictionary+extension.h
//  ProjectFramework
//
//  Created by chason on 16/3/2.
//  Copyright © 2016年 Senri. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NSDictionary (extension)

-(char)charForKey:(id<NSCopying>)key;
-(char)shortForKey:(id<NSCopying>)key;
-(char)longForKey:(id<NSCopying>)key;
-(char)longLongForKey:(id<NSCopying>)key;
-(NSInteger)integerForKey:(id<NSCopying>)key;
-(BOOL)boolForKey:(id<NSCopying>)key;
-(int)intForKey:(id<NSCopying>)key;
-(float)floatForKey:(id<NSCopying>)key;
-(double)doubleForKey:(id<NSCopying>)key;
-(NSString *)stringForKey:(id<NSCopying>)key;
-(NSArray *)arrayForKey:(id<NSCopying>)key;
-(NSDictionary *)dictionaryForKey:(id<NSCopying>)key;

-(char)charForKey:(id<NSCopying>)key  defaultValue:(char)value;
-(short)shortForKey:(id<NSCopying>)key defaultValue:(short)value;
-(long)longForKey:(id<NSCopying>)key defaultValue:(long)value;
-(long long)longLongForKey:(id<NSCopying>)key defaultValue:(long long)value;
-(NSInteger)integerForKey:(id<NSCopying>)key defaultValue:(NSInteger)value;
-(BOOL)boolForKey:(id<NSCopying>)key defaultValue:(BOOL)value;
-(int)intForKey:(id<NSCopying>)key defaultValue:(int)value;
-(float)floatForKey:(id<NSCopying>)key defaultValue:(float)value;
-(double)doubleForKey:(id<NSCopying>)key defaultValue:(double)value;
-(NSString*)stringForKey:(id<NSCopying>)key defaultValue:(id<NSCopying>)value;
-(NSArray *)arrayForKey:(id<NSCopying>)key defaultValue:(NSArray *)value;
-(NSDictionary *)dictionaryForKey:(id<NSCopying>)key defaultValue:(NSDictionary *)value;

@end


@interface NSMutableDictionary (extension)

-(void)setInteger:(NSInteger)value forKey:(id<NSCopying>)aKey;
-(void)setInt:(int)value forKey:(id<NSCopying>)aKey;
-(void)setDouble:(double)value forKey:(id<NSCopying>)aKey;
-(void)setBool:(BOOL)value forKey:(id<NSCopying>)aKey;
-(void)setLong:(long)value forKey:(id<NSCopying>)aKey;
-(void)setLongLong:(long long)value forKey:(id<NSCopying>)aKey;
-(void)setChar:(unichar)value forKey:(id<NSCopying>)aKey;
-(void)setShort:(short)value forKey:(id<NSCopying>)aKey;

@end
