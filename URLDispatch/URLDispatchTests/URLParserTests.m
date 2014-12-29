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
    XCTAssertEqualObjects(@"arg1",result.argNames[0]);
    XCTAssertEqualObjects(@"arg2",result.argNames[1]);
    
    XCTAssertEqualObjects(@"scheme", result.scheme);
    XCTAssertNil(result.host);
    
    result = [URLParser parseUrl:[NSURL URLWithString:@"scheme://?arg1=v1&arg2=v2"]];
    
    XCTAssertEqualObjects(@"/",result.path);
    XCTAssertEqual(2,[result.arguments count]);
    XCTAssertEqualObjects(@"v1",[result.arguments objectForKey:@"arg1"]);
    XCTAssertEqualObjects(@"v2",[result.arguments objectForKey:@"arg2"]);
    XCTAssertEqual(2,[result.argNames count]);
    XCTAssertEqualObjects(@"arg1",result.argNames[0]);
    XCTAssertEqualObjects(@"arg2",result.argNames[1]);
    
    XCTAssertThrowsSpecific([URLParser parseUrl:[NSURL URLWithString:nil]], URLDispatchException);
    
    result = [URLParser parseUrl:[NSURL URLWithString:@"scheme:///?arg1=v1&arg2=v2"]];
    
    XCTAssertEqualObjects(@"/",result.path);
    XCTAssertEqual(2,[result.arguments count]);
    XCTAssertEqualObjects(@"v1",[result.arguments objectForKey:@"arg1"]);
    XCTAssertEqualObjects(@"v2",[result.arguments objectForKey:@"arg2"]);
    XCTAssertEqual(2,[result.argNames count]);
    XCTAssertEqualObjects(@"arg1",result.argNames[0]);
    XCTAssertEqualObjects(@"arg2",result.argNames[1]);
    
    result = [URLParser parseUrl:[NSURL URLWithString:@"scheme:///?arg1=&arg2=v2"]];
    
    XCTAssertEqualObjects(@"/",result.path);
    XCTAssertEqual(2,[result.arguments count]);
    XCTAssertEqualObjects(@"",[result.arguments objectForKey:@"arg1"]);
    XCTAssertEqualObjects(@"v2",[result.arguments objectForKey:@"arg2"]);
    XCTAssertEqual(2,[result.argNames count]);
    XCTAssertEqualObjects(@"arg1",result.argNames[0]);
    XCTAssertEqualObjects(@"arg2",result.argNames[1]);
    
    result = [URLParser parseUrl:[NSURL URLWithString:@"scheme:///?arg1&arg2=v2"]];
    
    XCTAssertEqualObjects(@"/",result.path);
    XCTAssertEqual(2,[result.arguments count]);
    XCTAssertEqualObjects(@"",[result.arguments objectForKey:@"arg1"]);
    XCTAssertEqualObjects(@"v2",[result.arguments objectForKey:@"arg2"]);
    XCTAssertEqual(2,[result.argNames count]);
    XCTAssertEqualObjects(@"arg1",result.argNames[0]);
    XCTAssertEqualObjects(@"arg2",result.argNames[1]);
    
    result = [URLParser parseUrl:[NSURL URLWithString:@"scheme:///?"]];
    
    XCTAssertEqualObjects(@"/",result.path);
    XCTAssertEqual(0,[result.arguments count]);
    XCTAssertEqualObjects(nil,[result.arguments objectForKey:@"arg1"]);
    XCTAssertEqual(0,[result.argNames count]);
    
    result = [URLParser parseUrl:[NSURL URLWithString:@"scheme://"]];
    
    XCTAssertEqualObjects(@"/",result.path);
    XCTAssertEqual(0,[result.arguments count]);
    XCTAssertEqualObjects(nil,[result.arguments objectForKey:@"arg1"]);
    XCTAssertEqual(0,[result.argNames count]);

    result = [URLParser parseUrl:[NSURL URLWithString:@"scheme:///"]];
    
    XCTAssertEqualObjects(@"/",result.path);
    XCTAssertEqual(0,[result.arguments count]);
    XCTAssertEqualObjects(nil,[result.arguments objectForKey:@"arg1"]);
    XCTAssertEqual(0,[result.argNames count]);
    
    result = [URLParser parseUrl:[NSURL URLWithString:@"dispatch-vc://host/p1/p2?arg1=v1&arg2=v2"]];
    XCTAssertEqualObjects(@"/p1/p2",result.path);
    XCTAssertEqual(2,[result.arguments count]);
    XCTAssertEqualObjects(@"v1",[result.arguments objectForKey:@"arg1"]);
    XCTAssertEqualObjects(@"v2",[result.arguments objectForKey:@"arg2"]);
    XCTAssertEqual(2,[result.argNames count]);
    XCTAssertEqualObjects(@"arg1",result.argNames[0]);
    XCTAssertEqualObjects(@"arg2",result.argNames[1]);
    XCTAssertEqualObjects(@"dispatch-vc", result.scheme);
    XCTAssertEqualObjects(@"host", result.host);
    
    result = [URLParser parseUrl:[NSURL URLWithString:@"/host/p1/p2?arg1=v1&arg2=v2"]];
    XCTAssertEqualObjects(@"/host/p1/p2",result.path);
    XCTAssertEqual(2,[result.arguments count]);
    XCTAssertEqualObjects(@"v1",[result.arguments objectForKey:@"arg1"]);
    XCTAssertEqualObjects(@"v2",[result.arguments objectForKey:@"arg2"]);
    XCTAssertEqual(2,[result.argNames count]);
    XCTAssertEqualObjects(@"arg1",result.argNames[0]);
    XCTAssertEqualObjects(@"arg2",result.argNames[1]);
    XCTAssertNil(result.scheme);
    XCTAssertNil(result.host);
    
    result = [URLParser parseUrl:[NSURL URLWithString:@"://host/p1/p2?arg1=v1&arg2=v2"]];
    XCTAssertEqualObjects(@"/p1/p2",result.path);
    XCTAssertEqual(2,[result.arguments count]);
    XCTAssertEqualObjects(@"v1",[result.arguments objectForKey:@"arg1"]);
    XCTAssertEqualObjects(@"v2",[result.arguments objectForKey:@"arg2"]);
    XCTAssertEqual(2,[result.argNames count]);
    XCTAssertEqualObjects(@"arg1",result.argNames[0]);
    XCTAssertEqualObjects(@"arg2",result.argNames[1]);
    XCTAssertEqualObjects(@"",result.scheme);
    XCTAssertEqualObjects(@"host", result.host);
}

- (void)testURLDispatchMeta
{
    URLDispatchMeta *meta = [[URLDispatchMeta alloc] initWithUrl:@"dispatch-vc://host/p1/p2?arg1=v1&arg2=v2" name:@"vc"];
    
    XCTAssertEqual(3,meta.paths.count);
    XCTAssertEqualObjects(@"/",meta.paths[0]);
    XCTAssertEqualObjects(@"p1",meta.paths[1]);
    XCTAssertEqualObjects(@"p2",meta.paths[2]);
    XCTAssertEqual(2,meta.arguments.count);
    XCTAssertEqualObjects(@"arg1",meta.arguments[0]);
    XCTAssertEqualObjects(@"arg2",meta.arguments[1]);
    XCTAssertEqualObjects(@"dispatch-vc",meta.scheme);
    XCTAssertEqualObjects(@"host", meta.host);
    XCTAssertEqualObjects(@"vc", meta.name);
    XCTAssertEqualObjects(@"dispatch-vc://host/p1/p2?arg1&arg2", meta.description);
    XCTAssertEqualObjects(@"/p1/p2", meta.allPathsStr);
    XCTAssertEqualObjects(@"arg1&arg2", meta.allArgsStr);
    
    
    meta = [[URLDispatchMeta alloc] initWithUrl:@"/host/p1/p2?arg1=v1&arg2=v2" name:@"vc-2"];
    XCTAssertEqual(4,meta.paths.count);
    XCTAssertEqualObjects(@"/",meta.paths[0]);
    XCTAssertEqualObjects(@"host",meta.paths[1]);
    XCTAssertEqualObjects(@"p1",meta.paths[2]);
    XCTAssertEqualObjects(@"p2",meta.paths[3]);
    XCTAssertEqual(2,meta.arguments.count);
    XCTAssertEqualObjects(@"arg1",meta.arguments[0]);
    XCTAssertEqualObjects(@"arg2",meta.arguments[1]);
    XCTAssertEqualObjects(@"dispatch-vc",meta.scheme);
    XCTAssertEqualObjects(@"", meta.host);
    XCTAssertEqualObjects(@"vc-2", meta.name);
    XCTAssertEqualObjects(@"dispatch-vc:///host/p1/p2?arg1&arg2", meta.description);
    XCTAssertEqualObjects(@"/host/p1/p2", meta.allPathsStr);
    XCTAssertEqualObjects(@"arg1&arg2", meta.allArgsStr);
    
    meta = [[URLDispatchMeta alloc] initWithUrl:@"://host/p1/p2?arg1=v1&arg2=v2" name:@"vc-3"];
    XCTAssertEqual(3,meta.paths.count);
    XCTAssertEqualObjects(@"/",meta.paths[0]);
    XCTAssertEqualObjects(@"p1",meta.paths[1]);
    XCTAssertEqualObjects(@"p2",meta.paths[2]);
    XCTAssertEqual(2,meta.arguments.count);
    XCTAssertEqualObjects(@"arg1",meta.arguments[0]);
    XCTAssertEqualObjects(@"arg2",meta.arguments[1]);
    XCTAssertEqualObjects(@"dispatch-vc",meta.scheme);
    XCTAssertEqualObjects(@"host", meta.host);
    XCTAssertEqualObjects(@"vc-3", meta.name);
    XCTAssertEqualObjects(@"/p1/p2", meta.allPathsStr);
    XCTAssertEqualObjects(@"arg1&arg2", meta.allArgsStr);
    
    meta = [[URLDispatchMeta alloc] initWithUrl:@":///" name:@"vc-4"];
    XCTAssertEqual(1,meta.paths.count);
    XCTAssertEqualObjects(@"/",meta.paths[0]);
    XCTAssertEqual(0,meta.arguments.count);
    XCTAssertEqualObjects(@"dispatch-vc",meta.scheme);
    XCTAssertEqualObjects(@"", meta.host);
    XCTAssertEqualObjects(@"vc-4", meta.name);
    XCTAssertEqualObjects(@"dispatch-vc:///", meta.description);
    XCTAssertEqualObjects(@"/", meta.allPathsStr);
    XCTAssertEqualObjects(@"", meta.allArgsStr);
    
    meta = [[URLDispatchMeta alloc] initWithUrl:@"//" name:@"vc-5"];
    XCTAssertEqual(1,meta.paths.count);
    XCTAssertEqualObjects(@"/",meta.paths[0]);
    XCTAssertEqual(0,meta.arguments.count);
    XCTAssertEqualObjects(@"dispatch-vc",meta.scheme);
    XCTAssertEqualObjects(@"", meta.host);
    XCTAssertEqualObjects(@"vc-5", meta.name);
    XCTAssertEqualObjects(@"/", meta.allPathsStr);
    XCTAssertEqualObjects(@"", meta.allArgsStr);
    
    meta = [[URLDispatchMeta alloc] initWithUrl:@"/" name:@"vc-5"];
    XCTAssertEqual(1,meta.paths.count);
    XCTAssertEqualObjects(@"/",meta.paths[0]);
    XCTAssertEqual(0,meta.arguments.count);
    XCTAssertEqualObjects(@"dispatch-vc",meta.scheme);
    XCTAssertEqualObjects(@"", meta.host);
    XCTAssertEqualObjects(@"vc-5", meta.name);
    XCTAssertEqualObjects(@"/", meta.allPathsStr);
    XCTAssertEqualObjects(@"", meta.allArgsStr);
    
}

@end
