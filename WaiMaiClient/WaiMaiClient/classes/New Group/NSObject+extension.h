//
//  NSObject+extension.h
//  ProjectFramework
//
//  Created by chason on 16/3/2.
//  Copyright © 2016年 Senri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (extension)

@property (nonatomic, strong) NSDictionary *associatedObjects;

-(void)setAssociatedObject:(id)object  forKey:(NSString *)key;

-(id)associatedObjectForKey:(NSString *)key;
-(NSString *)JSONString;

@end
