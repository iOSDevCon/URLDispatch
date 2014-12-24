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
#import <URLDispatch/URLDispatchException.h>
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

- (id)init
{
    self = [super init];
    _delegateFactories = [[NSMutableDictionary alloc] init];
    _history = [[NSMutableArray alloc] init];
    return self;
}

- (id)initWithRootDelegate:(id<URLDispatchDelegate>)rootDelegate
{
    self = [self init];
    if(self)
    {
        _rootDelegate = rootDelegate;
        _currentDelegate = rootDelegate;
    }
    return self;
}

- (void)checkFactory:(id<URLDispatchDelegateFactory>)factory
{
    if(factory == nil)
        @throw [URLDispatchException exceptionWithReason:@"URLDispatchDelegateFactory should not be nil"];
    
    if (factory.dispatchUrls == nil)
        @throw [URLDispatchException exceptionWithReason:@"URLDispatchDelegateFactory's dispatchUrls property should not be nil"];
    
    if([factory.dispatchUrls count] == 0)
        @throw [URLDispatchException exceptionWithReason:@"URLDispatchDelegateFactory's dispatchUrls should not be empty"];
}

- (void)checkRegisteredUrl:(NSString*)url
{
    if(url == nil || [url length] == 0)
        @throw [URLDispatchException exceptionWithReason:@"The factory's url should not be nil or empty"];
    
    if(![_delegateFactories valueForKey:url])
        @throw [URLDispatchException exceptionWithReason:[NSString stringWithFormat:@"The factory's url %@ was not registered", url]];
}

- (void)registerFactory:(id<URLDispatchDelegateFactory>)factory
{
    [self checkFactory:factory];
    
    for (NSString *url in factory.dispatchUrls)
    {
        //skip registered url, should warn the user for the duplicated url
        if([_delegateFactories valueForKey:url])
            @throw [URLDispatchException exceptionWithReason:[NSString stringWithFormat:@"The factory's url %@ was registered", url]];
        [_delegateFactories setValue:factory forKey:url];
    }
}

- (void)changeRegisterFactory:(id<URLDispatchDelegateFactory>)factory
{
    [self checkFactory:factory];
    
    for (NSString* url in factory.dispatchUrls) {
        [_delegateFactories setValue:factory forKey:url];
    }
}

- (void)unregisterUrl:(NSString*)url
{
    [self checkRegisteredUrl:url];
    
    [_delegateFactories removeObjectForKey:url];
}

- (void)unregisterFactory:(id<URLDispatchDelegateFactory>)factory;
{
    [self checkFactory:factory];
    
    for (NSString* url in factory.dispatchUrls) {
        [self unregisterUrl:url];
    }
}

- (void)gotoUrl:(NSString*)url withArgs:(NSDictionary*)args;
{
    [self checkRegisteredUrl:url];
    
    id<URLDispatchDelegateFactory> factory = [_delegateFactories objectForKey:url];
    id<URLDispatchDelegate> delegate = [factory createWithDispatcher:self url:url];
    
    if (delegate == nil)
        @throw [URLDispatchException exceptionWithReason:[NSString stringWithFormat:@"URLDispatchDelegate of url %@ creation failed!", url]];
    
    URLDispatchContext *ctx = [[URLDispatchContext alloc] initWith:args];
    ctx.PreviousUrl = _currentDelegate.dispatchUrl;
    ctx.CurrentUrl = url;
    
    if (_rootDelegate == nil) {
        _rootDelegate = delegate;
    }
    _currentDelegate = delegate;
    
    [_currentDelegate gotoWithContext:ctx];
    
    [_history addObject:[[URLDispatchHistory alloc] initWithContext:ctx url:url]];
}

- (NSArray*)dispatchHistory
{
    return _history;
}

@end
