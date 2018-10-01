//
//  NSArray+extension.h
//  ProjectFramework
//
//  Created by chason on 16/3/2.
//  Copyright © 2016年 Senri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (extension)

-(id)objectAtIndexSafe:(NSUInteger)index;
-(id)objectAtIndexSafe:(NSUInteger)index  default:(id)defObj;
-(id)firstObjectSafe;

@end

@interface NSMutableArray (extension)
-(void)addObjectSafe:(id)anObject;
-(void)removeObjectSafe:(id)anObject;
-(void)insertObjectAtFirst:(id)anObject;

@end
