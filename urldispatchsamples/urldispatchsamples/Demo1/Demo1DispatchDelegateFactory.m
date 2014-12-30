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

-(id)init
{
    self = [super init];
    if (self) {
        
        URLDispatchMeta *meta1 = [[URLDispatchMeta alloc] initWithUrl:@"url-vc://Demo1" name:@"Demo1"];
        URLDispatchMeta *meta2 = [[URLDispatchMeta alloc] initWithUrl:@"url-vc://Demo1/Scene1" name:@"Demo1-Scene1"];
        
        metaNameIndex = @{meta1.name:meta1,meta2.name:meta2};
        
        metaUrlIndex = @{meta1.url:meta1,meta2.url:meta2};
    }
    return self;
}

-(NSArray*)dispatchMetas
{
    return metaNameIndex.allValues;
}

-(id<URLDispatchDelegate>)createWithDispatcher:(id<URLDispatcher>)dispatcher url:(NSString*)url
{
    if([url isEqualToString:@"url-vc://Demo1"])
    {
        Demo1ViewController* ctrl = [[Demo1ViewController alloc] initWithUrl:url meta:(URLDispatchMeta*)[metaUrlIndex objectForKey:url] withDispatcher:dispatcher];
        return ctrl;
    }
    else if([url isEqualToString:@"url-vc://Demo1/Scene1"])
    {
        Demo1Scene1ViewController* ctrl = [[Demo1Scene1ViewController alloc] initWithUrl:url meta:(URLDispatchMeta*)[metaUrlIndex objectForKey:url] withDispatcher:dispatcher];
        return ctrl;
    }
    return nil;
}

-(id<URLDispatchDelegate>)createWithDispatcher:(id<URLDispatcher>)dispatcher name:(NSString*)name
{
    URLDispatchMeta* meta = (URLDispatchMeta*)[metaNameIndex objectForKey:name];
    
    if([name isEqualToString:@"Demo1"])
    {
        Demo1ViewController* ctrl = [[Demo1ViewController alloc] initWithUrl:meta.url meta:meta withDispatcher:dispatcher];
        return ctrl;
    }
    else if([name isEqualToString:@"Demo1-Scene1"])
    {
        Demo1Scene1ViewController* ctrl = [[Demo1Scene1ViewController alloc] initWithUrl:meta.url meta:meta withDispatcher:dispatcher];
        return ctrl;
    }
    return nil;
}


@end
