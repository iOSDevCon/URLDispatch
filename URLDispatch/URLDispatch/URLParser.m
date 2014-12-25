//
//  URLParser.m
//  URLDispatch
//
//  Created by Robert Qiu on 12/25/14.
//  Copyright (c) 2014 iOSDevCon. All rights reserved.
//

#import <URLDispatch/URLParser.h>
#import <URLDispatch/URLDispatchException.h>

@implementation URLParseResult

-(NSString*)path
{
    return _path;
}

-(NSDictionary*)arguments
{
    return _args;
}

- (id)initWithPath:(NSString*)path arguments:(NSDictionary*)args
{
    self = [super init];
    if(self)
    {
        _path = path;
        _args = args;
    }
    return self;
}

@end

@implementation URLParser

+(URLParseResult*)parseUrl:(NSURL*)url
{
    if(url == nil)
        @throw [URLDispatchException exceptionWithReason:@"The url should not be nil"];
    
    NSString* path = url.path == nil || url.path.length == 0 ? @"/" : url.path;
    
    NSMutableDictionary *argDic = [[NSMutableDictionary alloc] init];
    NSArray* args = [url.query componentsSeparatedByString:@"&"];
    
    for (NSString* arg in args) {
        
        if ([arg length] == 0) {
            continue;
        }
        
        NSArray* nv = [arg componentsSeparatedByString:@"="];
        if (nv.count == 2) {
            [argDic setValue:[nv objectAtIndex:1] forKey:[nv objectAtIndex:0]];
        }
        else {
            [argDic setValue:@"" forKey:[nv objectAtIndex:0]];
        }
    }
    
    URLParseResult *result = [[URLParseResult alloc] initWithPath:path arguments:argDic];
    
    return result;
}

@end
