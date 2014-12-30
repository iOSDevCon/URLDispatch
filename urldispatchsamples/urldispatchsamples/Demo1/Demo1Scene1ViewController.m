//
//  Demo1Scene1ViewController.m
//  urldispatchsamples
//
//  Created by Robert Qiu on 12/26/14.
//  Copyright (c) 2014 iOSDevCon. All rights reserved.
//

#import "Demo1Scene1ViewController.h"

@implementation Demo1Scene1ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(20, 80, 100, 30);
    [self.view addSubview:btn];
    [btn setTitle:@"ShowMessage-Url" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(showMessageBoxUrl) forControlEvents:UIControlEventTouchUpInside];
    
    btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(20, 120, 100, 30);
    [self.view addSubview:btn];
    [btn setTitle:@"ShowMessage-Name" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(showMessageBoxName) forControlEvents:UIControlEventTouchUpInside];
}

- (void)dispatchedWith:(URLDispatchContext*)context
{
    self.title = (NSString*)[context argumentOfName:@"title"];
}

- (void)showMessageBoxUrl
{
    
    
    [self.dispatcher dispatchUrl:@"url-msgbox://info" withArgs:@{@"title":@"Message Title",@"message":@"Message Content by Url"}];
}

- (void)showMessageBoxName
{
    [self.dispatcher dispatchName:@"msgbox-info" withArgs:@{@"title":@"Message Title",@"message":@"Message Content by Name"}];
}

@end
