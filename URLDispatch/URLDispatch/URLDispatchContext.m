//
//  URLDispatchContext.m
//  URLDispatch
//
//  Created by Robert Qiu on 12/24/14.
//  Copyright (c) 2014 iOSDevCon. All rights reserved.
//

#import <URLDispatch/URLDispatchContext.h>

@implementation URLDispatchContext

@synthesize PreviousUrl;
@synthesize CurrentUrl;

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
    return [_arguments valueForKey:name];
}

- (void)setArgumentName:(NSString*)name Value:(NSObject*)value
{
    [_arguments setValue:value forKey:name];
}

@end
