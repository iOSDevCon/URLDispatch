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
    NSString *_description;
}

+ (id)dispatchMetaWithUrl:(NSString*)url name:(NSString*)name;
- (id)initWithUrl:(NSString*)url name:(NSString*)name;

@property (readonly) NSString* scheme;
@property (readonly) NSString* host;
@property (readonly) NSArray* paths;
@property (readonly) NSArray* arguments;
@property (readonly) bool hasArgument;
@property (readonly) NSString* name;

-(NSString*)description;

@end

@interface URLDispatchMetaCollection : NSObject

- (void)addDispatchMeta:(URLDispatchMeta*)dispatchMeta;
- (void)addDispatchMetaUrl:(NSString*)url;
- (void)removeDispatchMeta:(URLDispatchMeta*)dispatchMeta;
- (void)removeDispatchMetaUrl:(NSString*)url;

- (NSArray*)dispatchMetasWithScheme:(NSString*)scheme;
- (NSArray*)dispatchMetasWithScheme:(NSString*)scheme host:(NSString*)host;
- (NSArray*)dispatchMetasWithUrl:(NSString*)url;

@end
