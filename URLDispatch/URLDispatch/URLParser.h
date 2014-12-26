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
    NSString *_scheme;
    NSString *_host;
    NSString *_path;
    NSDictionary *_args;
    NSArray *_argNames;
}

@property (readonly) NSString* scheme;
@property (readonly) NSString* host;
@property (readonly) NSString* path;
@property (readonly) NSDictionary* arguments;
@property (readonly) NSArray* argNames;

- (id)initWithScheme:(NSString*)scheme host:(NSString*)host path:(NSString*)path argNames:(NSArray*)argNames arguments:(NSDictionary*)args;

@end

@interface URLParser : NSObject

+(URLParseResult*)parseUrl:(NSURL*)url;

@end
