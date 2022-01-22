//
//  UIButton+dmkBlock.m
//  HWLBatteryMonitorDemo
//
//  Created by jipengfei on 2022/1/18.
//

#import "UIButton+hwlBlock.h"
#import <objc/runtime.h>
#import "HWLEventTargetWithBlock.h"

@interface UIButton(hwlBlock)
@property (nonatomic, copy) NSDictionary *eventsActionBlockDic;
@end

@implementation UIButton(hwlBlock)

- (void)handleControlEvent:(UIControlEvents)event withBlock:(DMKControlEventsActionBlock)action {
    HWLEventTargetWithBlock *eventTarget = [HWLEventTargetWithBlock eventTargetWithBlock:action];
    [self addTarget:eventTarget action:@selector(controlEvent:) forControlEvents:event];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:self.eventsActionBlockDic?:@{}];
    [dic setValue:eventTarget forKey:[self keyByEvent:event]];
    self.eventsActionBlockDic = [dic copy];
}

- (void)removeHandleBlockByControlEvent:(UIControlEvents)event {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:self.eventsActionBlockDic?:@{}];
    
    id obj = [dic objectForKey:[self keyByEvent:event]];
    if ([obj isKindOfClass:[HWLEventTargetWithBlock class]]) {
        HWLEventTargetWithBlock *eventTarget = (HWLEventTargetWithBlock*)obj;
        [self removeTarget:eventTarget action:@selector(controlEvent:) forControlEvents:event];
        [dic removeObjectForKey:[self keyByEvent:event]];
    }
    
    self.eventsActionBlockDic = [dic copy];
}

#pragma mark -
#pragma mark internal method
- (NSString*)keyByEvent:(UIControlEvents)event {
    return [NSString stringWithFormat:@"%@", @(event)];
}

#pragma mark -
#pragma mark property method
static char eventDicKey;

- (NSDictionary*)eventsActionBlockDic {
    return objc_getAssociatedObject(self, &eventDicKey);
}

- (void)setEventsActionBlockDic:(NSDictionary *)eventsActionBlockDic {
    objc_setAssociatedObject(self, &eventDicKey, eventsActionBlockDic?:@{}, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
