//
//  NSArray+extension.m
//  ProjectFramework
//
//  Created by chason on 16/3/2.
//  Copyright © 2016年 Senri. All rights reserved.
//

#import "NSArray+extension.h"
@implementation NSArray (extension)

-(id)objectAtIndexSafe:(NSUInteger)index{
    if (self.count<=0) {
        return nil;
    }
    return [self objectAtIndex:index];
}

-(id)objectAtIndexSafe:(NSUInteger)index  default:(id)defObj{
    if (self.count<=index) {
        return defObj;
    }
    id obj=[self objectAtIndexSafe:index];
    if (obj==nil) {
        return defObj;
    }
    return obj;
}

-(id)firstObjectSafe{
    return [self objectAtIndexSafe:0 default:nil];
}

@end

@implementation NSMutableArray (extension)

-(void)addObjectSafe:(id)anObject{
    if (anObject==nil) {
        [self addObject:[NSNull null]];
    }
    else{
        [self addObject:anObject];
    }
}

-(void)removeObjectSafe:(id)anObject{
    if (anObject==nil) {
        [self removeObject:[NSNull null]];
    }
    else{
        [self removeObject:anObject];
    }
}

-(void)insertObjectAtFirst:(id)anObject{
    if (self.count>0) {
        [self insertObject:anObject atIndex:0];
    }
    else{
        [self addObject:anObject];
    }
}

@end
