//
//  NSDictionary+Safe.m
//  当NSDictionary遇到nil
//
//  Created by 宋宏康 on 2018/8/16.
//  Copyright © 2018年 中施科技. All rights reserved.
//

#import "NSDictionary+Safe.h"
#import <objc/runtime.h>

@implementation NSDictionary (Safe)

void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector)
{
    // the method might not exist in the class, but in its superclass
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    // class_addMethod will fail if original method already exists
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    // the method doesn’t exist and we just added one
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


+ (void)load
{
    method_exchangeImplementations(class_getClassMethod([self class], @selector(dictionaryWithObjects:forKeys:count:)), class_getClassMethod([self class], @selector(hk_dictionaryWithObjects:forKeys:count:)));
}

+ (instancetype)hk_dictionaryWithObjects:(id  _Nonnull const [])objects forKeys:(id<NSCopying>  _Nonnull const [])keys count:(NSUInteger)cnt
{
    id safeObjects[cnt];
    id safeKeys[cnt];
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        id key = keys[i];
        id obj = objects[i];
        
        if (!key) {
            continue;
        }
        if (!obj) {
            obj = @"";
        }
        safeKeys[j] = key;
        safeObjects[j] = obj;
        j++;
    }
    return [self hk_dictionaryWithObjects:safeObjects forKeys:safeKeys count:cnt];
}
@end
