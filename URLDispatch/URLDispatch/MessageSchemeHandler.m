//
//  MessageSchemeHandler.m
//  URLDispatch
//
//  Created by Robert Qiu on 12/26/14.
//  Copyright (c) 2014 iOSDevCon. All rights reserved.
//

#import <URLDispatch/MessageSchemeHandler.h>

@implementation MessageSchemeHandler

-(NSString*) dispatchUrl
{
    return @"ud-msgbox";
}

-(id<URLDispatcher>)dispatcher
{
    return nil;
}

- (void)dispatchedWith:(URLDispatchContext*)context
{
    
}

@end
