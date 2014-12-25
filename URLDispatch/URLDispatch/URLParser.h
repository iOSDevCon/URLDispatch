//
//  URLParser.h
//  URLDispatch
//
//  Created by Robert Qiu on 12/25/14.
//  Copyright (c) 2014 iOSDevCon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLParseResult : NSObject
{
    NSString *_path;
    NSDictionary *_args;
}

@property (readonly) NSString* path;
@property (readonly) NSDictionary* arguments;

- (id)initWithPath:(NSString*)path arguments:(NSDictionary*)args;

@end

@interface URLParser : NSObject

+(URLParseResult*)parseUrl:(NSURL*)url;

@end
