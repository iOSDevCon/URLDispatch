//
//  URLDispatchTests.m
//  URLDispatchTests
//
//  Created by Robert Qiu on 12/24/14.
//  Copyright (c) 2014 iOSDevCon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <URLDispatch/URLDispatch.h>


@interface MockDispatchableNullUrlFactory : NSObject<URLDispatchDelegateFactory>
{
}

@property (readonly) NSArray* dispatchUrls;

-(id<URLDispatchDelegate>)createWithDispatcher:(id<URLDispatcher>)navigator url:(NSString*)url;


@end

@interface MockDispatchableEmptyUrlFactory : MockDispatchableNullUrlFactory

@end

@interface MockDispatchableDupUrlFactory : MockDispatchableNullUrlFactory

@end

@interface MockDispatchableCreateNilFactory : MockDispatchableNullUrlFactory

@end

@interface MockDispatchableObject4Factory : MockDispatchableNullUrlFactory

@end

@implementation MockDispatchableNullUrlFactory

-(NSArray*) dispatchUrls
{
    return nil;
}

-(id<URLDispatchDelegate>)createWithDispatcher:(id<URLDispatcher>)dispatcher url:(NSString*)url
{
    return nil;
}

@end

@implementation MockDispatchableEmptyUrlFactory

-(NSArray*) dispatchUrls
{
    return @[];
}

@end

@implementation MockDispatchableDupUrlFactory

-(NSArray*) dispatchUrls
{
    return @[@"Object1"];
}

@end

@implementation MockDispatchableCreateNilFactory

-(NSArray*) dispatchUrls
{
    return @[@"Object3"];
}

@end

@implementation MockDispatchableObject4Factory

-(NSArray*) dispatchUrls
{
    return @[@"Object4"];
}

@end

@interface MockDispatchableObjectFactory1 : NSObject<URLDispatchDelegateFactory>
{
}

@property (readonly) NSArray* dispatchUrls;

-(id<URLDispatchDelegate>)createWithDispatcher:(id<URLDispatcher>)navigator url:(NSString*)url;

@end

@interface MockDispatchableObject1 : NSObject<URLDispatchDelegate>
{
    __weak id<URLDispatcher> _dispatcher;
    NSString *_dispatchUrl;
}

@property (readonly) NSString* dispatchUrl;
@property (readonly) id<URLDispatcher> Dispatcher;

@property URLDispatchContext *gotoContext;
@property URLDispatchContext *backContext;
@property URLDispatchContext *reloadContext;

- (id)initWith:(id<URLDispatcher>)dispatcher url:(NSString*)url;

- (void)gotoWithContext:(URLDispatchContext*)context;
- (void)BackWithContext:(URLDispatchContext*)context;
- (void)ReloadWithContext:(URLDispatchContext*)context;


@end

@interface MockDispatchableObject2 : MockDispatchableObject1

@end


@implementation MockDispatchableObjectFactory1

-(NSArray*) dispatchUrls
{
    return @[@"Object1",@"Object2"];
}


-(id<URLDispatchDelegate>)createWithDispatcher:(id<URLDispatcher>)dispatcher url:(NSString*)url
{
    if ([url isEqualToString:@"Object1"]) {
        
        return [[MockDispatchableObject1 alloc] initWith:dispatcher url:url];
        
    }
    else if ([url isEqualToString:@"Object2"])
    {
        return [[MockDispatchableObject2 alloc] initWith:dispatcher url:url];
    }
    return nil;
}


@end

@implementation MockDispatchableObject1

@synthesize gotoContext;
@synthesize backContext;
@synthesize reloadContext;

- (id)initWith:(id<URLDispatcher>)dispatcher url:(NSString*)url
{
    self  = [super init];
    _dispatcher = dispatcher;
    _dispatchUrl = url;
    return self;
}

-(NSString*)dispatchUrl
{
    return _dispatchUrl;
}

-(id<URLDispatcher>)Dispatcher
{
    return _dispatcher;
}

- (void)gotoWithContext:(URLDispatchContext*)context
{
    self.gotoContext = context;
}

- (void)BackWithContext:(URLDispatchContext*)context
{
    self.backContext = context;
}

- (void)ReloadWithContext:(URLDispatchContext*)context
{
    self.reloadContext = context;
}

@end

@implementation MockDispatchableObject2

@end



@interface URLDispatchTests : XCTestCase

@end

@implementation URLDispatchTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testBasicURLDispatcher {
    // This is an example of a functional test case.
    
    BasicURLDispatcher *dispatcher = [[BasicURLDispatcher alloc] init];
    [dispatcher registerFactory:[[MockDispatchableObjectFactory1 alloc] init]];
    [dispatcher gotoUrl:@"Object1" withArgs:nil];
    MockDispatchableObject1 *mockObj1 = (MockDispatchableObject1*)dispatcher.CurrentDelegate;
    XCTAssertNil(mockObj1.gotoContext.previousUrl);
    XCTAssertEqual(@"Object1", mockObj1.gotoContext.currentUrl);
    
    [dispatcher gotoUrl:@"Object2" withArgs:nil];
    MockDispatchableObject1 *mockObj2 = (MockDispatchableObject1*)dispatcher.CurrentDelegate;
    XCTAssertEqual(@"Object1", mockObj2.gotoContext.previousUrl);
    XCTAssertEqual(@"Object2", mockObj2.gotoContext.currentUrl);
    
    NSArray *history = [dispatcher dispatchHistory];
    XCTAssertEqual(2, [history count]);
    
    URLDispatchHistory* ctx1 = (URLDispatchHistory*)[history objectAtIndex:0];
    XCTAssertEqual(@"Object1", ctx1.url);
    XCTAssertNotNil(ctx1.context);
    XCTAssertNil(ctx1.context.previousUrl);
    XCTAssertEqual(@"Object1", ctx1.context.currentUrl);
    
    
    URLDispatchHistory* ctx2 = (URLDispatchHistory*)[history objectAtIndex:1];
    XCTAssertEqual(@"Object2", ctx2.url);
    XCTAssertNotNil(ctx2.context);
    XCTAssertEqual(@"Object1", ctx2.context.previousUrl);
    XCTAssertEqual(@"Object2", ctx2.context.currentUrl);
    
}

- (void)testBasicURLDispatcherExp {
    
    BasicURLDispatcher *dispatcher = [[BasicURLDispatcher alloc] init];
    XCTAssertThrowsSpecific([dispatcher registerFactory:nil],URLDispatchException);
    XCTAssertThrowsSpecific([dispatcher registerFactory:[[MockDispatchableNullUrlFactory alloc] init]],URLDispatchException);
    XCTAssertThrowsSpecific([dispatcher registerFactory:[[MockDispatchableEmptyUrlFactory alloc] init]],URLDispatchException);
    
    XCTAssertThrowsSpecific([dispatcher changeRegisterFactory:nil],URLDispatchException);
    XCTAssertThrowsSpecific([dispatcher changeRegisterFactory:[[MockDispatchableNullUrlFactory alloc] init]],URLDispatchException);
    XCTAssertThrowsSpecific([dispatcher changeRegisterFactory:[[MockDispatchableEmptyUrlFactory alloc] init]],URLDispatchException);
    
    XCTAssertNoThrow([dispatcher registerFactory:[[MockDispatchableObjectFactory1 alloc] init]]);
    
    XCTAssertThrowsSpecific([dispatcher registerFactory:[[MockDispatchableDupUrlFactory alloc] init]],URLDispatchException);
 
    XCTAssertNoThrow([dispatcher registerFactory:[[MockDispatchableCreateNilFactory alloc] init]]);
    XCTAssertThrowsSpecific([dispatcher registerFactory:[[MockDispatchableCreateNilFactory alloc] init]],URLDispatchException);
    
    XCTAssertThrowsSpecific([dispatcher gotoUrl:@"Object3" withArgs:nil],URLDispatchException);
    
    XCTAssertThrowsSpecific([dispatcher gotoUrl:nil withArgs:nil],URLDispatchException);
    
    XCTAssertThrowsSpecific([dispatcher unregisterUrl:@"Object4"],URLDispatchException);
    
    XCTAssertThrowsSpecific([dispatcher unregisterUrl:nil],URLDispatchException);
    
    XCTAssertThrowsSpecific([dispatcher unregisterFactory:nil],URLDispatchException);
    
    XCTAssertNoThrow([dispatcher unregisterUrl:@"Object3"]);
    
    XCTAssertNoThrow([dispatcher registerFactory:[[MockDispatchableCreateNilFactory alloc] init]]);
    
    XCTAssertNoThrow([dispatcher registerFactory:[[MockDispatchableObject4Factory alloc] init]]);
    
    
    XCTAssertNoThrow([dispatcher unregisterFactory:[[MockDispatchableCreateNilFactory alloc] init]]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
