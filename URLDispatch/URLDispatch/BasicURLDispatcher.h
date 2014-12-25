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
    NSMutableDictionary* _delegateFactories;
    NSMutableArray* _history;
    
}

@property (readonly) id<URLDispatchDelegate> RootDelegate;
@property (readonly) id<URLDispatchDelegate> CurrentDelegate;

- (id)init;
- (id)initWithRootDelegate:(id<URLDispatchDelegate>)rootDelegate;
- (void)registerFactory:(id<URLDispatchDelegateFactory>)factory;
- (void)changeRegisterFactory:(id<URLDispatchDelegateFactory>)factory;
- (void)unregisterUrl:(NSString*)url;
- (void)unregisterFactory:(id<URLDispatchDelegateFactory>)factory;
- (id<URLDispatchDelegate>)createDispatchDelegateWithUrl:(NSString*)url;
- (id<URLDispatchDelegate>)createDispatchDelegateWithUrl:(NSString*)url dispacher:(id<URLDispatcher>)dispacher;
- (void)dispatchDelegate:(id<URLDispatchDelegate>)delegate withArgs:(NSDictionary*)args;
- (void)gotoUrl:(NSString*)url withArgs:(NSDictionary*)args;
- (NSArray*)dispatchHistory;

@end
