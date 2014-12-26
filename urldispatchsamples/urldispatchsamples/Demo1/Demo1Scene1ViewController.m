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
}

- (void)dispatchedWith:(URLDispatchContext*)context
{
    self.title = (NSString*)[context argumentOfName:@"title"];
}

@end
