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
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
