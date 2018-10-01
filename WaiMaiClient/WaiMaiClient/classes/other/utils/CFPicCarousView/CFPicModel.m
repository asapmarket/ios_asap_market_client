//
//  CFBaseModel.m
//  LiteratureOnLine
//
//  Created by TheMoon on 16/1/15.
//  Copyright (c) 2016年 CFJ. All rights reserved.
//

#import "CFPicModel.h"

@implementation CFPicModel

- (id)initWithDictionary:(NSDictionary*)dict
{
    if ((self = [super init]))
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
