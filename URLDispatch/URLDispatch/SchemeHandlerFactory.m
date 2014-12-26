//
//  SchemeHandlerFactory.m
//  URLDispatch
//
//  Created by Robert Qiu on 12/26/14.
//  Copyright (c) 2014 iOSDevCon. All rights reserved.
//

#import "SchemeHandlerFactory.h"
#import <URLDispatch/MessageSchemeHandler.h>

@implementation SchemeHandlerFactory

-(NSArray*) dispatchUrls
{
    return @[];
}

-(id<URLDispatchDelegate>)createWithDispatcher:(id<URLDispatcher>)dispatcher url:(NSString*)url
{
    if([url containsString:@"ud-msgbox://"])
    {
        return [[MessageSchemeHandler alloc] init];
    }
    return nil;
}


@end
