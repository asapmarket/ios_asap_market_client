

#import <Foundation/Foundation.h>
//模型继承这个类，调用下方四个方法就可以实现模型的存取
@interface QKCoding : NSObject

//模型调用这个方法，存模型
- (BOOL)saveModelWithPath:(NSString *)pathName;
//根据path取出模型
+ (id)getModelWithPath:(NSString *)pathName;
//存一个模型数组，此模型数组内模型必须都继承于本类
+ (void)saveModelArrWithArr:(NSArray *)arr WithPath:(NSString *)pathName;
//取出存到本地的模型数组
+ (NSArray *)getModelArrWithPath:(NSString *)pathName;
@end
