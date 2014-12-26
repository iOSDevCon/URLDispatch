//
//  SchemeHandlerFactory.h
//  URLDispatch
//
//  Created by Robert Qiu on 12/26/14.
//  Copyright (c) 2014 iOSDevCon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <URLDispatch/URLDispatchDelegate.h>

@interface SchemeHandlerFactory : NSObject<URLDispatchDelegateFactory>

@property (readonly) NSArray* dispatchUrls;

-(id<URLDispatchDelegate>)createWithDispatcher:(id<URLDispatcher>)dispatcher url:(NSString*)url;


@end
