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

- (NSArray*)dispatchMetas
{
    return nil;
}

-(id<URLDispatchDelegate>)createWithDispatcher:(id<URLDispatcher>)dispatcher url:(NSString*)url
{
    return nil;
}

-(id<URLDispatchDelegate>)createWithDispatcher:(id<URLDispatcher>)dispatcher name:(NSString*)name
{
    return nil;
}

@end

@implementation MockDispatchableEmptyUrlFactory

- (NSArray*)dispatchMetas
{
    return @[];
}

@end

@implementation MockDispatchableDupUrlFactory

-(NSArray*) dispatchMetas
{
    URLDispatchMeta* meta = [[URLDispatchMeta alloc] initWithUrl:@"/Object1" name:@"Object1"];
    
    return @[meta];
}

@end

@implementation MockDispatchableCreateNilFactory

-(NSArray*) dispatchMetas
{
    URLDispatchMeta* meta = [[URLDispatchMeta alloc] initWithUrl:@"/Object3" name:@"Object3"];
    
    return @[meta];
}

@end

@implementation MockDispatchableObject4Factory

-(NSArray*) dispatchMetas
{
    URLDispatchMeta* meta = [[URLDispatchMeta alloc] initWithUrl:@"/Object4" name:@"Object4"];
    
    return @[meta];
}

@end

@interface MockDispatchableObjectFactory1 : NSObject<URLDispatchDelegateFactory>
{
}

@property (readonly) NSArray* dispatchMetas;

-(id<URLDispatchDelegate>)createWithDispatcher:(id<URLDispatcher>)navigator url:(NSString*)url;
-(id<URLDispatchDelegate>)createWithDispatcher:(id<URLDispatcher>)navigator name:(NSString*)name;

@end

@interface MockDispatchableObject1 : NSObject<URLDispatchDelegate>
{
    __weak id<URLDispatcher> _dispatcher;
    NSString *_dispatchUrl;
}

@property (readonly) NSString* dispatchUrl;
@property (readonly) id<URLDispatcher> Dispatcher;

@property URLDispatchContext *gotoContext;
//@property URLDispatchContext *backContext;
//@property URLDispatchContext *reloadContext;

- (id)initWith:(id<URLDispatcher>)dispatcher url:(NSString*)url;

- (void)dispatchedWith:(URLDispatchContext*)context;
//- (void)backWithContext:(URLDispatchContext*)context;
//- (void)reloadWithContext:(URLDispatchContext*)context;


@end

@interface MockDispatchableObject2 : MockDispatchableObject1

@end


@implementation MockDispatchableObjectFactory1

-(NSArray*) dispatchMetas
{
    URLDispatchMeta* meta1 = [[URLDispatchMeta alloc] initWithUrl:@"/Object1" name:@"Object1"];
    URLDispatchMeta* meta2 = [[URLDispatchMeta alloc] initWithUrl:@"/Object2" name:@"Object2"];
    
    
    return @[meta1,meta2];
}


-(id<URLDispatchDelegate>)createWithDispatcher:(id<URLDispatcher>)dispatcher url:(NSString*)url
{
    if ([url isEqualToString:@"/Object1"]) {
        
        return [[MockDispatchableObject1 alloc] initWith:dispatcher url:url];
        
    }
    else if ([url isEqualToString:@"/Object2"])
    {
        return [[MockDispatchableObject2 alloc] initWith:dispatcher url:url];
    }
    return nil;
}

-(id<URLDispatchDelegate>)createWithDispatcher:(id<URLDispatcher>)dispatcher name:(NSString*)name
{
    if ([name isEqualToString:@"Object1"]) {
        
        return [[MockDispatchableObject1 alloc] initWith:dispatcher url:@"/Object1"];
        
    }
    else if ([name isEqualToString:@"Object2"])
    {
        return [[MockDispatchableObject2 alloc] initWith:dispatcher url:@"/Object2"];
    }
    return nil;
}


@end

@implementation MockDispatchableObject1

@synthesize gotoContext;

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

-(id<URLDispatcher>)dispatcher
{
    return _dispatcher;
}

- (void)dispatchedWith:(URLDispatchContext*)context
{
    self.gotoContext = context;
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
    [dispatcher dispatchUrl:@"/Object1" withArgs:nil];
    MockDispatchableObject1 *mockObj1 = (MockDispatchableObject1*)dispatcher.currentDelegate;
    XCTAssertNil(mockObj1.gotoContext.previousUrl);
    XCTAssertEqualObjects(@"/Object1", mockObj1.gotoContext.currentUrl);
    
    [dispatcher dispatchUrl:@"/Object2" withArgs:nil];
    MockDispatchableObject1 *mockObj2 = (MockDispatchableObject1*)dispatcher.currentDelegate;
    XCTAssertEqualObjects(@"/Object1", mockObj2.gotoContext.previousUrl);
    XCTAssertEqualObjects(@"/Object2", mockObj2.gotoContext.currentUrl);
    
    NSArray *history = [dispatcher dispatchHistory];
    XCTAssertEqual(2, [history count]);
    
    URLDispatchHistory* ctx1 = (URLDispatchHistory*)[history objectAtIndex:0];
    XCTAssertEqualObjects(@"/Object1", ctx1.url);
    XCTAssertNotNil(ctx1.context);
    XCTAssertNil(ctx1.context.previousUrl);
    XCTAssertEqualObjects(@"/Object1", ctx1.context.currentUrl);
    
    URLDispatchHistory* ctx2 = (URLDispatchHistory*)[history objectAtIndex:1];
    XCTAssertEqualObjects(@"/Object2", ctx2.url);
    XCTAssertNotNil(ctx2.context);
    XCTAssertEqualObjects(@"/Object1", ctx2.context.previousUrl);
    XCTAssertEqualObjects(@"/Object2", ctx2.context.currentUrl);
}

- (void)testBasicURLDispatcherByName {
    // This is an example of a functional test case.
    
    BasicURLDispatcher *dispatcher = [[BasicURLDispatcher alloc] init];
    [dispatcher registerFactory:[[MockDispatchableObjectFactory1 alloc] init]];
    [dispatcher dispatchName:@"Object1" withArgs:nil];
    MockDispatchableObject1 *mockObj1 = (MockDispatchableObject1*)dispatcher.currentDelegate;
    XCTAssertNil(mockObj1.gotoContext.previousUrl);
    XCTAssertEqualObjects(@"/Object1", mockObj1.gotoContext.currentUrl);
    
    [dispatcher dispatchName:@"Object2" withArgs:nil];
    MockDispatchableObject1 *mockObj2 = (MockDispatchableObject1*)dispatcher.currentDelegate;
    XCTAssertEqualObjects(@"/Object1", mockObj2.gotoContext.previousUrl);
    XCTAssertEqualObjects(@"/Object2", mockObj2.gotoContext.currentUrl);
    
    NSArray *history = [dispatcher dispatchHistory];
    XCTAssertEqual(2, [history count]);
    
    URLDispatchHistory* ctx1 = (URLDispatchHistory*)[history objectAtIndex:0];
    XCTAssertEqualObjects(@"/Object1", ctx1.url);
    XCTAssertNotNil(ctx1.context);
    XCTAssertNil(ctx1.context.previousUrl);
    XCTAssertEqualObjects(@"/Object1", ctx1.context.currentUrl);
    
    URLDispatchHistory* ctx2 = (URLDispatchHistory*)[history objectAtIndex:1];
    XCTAssertEqualObjects(@"/Object2", ctx2.url);
    XCTAssertNotNil(ctx2.context);
    XCTAssertEqualObjects(@"/Object1", ctx2.context.previousUrl);
    XCTAssertEqualObjects(@"/Object2", ctx2.context.currentUrl);
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
    XCTAssertEqual(1, dispatcher.factoryCount);
    XCTAssertEqual(2, dispatcher.metaCount);
    
    XCTAssertThrowsSpecific([dispatcher registerFactory:[[MockDispatchableDupUrlFactory alloc] init]],URLDispatchException);
 
    XCTAssertNoThrow([dispatcher registerFactory:[[MockDispatchableCreateNilFactory alloc] init]]);
    XCTAssertEqual(2, dispatcher.factoryCount);
    XCTAssertEqual(3, dispatcher.metaCount);
    
    XCTAssertThrowsSpecific([dispatcher registerFactory:[[MockDispatchableCreateNilFactory alloc] init]],URLDispatchException);
    
    XCTAssertThrowsSpecific([dispatcher dispatchUrl:@"/Object3" withArgs:nil],URLDispatchException);
    
    XCTAssertThrowsSpecific([dispatcher dispatchUrl:nil withArgs:nil],URLDispatchException);
    
    XCTAssertThrowsSpecific([dispatcher unregisterUrl:@"/Object4"],URLDispatchException);
    
    XCTAssertThrowsSpecific([dispatcher unregisterUrl:nil],URLDispatchException);
    
    XCTAssertThrowsSpecific([dispatcher unregisterFactory:nil],URLDispatchException);
    
    XCTAssertNoThrow([dispatcher unregisterUrl:@"/Object3"]);
    XCTAssertEqual(1, dispatcher.factoryCount);
    XCTAssertEqual(2, dispatcher.metaCount);
    
    XCTAssertNoThrow([dispatcher registerFactory:[[MockDispatchableCreateNilFactory alloc] init]]);
    XCTAssertEqual(2, dispatcher.factoryCount);
    XCTAssertEqual(3, dispatcher.metaCount);
    
    XCTAssertNoThrow([dispatcher registerFactory:[[MockDispatchableObject4Factory alloc] init]]);
    XCTAssertEqual(3, dispatcher.factoryCount);
    XCTAssertEqual(4, dispatcher.metaCount);
    
    XCTAssertNoThrow([dispatcher unregisterFactory:[[MockDispatchableCreateNilFactory alloc] init]]);
    XCTAssertEqual(2, dispatcher.factoryCount);
    XCTAssertEqual(3, dispatcher.metaCount);
    
    XCTAssertNoThrow([dispatcher unregisterName:@"Object1"]);
    XCTAssertEqual(1, dispatcher.factoryCount);
    XCTAssertEqual(1, dispatcher.metaCount);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
