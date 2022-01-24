//
//  ViewController.m
//  HWLDemoForUIButton+hwlBlock
//
//  Created by jipengfei on 2022/1/22.
//

#import "ViewController.h"

#define hlwCategorySwitch         __has_include(<UIButton-hwlBlock/UIButton+hwlBlock1.h>)

#if hlwCategorySwitch
#import <UIButton-hwlBlock/UIButton+hwlBlock.h>
#else
#import <UIButton-hwlBlock/UIButton+hwlBlockF.h>
#endif

@interface ViewController ()
@property (nonatomic, strong) UIButton *btnClick;
@property (nonatomic, strong) UIButton *btnClear;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self handleEventBlock];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.btnClick.frame = CGRectMake(20.f, 200.f, (self.view.bounds.size.width-2*20.f), 300.f);
    self.btnClear.frame = CGRectMake(20.f, 200.f+300.f+10.f, self.btnClick.frame.size.width, 60.f);
}

#pragma mark -
#pragma mark property method
- (UIButton*)btnClick {
    if (!_btnClick) {
        _btnClick = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnClick.backgroundColor = [UIColor orangeColor];
        _btnClick.layer.cornerRadius = 10.f;
        [self.view addSubview:_btnClick];
    }
    return _btnClick;
}

- (UIButton*)btnClear {
    if (!_btnClear) {
        _btnClear = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnClear.layer.cornerRadius = 10.f;
        [_btnClear setTitle:@"ClearEventBlock" forState:UIControlStateNormal];
        [self.view addSubview:_btnClear];
    }
    return _btnClear;
}

#pragma mark -
#pragma mark internal method
- (void)handleEventBlock {
#if hlwCategorySwitch
    [self.btnClick handleControlEvent:UIControlEventTouchDown withBlock:^(id  _Nonnull sender) {
        NSLog(@"click block UIControlEventTouchDown.");
        self.btnClick.backgroundColor = [UIColor redColor];
    }];

    [self.btnClick handleControlEvent:UIControlEventTouchUpInside withBlock:^(id  _Nonnull sender) {
        NSLog(@"click block UIControlEventTouchUpInside.");
        self.btnClick.backgroundColor = [UIColor orangeColor];
    }];
    
    self.btnClear.tag = 1013;
    self.btnClear.backgroundColor = [UIColor redColor];
    [self.btnClear setTitle:@"ClearEventBlock" forState:UIControlStateNormal];
    
    [self.btnClear handleControlEvent:UIControlEventTouchUpInside withBlock:^(id  _Nonnull sender) {
        if (1013==self.btnClear.tag) {
            [self.btnClick removeHandleBlockByControlEvent:UIControlEventTouchDown];
            [self.btnClick removeHandleBlockByControlEvent:UIControlEventTouchUpInside];
            self.btnClear.backgroundColor = [UIColor greenColor];
            [self.btnClear setTitle:@"RestoreEventBlock" forState:UIControlStateNormal];
            self.btnClear.tag = 1314;
        } else {
            [self handleEventBlock];
        }
    }];
    
#else
    
    [self.btnClick handleControlEventF:UIControlEventTouchDown withBlock:^(id  _Nonnull sender) {
        NSLog(@"click block UIControlEventTouchDown.");
        self.btnClick.backgroundColor = [UIColor redColor];
    }];

    [self.btnClick handleControlEventF:UIControlEventTouchUpInside withBlock:^(id  _Nonnull sender) {
        NSLog(@"click block UIControlEventTouchUpInside.");
        self.btnClick.backgroundColor = [UIColor orangeColor];
    }];
    
    self.btnClear.tag = 1013;
    self.btnClear.backgroundColor = [UIColor redColor];
    [self.btnClear setTitle:@"ClearEventBlock" forState:UIControlStateNormal];
    
    [self.btnClear handleControlEventF:UIControlEventTouchUpInside withBlock:^(id  _Nonnull sender) {
        if (1013==self.btnClear.tag) {
            [self.btnClick removeHandleBlockByControlEventF:UIControlEventTouchDown];
            [self.btnClick removeHandleBlockByControlEventF:UIControlEventTouchUpInside];
            self.btnClear.backgroundColor = [UIColor greenColor];
            [self.btnClear setTitle:@"RestoreEventBlock" forState:UIControlStateNormal];
            self.btnClear.tag = 1314;
        } else {
            [self handleEventBlock];
        }
    }];
    
#endif
}

@end
