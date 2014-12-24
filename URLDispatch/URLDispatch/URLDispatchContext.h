//
//  URLDispatchContext.h
//  URLDispatch
//
//  Created by Robert Qiu on 12/24/14.
//  Copyright (c) 2014 iOSDevCon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLDispatchContext : NSObject
{
   NSMutableDictionary *_arguments;
}

@property NSString* PreviousUrl;
@property NSString* CurrentUrl;

- (id)initWith:(NSDictionary *)args;
- (id)init;
- (NSObject*)argumentOfName:(NSString*)name;
- (void)setArgumentName:(NSString*)name Value:(NSObject*)value;

@end
