//
//  URLDispatchMeta.h
//  URLDispatch
//
//  Created by Robert Qiu on 12/26/14.
//  Copyright (c) 2014 iOSDevCon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLDispatchMeta : NSObject
{
    NSString *_scheme;
    NSString *_host;
    NSArray *_paths;
    NSArray *_arguments;
    NSString *_name;
}

+ (id)dispatchMetaWithUrl:(NSString*)url name:(NSString*)name;
- (id)initWithUrl:(NSString*)url name:(NSString*)name;

@property (readonly) NSString* scheme;
@property (readonly) NSString* host;
@property (readonly) NSArray* paths;
@property (readonly) NSArray* arguments;
@property (readonly) bool hasArgument;
@property (readonly) NSString* name;

@end
