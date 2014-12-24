//
//  URLDispatchHistory.m
//  URLDispatch
//
//  Created by Robert Qiu on 12/24/14.
//  Copyright (c) 2014 iOSDevCon. All rights reserved.
//

#import <URLDispatch/URLDispatchHistory.h>

@implementation URLDispatchHistory

-(URLDispatchContext*)context
{
    return _context;
}

-(NSString*)url
{
    return _url;
}

- (id)initWithContext:(URLDispatchContext*)ctx url:(NSString*)url
{
    self = [super init];
    if (!self) {
        return nil;
    }
    _context = ctx;
    _url = url;
    return self;
}

@end
