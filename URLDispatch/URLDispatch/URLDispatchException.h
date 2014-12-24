//
//  URLDispatchException.h
//  URLDispatch
//
//  Created by Robert Qiu on 12/24/14.
//  Copyright (c) 2014 iOSDevCon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLDispatchException : NSException

+ (id)exceptionWithReason:(NSString *)aReason userInfo:(NSDictionary *)aUserInfo;
+ (id)exceptionWithReason:(NSString *)aReason;
- (id)initWithReason:(NSString *)aReason userInfo:(NSDictionary *)aUserInfo;

@end
