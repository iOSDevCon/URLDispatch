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

-(NSArray*)dispatchMetas
{
    URLDispatchMeta *meta1 = [[URLDispatchMeta alloc] initWithUrl:@"/Demo1" name:@"Demo1"];
    URLDispatchMeta *meta2 = [[URLDispatchMeta alloc] initWithUrl:@"/Demo1/Scene1" name:@"Demo1-Scene1"];
    
    
    return @[meta1,meta2];
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

-(id<URLDispatchDelegate>)createWithDispatcher:(id<URLDispatcher>)dispatcher name:(NSString*)name
{
    if([name isEqualToString:@"Demo1"])
    {
        Demo1ViewController* ctrl = [[Demo1ViewController alloc] initWithUrl:@"/Demo1" withDispatcher:dispatcher];
        return ctrl;
    }
    else if([name isEqualToString:@"Demo1-Scene1"])
    {
        Demo1Scene1ViewController* ctrl = [[Demo1Scene1ViewController alloc] initWithUrl:@"/Demo1/Scene1" withDispatcher:dispatcher];
        return ctrl;
    }
    return nil;
}


@end
