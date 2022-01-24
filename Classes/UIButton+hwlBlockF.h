//
//  UIButton+dmkBlock.h
//  HWLBatteryMonitorDemo
//
//  Created by jipengfei on 2022/1/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^DMKControlEventsActionBlock)(id sender);

@interface UIButton(hwlBlockF)
- (void)handleControlEventF:(UIControlEvents)event withBlock:(DMKControlEventsActionBlock)action;
- (void)removeHandleBlockByControlEventF:(UIControlEvents)event;
@end

NS_ASSUME_NONNULL_END
