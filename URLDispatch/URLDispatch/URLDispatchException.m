//
//  URLDispatchException.m
//  URLDispatch
//
//  Created by Robert Qiu on 12/24/14.
//  Copyright (c) 2014 iOSDevCon. All rights reserved.
//

#import <URLDispatch/URLDispatchException.h>

@implementation URLDispatchException

+ (id)exceptionWithReason:(NSString *)aReason userInfo:(NSDictionary *)aUserInfo
{
    URLDispatchException *exp = [[URLDispatchException alloc] initWithReason:aReason userInfo:aUserInfo];
    return exp;
}

+ (id)exceptionWithReason:(NSString *)aReason
{
    return [URLDispatchException exceptionWithReason:aReason userInfo:nil];
}

- (id)initWithReason:(NSString *)aReason userInfo:(NSDictionary *)aUserInfo
{
    self = [super initWithName:@"URLDispatchException" reason:aReason userInfo:aUserInfo];
    if(self == nil)
        return nil;
    return self;
}

@end
