//
//  URLDispatchMeta.m
//  URLDispatch
//
//  Created by Robert Qiu on 12/26/14.
//  Copyright (c) 2014 iOSDevCon. All rights reserved.
//

#import <URLDispatch/URLDispatchMeta.h>
#import <URLDispatch/URLParser.h>

@implementation URLDispatchMeta

+ (id)dispatchMetaWithUrl:(NSString*)url name:(NSString *)name
{
    __autoreleasing URLDispatchMeta *meta = [[URLDispatchMeta alloc] initWithUrl:url name:name];
    return  meta;
}

- (id)initWithUrl:(NSString*)url name:(NSString *)name
{
    self = [super init];
    if (self) {
        
        URLParseResult *result = [URLParser parseUrl:[NSURL URLWithString:url]];
        _scheme = result.scheme == nil || result.scheme.length == 0 ? @"dispatch-vc" : result.scheme;
        _host = result.host == nil ? @"" : result.host;
        
        NSMutableArray *pathArray = [[NSMutableArray alloc] init];
        [pathArray addObject:@"/"];
        NSArray* paths = [result.path componentsSeparatedByString:@"/"];
        for (NSString* path in paths) {
            if ([path length] == 0) {
                continue;
            }
            [pathArray addObject:path];
        }
        _paths = pathArray;
        
        _arguments = [[NSMutableArray alloc] initWithArray:result.argNames];
        
        _name = name;
    }
    return self;
}

-(NSString*)scheme
{
    return _scheme;
}

-(NSString*)host
{
    return _host;
}

-(NSArray*)paths
{
    return _paths;
}

-(NSArray*)arguments
{
    return _arguments;
}

-(bool)hasArgument
{
    return [_arguments count] > 0;
}

-(NSString*)name
{
    return _name;
}

@end
