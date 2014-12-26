//
//  MessageSchemeHandler.h
//  URLDispatch
//
//  Created by Robert Qiu on 12/26/14.
//  Copyright (c) 2014 iOSDevCon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <URLDispatch/URLDispatchDelegate.h>

@interface MessageSchemeHandler : NSObject<URLDispatchDelegate>

@property (readonly) NSString* dispatchUrl;
@property (readonly) id<URLDispatcher> dispatcher;

- (void)dispatchedWith:(URLDispatchContext*)context;

@end
