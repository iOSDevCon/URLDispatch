//
//  Demo1DispatchDelegateFactory.m
//  urldispatchsamples
//
//  Created by Robert Qiu on 12/26/14.
//  Copyright (c) 2014 iOSDevCon. All rights reserved.
//

#import "Demo1DispatchDelegateFactory.h"
#import "Demo1ViewController.h"
#import "Demo1Scene1ViewController.h"

@implementation Demo1DispatchDelegateFactory

-(NSArray*)dispatchUrls
{
    return @[@"/Demo1",@"/Demo1/Scene1"];
}

-(id<URLDispatchDelegate>)createWithDispatcher:(id<URLDispatcher>)dispatcher url:(NSString*)url
{
    if([url isEqualToString:@"/Demo1"])
    {
        Demo1ViewController* ctrl = [[Demo1ViewController alloc] initWithUrl:url withDispatcher:dispatcher];
        return ctrl;
    }
    else if([url isEqualToString:@"/Demo1/Scene1"])
    {
        Demo1Scene1ViewController* ctrl = [[Demo1Scene1ViewController alloc] initWithUrl:url withDispatcher:dispatcher];
        return ctrl;
    }
    return nil;
}


@end
