//
//  URLDispatchTargetViewController.m
//  URLDispatch
//
//  Created by Robert Qiu on 12/26/14.
//  Copyright (c) 2014 iOSDevCon. All rights reserved.
//

#import <URLDispatch/URLDispatchTargetViewController.h>

@implementation URLDispatchTargetViewController

- (id)initWithUrl:(NSString*)url meta:(URLDispatchMeta*)meta withDispatcher:(id<URLDispatcher>)dispatcher
{
    self = [super init];
    if (self) {
        _dispatcher = dispatcher;
        _dispatchUrl = url;
        _dispatchMeta = meta;
    }
    return self;
}

- (URLDispatchMeta*)dispatchMeta
{
    return _dispatchMeta;
}

- (NSString*) dispatchUrl
{
    return _dispatchUrl;
}

- (id<URLDispatcher>)dispatcher
{
    return _dispatcher;
}

- (void)dispatchedWith:(URLDispatchContext*)context
{
}

@end
