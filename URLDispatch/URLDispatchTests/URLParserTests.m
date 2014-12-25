//
//  URLParserTests.m
//  URLDispatch
//
//  Created by Robert Qiu on 12/25/14.
//  Copyright (c) 2014 iOSDevCon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <URLDispatch/URLDispatch.h>

@interface URLParserTests : XCTestCase

@end

@implementation URLParserTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSimpleUrlParse {

    URLParseResult* result = [URLParser parseUrl:[NSURL URLWithString:@"scheme:///p1/p2?arg1=v1&arg2=v2"]];
    
    XCTAssertEqualObjects(@"/p1/p2",result.path);
    XCTAssertEqual(2,[result.arguments count]);
    XCTAssertEqualObjects(@"v1",[result.arguments objectForKey:@"arg1"]);
    XCTAssertEqualObjects(@"v2",[result.arguments objectForKey:@"arg2"]);
    
    result = [URLParser parseUrl:[NSURL URLWithString:@"scheme://?arg1=v1&arg2=v2"]];
    
    XCTAssertEqualObjects(@"/",result.path);
    XCTAssertEqual(2,[result.arguments count]);
    XCTAssertEqualObjects(@"v1",[result.arguments objectForKey:@"arg1"]);
    XCTAssertEqualObjects(@"v2",[result.arguments objectForKey:@"arg2"]);
    
    XCTAssertThrowsSpecific([URLParser parseUrl:[NSURL URLWithString:nil]], URLDispatchException);
    
    result = [URLParser parseUrl:[NSURL URLWithString:@"scheme:///?arg1=v1&arg2=v2"]];
    
    XCTAssertEqualObjects(@"/",result.path);
    XCTAssertEqual(2,[result.arguments count]);
    XCTAssertEqualObjects(@"v1",[result.arguments objectForKey:@"arg1"]);
    XCTAssertEqualObjects(@"v2",[result.arguments objectForKey:@"arg2"]);
    
    result = [URLParser parseUrl:[NSURL URLWithString:@"scheme:///?arg1=&arg2=v2"]];
    
    XCTAssertEqualObjects(@"/",result.path);
    XCTAssertEqual(2,[result.arguments count]);
    XCTAssertEqualObjects(@"",[result.arguments objectForKey:@"arg1"]);
    XCTAssertEqualObjects(@"v2",[result.arguments objectForKey:@"arg2"]);
    
    result = [URLParser parseUrl:[NSURL URLWithString:@"scheme:///?arg1&arg2=v2"]];
    
    XCTAssertEqualObjects(@"/",result.path);
    XCTAssertEqual(2,[result.arguments count]);
    XCTAssertEqualObjects(@"",[result.arguments objectForKey:@"arg1"]);
    XCTAssertEqualObjects(@"v2",[result.arguments objectForKey:@"arg2"]);
    
    result = [URLParser parseUrl:[NSURL URLWithString:@"scheme:///?"]];
    
    XCTAssertEqualObjects(@"/",result.path);
    XCTAssertEqual(0,[result.arguments count]);
    XCTAssertEqualObjects(nil,[result.arguments objectForKey:@"arg1"]);
    
    result = [URLParser parseUrl:[NSURL URLWithString:@"scheme://"]];
    
    XCTAssertEqualObjects(@"/",result.path);
    XCTAssertEqual(0,[result.arguments count]);
    XCTAssertEqualObjects(nil,[result.arguments objectForKey:@"arg1"]);

    result = [URLParser parseUrl:[NSURL URLWithString:@"scheme:///"]];
    
    XCTAssertEqualObjects(@"/",result.path);
    XCTAssertEqual(0,[result.arguments count]);
    XCTAssertEqualObjects(nil,[result.arguments objectForKey:@"arg1"]);
}


@end
