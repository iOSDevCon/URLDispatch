//
//  BaseURLDispatcher.m
//  URLDispatch
//
//  Created by Robert Qiu on 12/24/14.
//  Copyright (c) 2014 iOSDevCon. All rights reserved.
//

#import <URLDispatch/BasicURLDispatcher.h>
#import <URLDispatch/URLDispatchContext.h>
#import <URLDispatch/URLDispatchHistory.h>
#include <assert.h>


@implementation BasicURLDispatcher


- (id<URLDispatchDelegate>)RootDelegate
{
    return _rootDelegate;
}

- (id<URLDispatchDelegate>)CurrentDelegate
{
    return _currentDelegate;
}

- (id)initWithRootDelegate:(id<URLDispatchDelegate>)rootDelegate
{
    self = [super init];
    if(self)
    {
        _rootDelegate = rootDelegate;
        _currentDelegate = rootDelegate;
    }
    return self;
}

- (void)registerFactory:(id<URLDispatchDelegateFactory>)factory
{
    //these assert should be modified exception
    assert(factory != nil);
    assert(factory.dispatchUrls != nil);
    assert([factory.dispatchUrls count] > 0);
   
    for (NSString *url in factory.dispatchUrls)
    {
        //skip registered url, should warn the user for the duplicated url
        if([_navigatables valueForKey:url])
            continue;
        [_navigatables setValue:factory forKey:url];
    }
}

- (void)changeRegisterFactory:(id<URLDispatchDelegateFactory>)factory
{
    //these assert should be modified exception
    assert(factory != nil);
    assert(factory.dispatchUrls != nil);
    assert([factory.dispatchUrls count] > 0);
    
    for (NSString* url in factory.dispatchUrls) {
        [_navigatables setValue:factory forKey:url];
    }
}

- (void)unregisterUrl:(NSString*)url
{
    //these assert should be modified exception
    assert(url != nil);
    assert([_navigatables valueForKey:url]);
    
    [_navigatables removeObjectForKey:url];
}

- (void)unregisterFactory:(id<URLDispatchDelegateFactory>)factory;
{
    //these assert should be modified exception
    assert(factory != nil);
    
    assert(factory.dispatchUrls != nil);
    assert([factory.dispatchUrls count] > 0);
    
    for (NSString* url in factory.dispatchUrls) {
        [self unregisterUrl:url];
    }
}

- (void)gotoUrl:(NSString*)url withArgs:(NSDictionary*)args;
{
    //these assert should be modified exception
    assert([_navigatables valueForKey:url]);
    id<URLDispatchDelegateFactory> factory = [_navigatables objectForKey:url];
    id<URLDispatchDelegate> delegate = [factory createWithDispatcher:self url:url];
    URLDispatchContext *ctx = [[URLDispatchContext alloc] initWith:args];
    ctx.PreviousUrl = _currentDelegate.dispatchUrl;
    ctx.CurrentUrl = url;
    [delegate gotoWithContext:ctx];
    [_history addObject:[[URLDispatchHistory alloc] initWithContext:ctx url:url]];
}

@end
