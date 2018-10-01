//
//  NSObject+extension.m
//  ProjectFramework
//
//  Created by chason on 16/3/2.
//  Copyright © 2016年 Senri. All rights reserved.
//

#import "NSObject+extension.h"
#import <objc/runtime.h>

static void* associatedObjectKey;
@implementation NSObject (extension)

-(void)setAssociatedObject:(id)object  forKey:(NSString *)key{
    @synchronized(self) {
        NSMutableDictionary * associatedObjects=objc_getAssociatedObject(self, &associatedObjectKey);
        if (associatedObjects==nil) {
            associatedObjects=[[NSMutableDictionary alloc]init];
            objc_setAssociatedObject(self, &associatedObjectKey, associatedObjects, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        [associatedObjects setObject:object forKey:key];
    }
}

-(NSDictionary *)associatedObjects{
    @synchronized(self) {
        NSMutableDictionary * associatedObjects=objc_getAssociatedObject(self, &associatedObjectKey);
        if (associatedObjects==nil) {
            return nil;
        }
        return associatedObjects;
    }
}

-(id)associatedObjectForKey:(NSString *)key{
    return  [self.associatedObjects objectForKey:key];
}

-(void)setAssociatedObjects:(NSDictionary *)associatedObjects{
    @synchronized(self) {
        NSMutableDictionary *mDict=[associatedObjects mutableCopy];
        objc_setAssociatedObject(self,&associatedObjectKey, mDict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}


- (void)encodeWithCoder:(NSCoder *)coder{
    
}

-(NSString *)JSONString{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
}

@end
