

#import "QKCoding.h"
#import <objc/runtime.h>

@implementation QKCoding

//将子类的setValuesForKeysWithDictionary方法换成setDict
+ (void)load{
    [super load];
    class_addMethod([self class], @selector(encodeWithCoder:), (IMP)encodeWithCoder, "V@:@");
    class_addMethod([self class], @selector(initWithCoder:), (IMP)initWithCoder, "@@:@");
}


id initWithCoder(id self, SEL _cmd,NSCoder *aDecoder){
        // 解档
        unsigned int propertyCount = 0;
        objc_property_t *propertys = class_copyPropertyList([self class], &propertyCount);
        for (int i = 0; i < propertyCount; i ++) {
            objc_property_t property = propertys[i];
            const char * propertyName = property_getName(property);
            NSString *name = [NSString stringWithUTF8String:propertyName];
            [self setValue:[aDecoder decodeObjectForKey:name] forKey:name];
        }
    return self;

}

void encodeWithCoder(id self, SEL _cmd,NSCoder *aCoder){
    //归档
    unsigned int propertyCount = 0;
    objc_property_t *propertys = class_copyPropertyList([self class], &propertyCount);
    for (int i = 0; i < propertyCount; i ++) {
        objc_property_t property = propertys[i];
        const char * propertyName = property_getName(property);
        NSString *name = [NSString stringWithUTF8String:propertyName];
        [aCoder encodeObject:[self valueForKeyPath: name] forKey: name];
    }
}

- (BOOL)saveModelWithPath:(NSString *)pathName{
    NSString *stringPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex: 0];
    stringPath = [stringPath stringByAppendingPathComponent:pathName];
    return [NSKeyedArchiver archiveRootObject:self toFile:stringPath];
}

+ (id)getModelWithPath:(NSString *)pathName{
    NSString *stringPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex: 0];
    stringPath = [stringPath stringByAppendingPathComponent:pathName];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:stringPath];
}

+ (void)saveModelArrWithArr:(NSArray *)arr WithPath:(NSString *)pathName{
    for (int i = 0; i < arr.count; i++) {
        QKCoding *model = arr[i];
        [model saveModelWithPath:[NSString stringWithFormat:@"arrCeShi_%d",i]];
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:arr.count forKey:[NSString stringWithFormat:@"%@_count", pathName]];
    [defaults synchronize];
}

+ (NSArray *)getModelArrWithPath:(NSString *)pathName{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *arrM = [NSMutableArray array];
    for (int i = 0; i < [defaults integerForKey: [NSString stringWithFormat:@"%@_count", pathName]]; i++) {
        [arrM addObject:[self getModelWithPath:[NSString stringWithFormat:@"arrCeShi_%d",i]]];
    }
    return arrM.copy;
}
@end
