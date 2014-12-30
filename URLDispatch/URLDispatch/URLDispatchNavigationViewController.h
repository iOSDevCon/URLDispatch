//
//  URLDispatchNavigationViewController.h
//  URLDispatch
//
//  Created by Robert Qiu on 12/25/14.
//  Copyright (c) 2014 iOSDevCon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <URLDispatch/URLDispatchDelegate.h>

@interface URLDispatchNavigationViewController : UINavigationController<URLDispatcher>
{
    id<URLDispatcher> _innerDispatcher;
}

- (id)initWithInnerDispacher:(id<URLDispatcher>)innerDispatcher;

@property (readonly) id<URLDispatchDelegate> rootDelegate;
@property (readonly) id<URLDispatchDelegate> currentDelegate;
@property (readonly) NSUInteger factoryCount;
@property (readonly) NSUInteger metaCount;

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
