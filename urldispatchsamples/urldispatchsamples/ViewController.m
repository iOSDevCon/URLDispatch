//
//  ViewController.m
//  urldispatchsamples
//
//  Created by Robert Qiu on 12/26/14.
//  Copyright (c) 2014 iOSDevCon. All rights reserved.
//

#import "ViewController.h"
#import "Demo1DispatchDelegateFactory.h"
#import "AppDelegate.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    BasicURLDispatcher* basicDispatcher = [[BasicURLDispatcher alloc] initWithRootDelegate:self];
    _myDispatcher = [[URLDispatchNavigationViewController alloc]
            initWithInnerDispacher:basicDispatcher];
    [_myDispatcher registerFactory:[[Demo1DispatchDelegateFactory alloc] init]];
    UIViewController *ctrl = (UIViewController*)_myDispatcher;
    
    UIWindow* window = [UIApplication sharedApplication].windows[0];
    window.rootViewController = ctrl;
    
    [_myDispatcher dispatchUrl:@"/Demo1" withArgs:@{@"title":@"Demo1 /Demo1"}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
