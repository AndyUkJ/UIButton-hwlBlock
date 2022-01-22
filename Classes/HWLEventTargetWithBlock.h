//
//  HWLEventBlock.h
//  UIButton-hwlBlock
//
//  Created by jipengfei on 2022/1/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HWLEventTargetWithBlock : NSObject
+ (instancetype)eventTargetWithBlock:(void(^)(id sender))eventBlock;
- (void)controlEvent:(id)sender;
@end

NS_ASSUME_NONNULL_END
