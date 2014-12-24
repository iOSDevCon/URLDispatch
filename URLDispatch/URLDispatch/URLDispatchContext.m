//
//  URLDispatchContext.m
//  URLDispatch
//
//  Created by Robert Qiu on 12/24/14.
//  Copyright (c) 2014 iOSDevCon. All rights reserved.
//

#import <URLDispatch/URLDispatchContext.h>
#import <URLDispatch/URLDispatchException.h>

@implementation URLDispatchContext

@synthesize previousUrl;
@synthesize currentUrl;

- (id)initWith:(NSDictionary *)args
{
    self = [super init];
    if(!self)
        return nil;

    _arguments = [[NSMutableDictionary alloc] initWithDictionary:args];
    return self;
}

- (id)init
{
    self = [super init];
    if(!self)
        return nil;
    
    _arguments = [[NSMutableDictionary alloc] init];
    return self;
}

- (NSObject*)argumentOfName:(NSString*)name
{
    if (name == nil || [name length] == 0)
        @throw [URLDispatchException exceptionWithReason:@"argument name should not be nil or empty"];
    
    return [_arguments valueForKey:name];
}

- (void)setArgumentName:(NSString*)name Value:(NSObject*)value
{
    if (name == nil || [name length] == 0)
        @throw [URLDispatchException exceptionWithReason:@"argument name should not be nil or empty"];
    
    if (value == nil)
        @throw [URLDispatchException exceptionWithReason:@"argument value should not be nil"];
    
    [_arguments setValue:value forKey:name];
}

@end
