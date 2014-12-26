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

-(NSString*)scheme
{
    return _scheme;
}

-(NSString*)host
{
    return _host;
}

-(NSString*)path
{
    return _path;
}

-(NSDictionary*)arguments
{
    return _args;
}

-(NSArray*)argNames
{
    return _argNames;
}

- (id)initWithScheme:(NSString*)scheme host:(NSString*)host path:(NSString*)path argNames:(NSArray*)argNames arguments:(NSDictionary*)args;
{
    self = [super init];
    if(self)
    {
        _scheme = scheme;
        _host = host;
        _path = path;
        _args = args;
        _argNames = argNames;
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
    NSString* scheme = url.scheme;
    NSString* host = url.host;
    
    NSMutableDictionary *argDic = [[NSMutableDictionary alloc] init];
    NSMutableArray *argNames = [[NSMutableArray alloc] init];
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
        
        [argNames addObject:[nv objectAtIndex:0]];
    }
    
    URLParseResult *result = [[URLParseResult alloc] initWithScheme:scheme host:host path:path argNames:argNames arguments:argDic];
    
    return result;
}

@end
