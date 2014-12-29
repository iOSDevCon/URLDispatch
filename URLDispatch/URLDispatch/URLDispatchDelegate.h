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
@property (readonly) id<URLDispatcher> dispatcher;

- (void)dispatchedWith:(URLDispatchContext*)context;
//- (void)backWithContext:(URLDispatchContext*)context;
//- (void)reloadWithContext:(URLDispatchContext*)context;

@end

@protocol URLDispatchDelegateFactory;

@protocol URLDispatcher<NSObject>

@property (readonly) id<URLDispatchDelegate> rootDelegate;
@property (readonly) id<URLDispatchDelegate> currentDelegate;
    
- (void)registerFactory:(id<URLDispatchDelegateFactory>)navigateableFactory;
- (void)changeRegisterFactory:(id<URLDispatchDelegateFactory>)navigateableFactory;

- (void)unregisterName:(NSString*)name;
- (void)unregisterUrl:(NSString*)url;
- (void)unregisterFactory:(id<URLDispatchDelegateFactory>)navigateableFactory;

- (id<URLDispatchDelegate>)createDispatchDelegateWithName:(NSString*)name;
- (id<URLDispatchDelegate>)createDispatchDelegateWithName:(NSString*)name dispacher:(id<URLDispatcher>)dispacher;

- (NSArray*)createDispatchDelegateWithUrl:(NSString*)url;
- (NSArray*)createDispatchDelegateWithUrl:(NSString*)url dispacher:(id<URLDispatcher>)dispacher;


- (void)dispatchDelegate:(id<URLDispatchDelegate>)delegate withArgs:(NSDictionary*)args;

- (void)dispatchUrl:(NSString*)url withArgs:(NSDictionary*)args;
- (void)dispatchName:(NSString*)name withArgs:(NSDictionary*)args;

- (NSArray*)dispatchHistory;

@end

@protocol URLDispatchDelegateFactory<NSObject>

//@property (readonly) NSArray* dispatchUrls;
@property (readonly) NSArray* dispatchMetas;

-(id<URLDispatchDelegate>)createWithDispatcher:(id<URLDispatcher>)dispatcher url:(NSString*)url;
-(id<URLDispatchDelegate>)createWithDispatcher:(id<URLDispatcher>)dispatcher name:(NSString*)name;

@end