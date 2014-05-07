//
//  NEEDSTests.m
//  NEEDSTests
//
//  Created by JackYu on 5/2/14.
//  Copyright (c) 2014 Jackyu. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface NEEDSTests : XCTestCase

@end

@implementation NEEDSTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//- (void)testExample
//{
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
//}

- (void)testTrue{
    XCTAssert(1, @"can not be zero.");
}

@end
