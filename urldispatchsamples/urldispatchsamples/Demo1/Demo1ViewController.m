//
//  Demo1ViewController.m
//  urldispatchsamples
//
//  Created by Robert Qiu on 12/26/14.
//  Copyright (c) 2014 iOSDevCon. All rights reserved.
//

#import "Demo1ViewController.h"

@implementation Demo1ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(20, 80, 80, 30);
    [self.view addSubview:btn];
    [btn setTitle:@"/Demo1/Scene1" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(gotoScene1) forControlEvents:UIControlEventTouchUpInside];
}

- (void)gotoScene1
{
    [self.dispatcher dispatchUrl:@"/Demo1/Scene1" withArgs:@{@"title":@"Scene1"}];
}


- (void)dispatchedWith:(URLDispatchContext*)context
{
    self.title = (NSString*)[context argumentOfName:@"title"];
}

@end
