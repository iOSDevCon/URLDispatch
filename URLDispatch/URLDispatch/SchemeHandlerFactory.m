//
//  SchemeHandlerFactory.m
//  URLDispatch
//
//  Created by Robert Qiu on 12/26/14.
//  Copyright (c) 2014 iOSDevCon. All rights reserved.
//

#import "SchemeHandlerFactory.h"
#import <URLDispatch/MessageSchemeHandler.h>
#import <URLDispatch/URLDispatchMeta.h>

@implementation SchemeHandlerFactory

-(NSArray*) dispatchMetas
{
    return metaNameIndex.allValues;
}

-(id)init
{
    self = [super init];
    if (self) {
        
        URLDispatchMeta *meta = [[URLDispatchMeta alloc] initWithUrl:@"url-msgbox://info" name:@"msgbox-info"];
        
        metaNameIndex = @{meta.name:meta};
        
        metaUrlIndex = @{meta.url:meta};
    }
    return self;
}

-(id<URLDispatchDelegate>)createWithDispatcher:(id<URLDispatcher>)dispatcher url:(NSString*)url
{
    URLDispatchMeta *meta = [metaUrlIndex objectForKey:url];
    
    if([url containsString:@"url-msgbox://info"])
    {
        return [[MessageSchemeHandler alloc] initWithUrl:url meta:meta withDispatcher:dispatcher];
    }
    return nil;
}

-(id<URLDispatchDelegate>)createWithDispatcher:(id<URLDispatcher>)dispatcher name:(NSString*)name
{
    URLDispatchMeta *meta = [metaNameIndex objectForKey:name];
    
    if([name containsString:@"msgbox-info"])
    {
        return [[MessageSchemeHandler alloc] initWithUrl:meta.url meta:meta withDispatcher:dispatcher];
    }
    return nil;
}


@end
