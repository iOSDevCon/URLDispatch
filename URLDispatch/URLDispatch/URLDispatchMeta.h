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
    NSString *_allPathsStr;
    NSString *_allArgsStr;
    NSArray *_paths;
    NSArray *_arguments;
    NSString *_name;
    NSString *_description;
}

+ (id)dispatchMetaWithUrl:(NSString*)url name:(NSString*)name;
- (id)initWithUrl:(NSString*)url name:(NSString*)name;

@property (readonly) NSString* scheme;
@property (readonly) NSString* host;
@property (readonly) NSString* allPathsStr;
@property (readonly) NSString* allArgsStr;
@property (readonly) NSString* allPathsAndArgsStr;
@property (readonly) NSArray* paths;
@property (readonly) NSArray* arguments;
@property (readonly) bool hasArgument;
@property (readonly) NSString* name;

-(NSString*)description;

@end

@interface URLDispatchMetaCollection : NSObject
{
    //use NSMutableDictionary to implement the collection, maybe use other structure to reimplement it in the future
    NSMutableDictionary *_schemeIndexedCollection;
    NSMutableDictionary *_nameIndexedCollection;
}

@property (readonly) NSUInteger metaCount;

- (id)init;

- (void)addDispatchMeta:(URLDispatchMeta*)dispatchMeta;
- (void)addDispatchMetaUrl:(NSString*)url name:(NSString*)name;
- (void)removeDispatchMeta:(URLDispatchMeta*)dispatchMeta;
- (void)removeDispatchMetaUrl:(NSString*)url;
- (void)removeDispatchMetaName:(NSString*)name;

- (NSArray*)dispatchMetasWithScheme:(NSString*)scheme;
- (NSArray*)dispatchMetasWithScheme:(NSString*)scheme host:(NSString*)host;
- (NSArray*)dispatchMetasWithUrl:(NSString*)url;
- (URLDispatchMeta*)dispatchMetaWithName:(NSString*)name;

@end
