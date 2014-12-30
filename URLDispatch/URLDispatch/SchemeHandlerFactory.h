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
{
    NSDictionary *metaNameIndex;
    NSDictionary *metaUrlIndex;
}

@property (readonly) NSArray* dispatchMetas;

-(id)init;
-(id<URLDispatchDelegate>)createWithDispatcher:(id<URLDispatcher>)dispatcher url:(NSString*)url;
-(id<URLDispatchDelegate>)createWithDispatcher:(id<URLDispatcher>)dispatcher name:(NSString *)name;

@end
