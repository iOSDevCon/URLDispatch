//
//  MessageSchemeHandler.m
//  URLDispatch
//
//  Created by Robert Qiu on 12/26/14.
//  Copyright (c) 2014 iOSDevCon. All rights reserved.
//

#import <URLDispatch/MessageSchemeHandler.h>
#import <UIKit/UIKit.h>

@implementation MessageSchemeHandler

-(NSString*) dispatchUrl
{
    return _dispatchUrl;
}

-(id<URLDispatcher>)dispatcher
{
    return _dispatcher;
}

-(URLDispatchMeta*)meta
{
    return _dispatchMeta;
}

- (id)initWithUrl:(NSString*)url meta:(URLDispatchMeta *)meta withDispatcher:(id<URLDispatcher>)dispatcher
{
    self = [super init];
    if (self) {
        _dispatchUrl = url;
        _dispatcher = dispatcher;
        _dispatchMeta = meta;
    }
    return self;
}

- (void)dispatchedWith:(URLDispatchContext*)context
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:(NSString*)[context argumentOfName:@"title"]
                                                         message:(NSString*)[context argumentOfName:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

@end
