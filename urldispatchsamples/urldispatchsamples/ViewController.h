//
//  ViewController.h
//  urldispatchsamples
//
//  Created by Robert Qiu on 12/26/14.
//  Copyright (c) 2014 iOSDevCon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <URLDispatch/URLDispatch.h>

@interface ViewController : URLDispatchTargetViewController
{
    id<URLDispatcher> _myDispatcher;
}

@end

