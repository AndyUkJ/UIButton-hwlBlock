//
//  HWLEventBlock.m
//  UIButton-hwlBlock
//
//  Created by jipengfei on 2022/1/22.
//

#import "HWLEventTargetWithBlock.h"

@interface HWLEventTargetWithBlock()
@property (nonatomic, copy) void (^eventBlock)(id sender);
@end

@implementation HWLEventTargetWithBlock
+ (instancetype)eventTargetWithBlock:(void(^)(id sender))eventBlock {
    HWLEventTargetWithBlock *eventTarget = [[HWLEventTargetWithBlock alloc] init];
    eventTarget.eventBlock = [eventBlock copy];
    return eventTarget;
}

- (void)dealloc {
    NSLog(@"HWLEventTargetWithBlock dealloc.");
}

- (void)controlEvent:(id)sender {
    @synchronized (self) {
        void (^actionBlock)(id) = [self.eventBlock copy];
        if (actionBlock == nil) return;

        actionBlock(sender);
    }
}

@end
