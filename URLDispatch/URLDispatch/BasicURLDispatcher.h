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
#import <URLDispatch/URLDispatchMeta.h>

@interface BasicURLDispatcher : NSObject<URLDispatcher>
{
    id<URLDispatchDelegate> _rootDelegate;
    id<URLDispatchDelegate> _currentDelegate;
    
    //use URLDispatchMeta name to map the delegatefactory.
    NSMutableDictionary* _delegateFactories;
    NSMutableArray* _delegateFactoryArray;
    
    URLDispatchMetaCollection *_dispatchMetas;

    NSMutableArray* _dispatchHistory;
}

@property (readonly) id<URLDispatchDelegate> rootDelegate;
@property (readonly) id<URLDispatchDelegate> currentDelegate;
@property (readonly) NSUInteger factoryCount;
@property (readonly) NSUInteger metaCount;

- (id)init;
- (id)initWithRootDelegate:(id<URLDispatchDelegate>)rootDelegate;
- (void)registerFactory:(id<URLDispatchDelegateFactory>)factory;
- (void)changeRegisterFactory:(id<URLDispatchDelegateFactory>)factory;

- (void)unregisterName:(NSString*)name;
- (void)unregisterUrl:(NSString*)url;
- (void)unregisterFactory:(id<URLDispatchDelegateFactory>)factory;

- (id<URLDispatchDelegate>)createDispatchDelegateWithName:(NSString*)name;
- (id<URLDispatchDelegate>)createDispatchDelegateWithName:(NSString*)name dispacher:(id<URLDispatcher>)dispacher;

- (NSArray*)createDispatchDelegateWithUrl:(NSString*)url;
- (NSArray*)createDispatchDelegateWithUrl:(NSString*)url dispacher:(id<URLDispatcher>)dispacher;

- (void)dispatchDelegate:(id<URLDispatchDelegate>)delegate withArgs:(NSDictionary*)args;

- (void)dispatchUrl:(NSString*)url withArgs:(NSDictionary*)args;
- (void)dispatchName:(NSString *)name withArgs:(NSDictionary *)args;
- (NSArray*)dispatchHistory;

@end
