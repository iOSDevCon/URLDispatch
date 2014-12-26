//
//  URLDispatchNavigationViewController.m
//  URLDispatch
//
//  Created by Robert Qiu on 12/25/14.
//  Copyright (c) 2014 iOSDevCon. All rights reserved.
//

#import <URLDispatch/URLDispatchNavigationViewController.h>

@implementation URLDispatchNavigationViewController

-(id<URLDispatchDelegate>)rootDelegate
{
    return [_innerDispatcher rootDelegate];
}

-(id<URLDispatchDelegate>)currentDelegate
{
    return [_innerDispatcher currentDelegate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithInnerDispacher:(id<URLDispatcher>)innerDispatcher
{
    self = [super initWithRootViewController:(UIViewController*)innerDispatcher.rootDelegate];
    if(self)
    {
        _innerDispatcher = innerDispatcher;
    }
    return self;
}

- (void)registerFactory:(id<URLDispatchDelegateFactory>)navigateableFactory
{
    [_innerDispatcher registerFactory:navigateableFactory];
}

- (void)changeRegisterFactory:(id<URLDispatchDelegateFactory>)navigateableFactory
{
    [_innerDispatcher changeRegisterFactory:navigateableFactory];
}

- (void)unregisterUrl:(NSString*)url
{
    [_innerDispatcher unregisterUrl:url];
}

- (void)unregisterFactory:(id<URLDispatchDelegateFactory>)navigateableFactory
{
    [_innerDispatcher unregisterFactory:navigateableFactory];
}

- (id<URLDispatchDelegate>)createDispatchDelegateWithUrl:(NSString*)url
{
    return [_innerDispatcher createDispatchDelegateWithUrl:url];
}

- (id<URLDispatchDelegate>)createDispatchDelegateWithUrl:(NSString*)url dispacher:(id<URLDispatcher>)dispacher
{
    return [_innerDispatcher createDispatchDelegateWithUrl:url dispacher:dispacher];
}

- (void)dispatchDelegate:(id<URLDispatchDelegate>)delegate withArgs:(NSDictionary*)args
{
    [_innerDispatcher dispatchDelegate:delegate withArgs:args];
}

- (void)dispatchUrl:(NSString*)url withArgs:(NSDictionary*)args
{
    id<URLDispatchDelegate> delegate = [_innerDispatcher createDispatchDelegateWithUrl:url dispacher:self];
    [_innerDispatcher dispatchDelegate:delegate withArgs:args];
    UIViewController* ctrl = (UIViewController*)_innerDispatcher.currentDelegate;
    [self pushViewController:ctrl animated:TRUE];
}

- (NSArray*)dispatchHistory
{
    return [_innerDispatcher dispatchHistory];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
