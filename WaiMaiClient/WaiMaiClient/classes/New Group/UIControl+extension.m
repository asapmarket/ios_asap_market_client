//
//  UIImage+extension.h
//  ProjectFramework
//
//  Created by chason on 16/3/2.
//  Copyright © 2016年 Senri. All rights reserved.
//

#import "UIControl+extension.h"
#import <objc/runtime.h>

@implementation UIControl (extension)

- (void)handleControlEvent:(UIControlEvents)event withBlock:(void(^)(id sender))block {
    NSMutableDictionary * operations = (NSMutableDictionary*)objc_getAssociatedObject(self, &OperationKey);
    if(operations == nil)
    {
        operations = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, &OperationKey, operations, OBJC_ASSOCIATION_RETAIN);
    }
    NSString *name = [UIControl getOperationNameWithEvent:event];
    [operations setObject:block forKey:name];
    [self addTarget:self action:NSSelectorFromString(name) forControlEvents:event];
}

- (void)onClick:(void (^)(id sender))handler {
    [self handleControlEvent:UIControlEventTouchUpInside withBlock:handler];
}

-(void)UIControlEventTouchDown{[self clickEvenWithBlock:UIControlEventTouchDown];}
-(void)UIControlEventTouchDownRepeat{[self clickEvenWithBlock:UIControlEventTouchDownRepeat];}
-(void)UIControlEventTouchDragInside{[self clickEvenWithBlock:UIControlEventTouchDragInside];}
-(void)UIControlEventTouchDragOutside{[self clickEvenWithBlock:UIControlEventTouchDragOutside];}
-(void)UIControlEventTouchDragEnter{[self clickEvenWithBlock:UIControlEventTouchDragEnter];}
-(void)UIControlEventTouchDragExit{[self clickEvenWithBlock:UIControlEventTouchDragExit];}
-(void)UIControlEventTouchUpInside{[self clickEvenWithBlock:UIControlEventTouchUpInside];}
-(void)UIControlEventTouchUpOutside{[self clickEvenWithBlock:UIControlEventTouchUpOutside];}
-(void)UIControlEventTouchCancel{[self clickEvenWithBlock:UIControlEventTouchCancel];}
-(void)UIControlEventValueChanged{[self clickEvenWithBlock:UIControlEventValueChanged];}
-(void)UIControlEventEditingDidBegin{[self clickEvenWithBlock:UIControlEventEditingDidBegin];}
-(void)UIControlEventEditingChanged{[self clickEvenWithBlock:UIControlEventEditingChanged];}
-(void)UIControlEventEditingDidEnd{[self clickEvenWithBlock:UIControlEventEditingDidEnd];}
-(void)UIControlEventEditingDidEndOnExit{[self clickEvenWithBlock:UIControlEventEditingDidEndOnExit];}
-(void)UIControlEventAllTouchEvents{[self clickEvenWithBlock:UIControlEventAllTouchEvents];}
-(void)UIControlEventAllEditingEvents{[self clickEvenWithBlock:UIControlEventAllEditingEvents];}
-(void)UIControlEventApplicationReserved{[self clickEvenWithBlock:UIControlEventApplicationReserved];}
-(void)UIControlEventSystemReserved{[self clickEvenWithBlock:UIControlEventSystemReserved];}
-(void)UIControlEventAllEvents{[self clickEvenWithBlock:UIControlEventAllEvents];}

- (void)clickEvenWithBlock:(UIControlEvents)event {
    NSMutableDictionary *opreations = (NSMutableDictionary*)objc_getAssociatedObject(self, &OperationKey);
    if(opreations == nil) return;
    void(^block)(id sender) = [opreations objectForKey:[UIControl getOperationNameWithEvent:event]];
    if (block) block(self);
}

+ (NSString *)getOperationNameWithEvent:(UIControlEvents)event {
    switch (event) {
        case UIControlEventTouchDown:          return @"UIControlEventTouchDown";
        case UIControlEventTouchDownRepeat:    return @"UIControlEventTouchDownRepeat";
        case UIControlEventTouchDragInside:    return @"UIControlEventTouchDragInside";
        case UIControlEventTouchDragOutside:   return @"UIControlEventTouchDragOutside";
        case UIControlEventTouchDragEnter:     return @"UIControlEventTouchDragEnter";
        case UIControlEventTouchDragExit:      return @"UIControlEventTouchDragExit";
        case UIControlEventTouchUpInside:      return @"UIControlEventTouchUpInside";
        case UIControlEventTouchUpOutside:     return @"UIControlEventTouchUpOutside";
        case UIControlEventTouchCancel:        return @"UIControlEventTouchCancel";
        case UIControlEventValueChanged:       return @"UIControlEventValueChanged";
        case UIControlEventEditingDidBegin:    return @"UIControlEventEditingDidBegin";
        case UIControlEventEditingChanged:     return @"UIControlEventEditingChanged";
        case UIControlEventEditingDidEnd:      return @"UIControlEventEditingDidEnd";
        case UIControlEventEditingDidEndOnExit:return @"UIControlEventEditingDidEndOnExit";
        case UIControlEventAllTouchEvents:     return @"UIControlEventAllTouchEvents";
        case UIControlEventAllEditingEvents:   return @"UIControlEventAllEditingEvents";
        case UIControlEventApplicationReserved:return @"UIControlEventApplicationReserved";
        case UIControlEventSystemReserved:     return @"UIControlEventSystemReserved";
        case UIControlEventAllEvents:          return @"UIControlEventAllEvents";
        default:
            return @"description";
    }
    return @"description";
}

@end
