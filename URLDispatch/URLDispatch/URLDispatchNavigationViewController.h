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

@property (readonly) id<URLDispatchDelegate> rootDelegate;
@property (readonly) id<URLDispatchDelegate> currentDelegate;

- (id)initWithInnerDispacher:(id<URLDispatcher>)innerDispatcher;
- (void)registerFactory:(id<URLDispatchDelegateFactory>)navigateableFactory;
- (void)changeRegisterFactory:(id<URLDispatchDelegateFactory>)navigateableFactory;
- (void)unregisterUrl:(NSString*)url;
- (void)unregisterFactory:(id<URLDispatchDelegateFactory>)navigateableFactory;
- (id<URLDispatchDelegate>)createDispatchDelegateWithUrl:(NSString*)url;
- (id<URLDispatchDelegate>)createDispatchDelegateWithUrl:(NSString*)url dispacher:(id<URLDispatcher>)dispacher;
- (void)dispatchDelegate:(id<URLDispatchDelegate>)delegate withArgs:(NSDictionary*)args;
- (void)dispatchUrl:(NSString*)url withArgs:(NSDictionary*)args;
- (NSArray*)dispatchHistory;

@end
