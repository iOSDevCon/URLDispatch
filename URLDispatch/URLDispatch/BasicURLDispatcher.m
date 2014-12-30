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
#import "SchemeHandlerFactory.h"
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

- (NSUInteger)factoryCount
{
    return [_delegateFactoryArray count];
}

- (NSUInteger)metaCount
{
    return [_dispatchMetas metaCount];
}

- (id)init
{
    self = [super init];
    _delegateFactories = [[NSMutableDictionary alloc] init];
    _delegateFactoryArray = [[NSMutableArray alloc] init];
    _dispatchHistory = [[NSMutableArray alloc] init];
    _dispatchMetas = [[URLDispatchMetaCollection alloc] init];
    return self;
}

- (id)initWithRootDelegate:(id<URLDispatchDelegate>)rootDelegate
{
    self = [self init];
    if(self)
    {
        _rootDelegate = rootDelegate;
        _currentDelegate = rootDelegate;
        
        [self registerFactory:[[SchemeHandlerFactory alloc] init]];
    }
    return self;
}

- (void)checkFactory:(id<URLDispatchDelegateFactory>)factory
{
    if(factory == nil)
        @throw [URLDispatchException exceptionWithReason:@"URLDispatchDelegateFactory should not be nil"];
    
    if (factory.dispatchMetas == nil)
        @throw [URLDispatchException exceptionWithReason:@"URLDispatchDelegateFactory's dispatchMetas property should not be nil"];
    
    if([factory.dispatchMetas count] == 0)
        @throw [URLDispatchException exceptionWithReason:@"URLDispatchDelegateFactory's dispatchMetas should not be empty"];
}

- (void)checkRegisteredName:(NSString*)name
{
    if(name == nil || [name length] == 0)
        @throw [URLDispatchException exceptionWithReason:@"The DispatchMeta name should not be nil or empty"];
    
    if(![_delegateFactories valueForKey:name])
        @throw [URLDispatchException exceptionWithReason:[NSString stringWithFormat:@"The DispatchMeta name %@ was not registered", name]];
}

- (void)registerFactory:(id<URLDispatchDelegateFactory>)factory
{
    [self checkFactory:factory];
    
    for (URLDispatchMeta *dispatchMeta in factory.dispatchMetas)
    {
        //skip registered url, should warn the user for the duplicated url
        if([_delegateFactories valueForKey:dispatchMeta.name])
            @throw [URLDispatchException exceptionWithReason:[NSString stringWithFormat:@"The url dispatch name %@ was registered", dispatchMeta.name]];
        [_delegateFactories setValue:factory forKey:dispatchMeta.name];
        if(![_delegateFactoryArray containsObject:factory])
        {
            [_delegateFactoryArray addObject:factory];
        }
        [_dispatchMetas addDispatchMeta:dispatchMeta];
    }
}

- (void)changeRegisterFactory:(id<URLDispatchDelegateFactory>)factory
{
    [self checkFactory:factory];
    
    for (URLDispatchMeta* dispatchMeta in factory.dispatchMetas) {
    
        [_dispatchMetas removeDispatchMetaName:dispatchMeta.name];
    }
    
    for (URLDispatchMeta* dispatchMeta in factory.dispatchMetas) {
        
        id oldFactory = [_delegateFactories objectForKey:dispatchMeta.name];
        if([_delegateFactoryArray containsObject:oldFactory])
        {
            [_delegateFactoryArray removeObject:oldFactory];;
        }
        
        [_delegateFactories setValue:factory forKey:dispatchMeta.name];
        [_dispatchMetas addDispatchMeta:dispatchMeta];
    }
    [_delegateFactoryArray addObject:factory];
}

- (void)unregisterName:(NSString*)name
{
    [self checkRegisteredName:name];
    
    id<URLDispatchDelegateFactory> oldFactory = [_delegateFactories objectForKey:name];
    [_delegateFactoryArray removeObject:oldFactory];
    
    for (NSString* key in [_delegateFactories allKeys]) {
        if ([_delegateFactories objectForKey:key] == oldFactory) {
            [_delegateFactories removeObjectForKey:key];
        }
    }

    for(URLDispatchMeta *meta in oldFactory.dispatchMetas)
    {
        [_dispatchMetas removeDispatchMeta:meta];
    }
}

- (void)unregisterUrl:(NSString *)url
{
    NSArray* metas = [_dispatchMetas dispatchMetasWithUrl:url];
    
    if (metas == nil) {
        @throw [URLDispatchException exceptionWithReason:[NSString stringWithFormat:@"url %@ is not registered!", url]];
    }
    
    for(URLDispatchMeta *meta in metas)
    {
        [self unregisterName:meta.name];
    }
}

//have an issue that unregister the regsitered url with another factroy with the same url
- (void)unregisterFactory:(id<URLDispatchDelegateFactory>)factory;
{
    [self checkFactory:factory];
    
    for (URLDispatchMeta* meta in factory.dispatchMetas) {
        [self unregisterName:meta.name];
    }
}

- (id<URLDispatchDelegate>)createDispatchDelegateWithName:(NSString *)name
{
    return [self createDispatchDelegateWithName:name dispacher:self];
}

- (id<URLDispatchDelegate>)createDispatchDelegateWithName:(NSString *)name dispacher:(id<URLDispatcher>)dispacher
{
    [self checkRegisteredName:name];
    
    id<URLDispatchDelegateFactory> factory = [_delegateFactories objectForKey:name];
    return [factory createWithDispatcher:dispacher name:name];
}

- (NSArray*)createDispatchDelegateWithUrl:(NSString *)url
{
    return [self createDispatchDelegateWithUrl:url dispacher:self];
}

- (NSArray*)createDispatchDelegateWithUrl:(NSString *)url dispacher:(id<URLDispatcher>)dispacher
{
    NSArray* metas = [_dispatchMetas dispatchMetasWithUrl:url];
    
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    for (URLDispatchMeta *meta in metas) {
        id<URLDispatchDelegateFactory> factory = [_delegateFactories objectForKey:meta.name];
        id<URLDispatchDelegate> delegate = [factory createWithDispatcher:dispacher name:meta.name];
        
        if(delegate == nil)
            @throw [URLDispatchException exceptionWithReason:[NSString stringWithFormat:@"delegate for %@ create failed!", meta.name]];
        
        [results addObject:delegate];
    }
    
    return results;
}

- (void)dispatchDelegate:(id<URLDispatchDelegate>)delegate withArgs:(NSDictionary*)args
{
    if (delegate == nil)
        @throw [URLDispatchException exceptionWithReason:[NSString stringWithFormat:@"URLDispatchDelegate should not be null"]];
    
    NSString *url = delegate.dispatchUrl;
    
    URLDispatchContext *ctx = [[URLDispatchContext alloc] initWith:args];
    ctx.PreviousUrl = _currentDelegate.dispatchUrl;
    ctx.CurrentUrl = url;
    
    if (_rootDelegate == nil) {
        _rootDelegate = delegate;
    }
    _currentDelegate = delegate;
    
    [_currentDelegate dispatchedWith:ctx];
    
    [_dispatchHistory addObject:[[URLDispatchHistory alloc] initWithContext:ctx url:url]];
}

- (void)dispatchUrl:(NSString*)url withArgs:(NSDictionary*)args
{
    NSArray* delegates = [self createDispatchDelegateWithUrl:url];
    
    if (delegates == nil || [delegates count] == 0)
        @throw [URLDispatchException exceptionWithReason:[NSString stringWithFormat:@"URLDispatchDelegate of url %@ creation failed!", url]];
    
    for (id<URLDispatchDelegate> delegate in delegates) {
        [self dispatchDelegate:delegate withArgs:args];
    }
}

- (void)dispatchName:(NSString *)name withArgs:(NSDictionary *)args
{
    id<URLDispatchDelegate> delegate = [self createDispatchDelegateWithName:name];
    
    if (delegate == nil)
        @throw [URLDispatchException exceptionWithReason:[NSString stringWithFormat:@"URLDispatchDelegate of name %@ creation failed!", name]];
    
    [self dispatchDelegate:delegate withArgs:args];
}

- (NSArray*)dispatchHistory
{
    return _dispatchHistory;
}

@end
