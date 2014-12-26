//
//  URLDispatchTargetViewController.h
//  URLDispatch
//
//  Created by Robert Qiu on 12/26/14.
//  Copyright (c) 2014 iOSDevCon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <URLDispatch/URLDispatchDelegate.h>

@interface URLDispatchTargetViewController : UIViewController<URLDispatchDelegate>
{
    __weak id<URLDispatcher> _dispatcher;
    NSString *_dispatchUrl;
}

- (id)initWithUrl:(NSString*)url withDispatcher:(id<URLDispatcher>)dispatcher;

@property (readonly) NSString* dispatchUrl;
@property (readonly) id<URLDispatcher> dispatcher;

- (void)dispatchedWith:(URLDispatchContext*)context;

//- (void)backWithContext:(URLDispatchContext*)context;
//- (void)reloadWithContext:(URLDispatchContext*)context;

@end
