//
//  URLDispatchMeta.m
//  URLDispatch
//
//  Created by Robert Qiu on 12/26/14.
//  Copyright (c) 2014 iOSDevCon. All rights reserved.
//

#import <URLDispatch/URLDispatchMeta.h>
#import <URLDispatch/URLParser.h>
#import <URLDispatch/URLDispatchException.h>

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

-(NSString*)description
{
    if(_description == nil)
    {
        NSMutableString *mstr = [[NSMutableString alloc] init];
        [mstr appendString:_scheme];
        [mstr appendString:@"://"];
        [mstr appendString:_host];
        
        if (_paths.count <= 1) {
            [mstr appendString:@"/"];
        }
        else
        {
            for (NSString* path in _paths) {
                if([path isEqualToString:@"/"])
                    continue;
                [mstr appendString:@"/"];
                [mstr appendString:path];
            }
        }
        
        for (int i = 0; i < _arguments.count; i++) {
            NSString *arg = [_arguments objectAtIndex:i];
            if( i > 0)
            {
                [mstr appendString:@"&"];
                [mstr appendString:arg];
            }
            else
            {
                [mstr appendString:@"?"];
                [mstr appendString:arg];
            }
        }
        _description = [mstr copy];
    }
    
    return _description;
}

@end


@implementation URLDispatchMetaCollection

- (id)init
{
    self = [super init];
    if (self) {
        _schemeIndexedCollection = [[NSMutableDictionary alloc] init];
        _nameIndexedCollection = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)addDispatchMeta:(URLDispatchMeta*)dispatchMeta
{
    if (dispatchMeta == nil) {
        @throw [URLDispatchException exceptionWithReason:@"dispatch meta should not be nil"];
    }
    
    if (dispatchMeta.name == nil || [dispatchMeta.name length] == 0)
    {
        @throw [URLDispatchException exceptionWithReason:@"dispatch meta name should not be nil or empty"];
    }
    
    if ([_nameIndexedCollection objectForKey:dispatchMeta.name] != nil) {
        @throw [URLDispatchException exceptionWithReason:@"dispatch meta name was registered"];
    }
    
    
}


- (void)addDispatchMetaUrl:(NSString*)url name:(NSString *)name
{
    if (url == nil || [url length] == 0) {
        @throw [URLDispatchException exceptionWithReason:@"dispatch meta url should not be nil or empty"];
    }
    
    if (name == nil || [name length] == 0) {
        @throw [URLDispatchException exceptionWithReason:@"dispatch meta name should not be nil or empty"];
    }
    
    URLDispatchMeta* meta = [[URLDispatchMeta alloc] initWithUrl:url name:name];
    [self addDispatchMeta:meta];
}

- (void)removeDispatchMeta:(URLDispatchMeta*)dispatchMeta
{
    if (dispatchMeta == nil) {
        @throw [URLDispatchException exceptionWithReason:@"dispatch meta should not be nil"];
    }
}

- (void)removeDispatchMetaUrl:(NSString*)url
{
    if (url == nil || [url length] == 0) {
        @throw [URLDispatchException exceptionWithReason:@"dispatch meta url should not be nil or empty"];
    }
}

- (void)removeDispatchMetaName:(NSString*)name
{
    if (name == nil || [name length] == 0) {
        @throw [URLDispatchException exceptionWithReason:@"dispatch meta name should not be nil or empty"];
    }
    
}

- (NSArray*)dispatchMetasWithScheme:(NSString*)scheme
{
    if (scheme == nil || [scheme length] == 0) {
        @throw [URLDispatchException exceptionWithReason:@"dispatch meta scheme should not be nil or empty"];
    }
    
    return nil;
}

- (NSArray*)dispatchMetasWithScheme:(NSString*)scheme host:(NSString*)host
{
    if (scheme == nil || [scheme length] == 0) {
        @throw [URLDispatchException exceptionWithReason:@"dispatch meta scheme should not be nil or empty"];
    }
    
    if (host == nil || [host length] == 0) {
        @throw [URLDispatchException exceptionWithReason:@"dispatch meta host should not be nil or empty"];
    }
    
    return nil;
}

- (NSArray*)dispatchMetasWithUrl:(NSString*)url
{
    if (url == nil || [url length] == 0) {
        @throw [URLDispatchException exceptionWithReason:@"dispatch meta url should not be nil or empty"];
    }
    
    return nil;
}

- (URLDispatchMeta*)dispatchMetaWithName:(NSString*)name
{
    if (name == nil || [name length] == 0) {
        @throw [URLDispatchException exceptionWithReason:@"dispatch meta name should not be nil or empty"];
    }
    
    return [_nameIndexedCollection objectForKey:name];
}

@end
