//
//  URLDispatchHistory.h
//  URLDispatch
//
//  Created by Robert Qiu on 12/24/14.
//  Copyright (c) 2014 iOSDevCon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <URLDispatch/URLDispatchContext.h>

@interface URLDispatchHistory : NSObject
{
    URLDispatchContext* _context;
    NSString* _url;
}

@property (readonly) URLDispatchContext* Context;
@property (readonly) NSString* url;

- (id)initWithContext:(URLDispatchContext*)ctx url:(NSString*)url;

@end
