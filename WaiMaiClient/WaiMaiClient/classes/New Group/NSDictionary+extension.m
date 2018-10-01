//
//  NSDictionary+extension.m
//  ProjectFramework
//
//  Created by chason on 16/3/2.
//  Copyright © 2016年 Senri. All rights reserved.
//

#import "NSDictionary+extension.h"

@implementation NSDictionary (extension)

-(char)charForKey:(id<NSCopying>)key{
    return  [self charForKey:key defaultValue:(char)""];
}

-(char)shortForKey:(id<NSCopying>)key{
    return [self shortForKey:key defaultValue:(short)0];
}

-(char)longForKey:(id<NSCopying>)key{
     return [self longForKey:key defaultValue:(long)0];
}

-(char)longLongForKey:(id<NSCopying>)key{
     return [self longLongForKey:key defaultValue:(long long)0];
}

-(NSInteger)integerForKey:(id<NSCopying>)key{
    return [self integerForKey:key defaultValue:0];
}

-(BOOL)boolForKey:(id<NSCopying>)key{
    return [self boolForKey:key defaultValue:NO];
}

-(int)intForKey:(id<NSCopying>)key{
    return [self intForKey:key defaultValue:0];
}

-(float)floatForKey:(id<NSCopying>)key{
    return [self floatForKey:key defaultValue:0.0f];
}

-(double)doubleForKey:(id<NSCopying>)key{
    return [self doubleForKey:key defaultValue:0.0f];
}

-(NSString<NSCopying>*)stringForKey:(id<NSCopying>)key{
    return [self stringForKey:key defaultValue:@""];
}

-(NSArray *)arrayForKey:(id<NSCopying>)key{
    return [self arrayForKey:key defaultValue:@[]];
}

-(NSDictionary *)dictionaryForKey:(id<NSCopying>)key{
    return [self dictionaryForKey:key defaultValue:@{}];
}

-(char)charForKey:(id<NSCopying>)key  defaultValue:(char)value{
    id object=[self objectForKey:key];
    if ([object isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)object charValue];
    }
    else if ([object isKindOfClass:[NSString class]]){
        return [(NSString *)object characterAtIndex:0];
    }
    else{
        return value;
    }
}

-(short)shortForKey:(id<NSCopying>)key defaultValue:(short)value{
    id object=[self objectForKey:key];
    if ([object isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)object shortValue];
    }
    else if ([object isKindOfClass:[NSString class]]){
        return [(NSString *)object integerValue];
    }
    else{
        return value;
    }
}

-(long)longForKey:(id<NSCopying>)key defaultValue:(long)value{
    id object=[self objectForKey:key];
    if ([object isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)object longValue];
    }
    else if ([object isKindOfClass:[NSString class]]){
        return [(NSString *)object integerValue];
    }
    else{
        return value;
    }
}

-(long long)longLongForKey:(id<NSCopying>)key defaultValue:(long long)value{
    id object=[self objectForKey:key];
    if ([object isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)object longValue];
    }
    else if ([object isKindOfClass:[NSString class]]){
        return [(NSString *)object longLongValue];
    }
    else{
        return value;
    }
}

-(NSInteger)integerForKey:(id<NSCopying>)key defaultValue:(NSInteger)value{
    id object=[self objectForKey:key];
    if ([object isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)object integerValue];
    }
    else if ([object isKindOfClass:[NSString class]]){
        return [(NSString *)object integerValue];
    }
    else{
        return value;
    }
}

-(BOOL)boolForKey:(id<NSCopying>)key defaultValue:(BOOL)value{
    id object=[self objectForKey:key];
    if ([object isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)object boolValue];
    }
    else if ([object isKindOfClass:[NSString class]]){
        return [(NSString *)object boolValue];
    }
    else{
        return value;
    }
}

-(int)intForKey:(id<NSCopying>)key defaultValue:(int)value{
    id object=[self objectForKey:key];
    if ([object isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)object intValue];
    }
    else if ([object isKindOfClass:[NSString class]]){
        return [(NSString *)object intValue];
    }
    else{
        return value;
    }
}

-(float)floatForKey:(id<NSCopying>)key defaultValue:(float)value{
    id object=[self objectForKey:key];
    if ([object isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)object floatValue];
    }
    else if ([object isKindOfClass:[NSString class]]){
        return [(NSString *)object floatValue];
    }
    else{
        return value;
    }
}

-(double)doubleForKey:(id<NSCopying>)key defaultValue:(double)value{
    id object=[self objectForKey:key];
    if ([object isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)object doubleValue];
    }
    else if ([object isKindOfClass:[NSString class]]){
        return [(NSString *)object doubleValue];
    }
    else{
        return value;
    }
}

-(NSString*)stringForKey:(id<NSCopying>)key defaultValue:(id<NSCopying>)value{
    id object=[self objectForKey:key];
    if ([object isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)object stringValue];
    }
    else if ([object isKindOfClass:[NSString class]]){
        return  (NSString<NSCopying>*)object;
    }
    else{
        return [NSString stringWithFormat:@"%@",value];
    }
}

-(NSArray *)arrayForKey:(id<NSCopying>)key defaultValue:(NSArray *)value{
    id object=[self objectForKey:key];
    if ([object isKindOfClass:[NSArray class]]) {
        return (NSArray *)object;
    }
    else{
        return value;
    }
}

-(NSDictionary *)dictionaryForKey:(id<NSCopying>)key defaultValue:(NSDictionary *)value{
    id object=[self objectForKey:key];
    if ([object isKindOfClass:[NSDictionary class]]) {
        return (NSDictionary *)object;
    }
    else{
        return value;
    }
}
@end


@implementation NSMutableDictionary (extension)

-(void)setInteger:(NSInteger)value forKey:(id<NSCopying>)aKey{
    [self setObject:[NSNumber numberWithInteger:value] forKey:aKey];
}

-(void)setInt:(int)value forKey:(id<NSCopying>)aKey{
    [self setObject:[NSNumber numberWithInt:value] forKey:aKey];
}

-(void)setDouble:(double)value forKey:(id<NSCopying>)aKey{
    [self setObject:[NSNumber numberWithDouble:value] forKey:aKey];
}

-(void)setBool:(BOOL)value forKey:(id<NSCopying>)aKey{
    [self setObject:[NSNumber numberWithBool:value] forKey:aKey];
}

-(void)setLong:(long)value forKey:(id<NSCopying>)aKey{
    [self setObject:[NSNumber numberWithLong:value] forKey:aKey];
}

-(void)setLongLong:(long long)value forKey:(id<NSCopying>)aKey{
    [self setObject:[NSNumber numberWithLongLong:value] forKey:aKey];
}

-(void)setChar:(unichar)value forKey:(id<NSCopying>)aKey{
    [self setObject:[NSNumber numberWithChar:value] forKey:aKey];
}

-(void)setShort:(short)value forKey:(id<NSCopying>)aKey{
    [self setObject:[NSNumber numberWithShort:value] forKey:aKey];
}

@end
