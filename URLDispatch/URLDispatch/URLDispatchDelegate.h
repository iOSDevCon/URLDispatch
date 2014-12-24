//
//  URLDispatchDelegate.h
//  URLDispatch
//
//  Created by Robert Qiu on 12/24/14.
//  Copyright (c) 2014 iOSDevCon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <URLDispatch/URLDispatchContext.h>

@protocol URLDispatcher;

@protocol URLDispatchDelegate <NSObject>

@property (readonly) NSString* dispatchUrl;
@property (readonly) id<URLDispatcher> Dispatcher;

- (void)gotoWithContext:(URLDispatchContext*)context;
- (void)BackWithContext:(URLDispatchContext*)context;
- (void)ReloadWithContext:(URLDispatchContext*)context;

@end

@protocol URLDispatchDelegateFactory;

@protocol URLDispatcher<NSObject>

@property (readonly) id<URLDispatchDelegate> RootDelegate;
@property (readonly) id<URLDispatchDelegate> CurrentDelegate;
    
- (void)registerFactory:(id<URLDispatchDelegateFactory>)navigateableFactory;
- (void)changeRegisterFactory:(id<URLDispatchDelegateFactory>)navigateableFactory;
- (void)unregisterUrl:(NSString*)url;
- (void)unregisterFactory:(id<URLDispatchDelegateFactory>)navigateableFactory;
- (void)gotoUrl:(NSString*)url withArgs:(NSDictionary*)args;

@end

@protocol URLDispatchDelegateFactory<NSObject>

@property (readonly) NSArray* dispatchUrls;

-(id<URLDispatchDelegate>)createWithDispatcher:(id<URLDispatcher>)navigator url:(NSString*)url;

@end