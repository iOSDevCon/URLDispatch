//
//  BasicURLDispatcher.h
//  URLDispatch
//
//  Created by Robert Qiu on 12/24/14.
//  Copyright (c) 2014 iOSDevCon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <URLDispatch/URLDispatchDelegate.h>
#import <URLDispatch/URLDispatchContext.h>

@interface BasicURLDispatcher : NSObject<URLDispatcher>
{
    id<URLDispatchDelegate> _rootDelegate;
    id<URLDispatchDelegate> _currentDelegate;
    NSMutableDictionary* _navigatables;
    NSMutableArray* _history;
    
}

@property (readonly) id<URLDispatchDelegate> RootDelegate;
@property (readonly) id<URLDispatchDelegate> CurrentDelegate;

- (id)initWithRootDelegate:(id<URLDispatchDelegate>)rootDelegate;
- (void)registerFactory:(id<URLDispatchDelegateFactory>)factory;
- (void)changeRegisterFactory:(id<URLDispatchDelegateFactory>)factory;
- (void)unregisterUrl:(NSString*)url;
- (void)unregisterFactory:(id<URLDispatchDelegateFactory>)factory;
- (void)gotoUrl:(NSString*)url withArgs:(NSDictionary*)args;

@end
