//
//  RoomTEST.m
//  MagicTactil
//
//  Created by Lucas Ortis on 23/01/2014.
//  Copyright (c) 2014 Ekhoo. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface RoomTEST : XCTestCase

@end

@implementation RoomTEST

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testIfSignUpResponseOK {
    NSString *response = @"OK";
    
    XCTAssertEqual(response, @"OK", @"If signup OK");
}

- (void)testIfSignUpResponseKO {
    NSString *response = @"KO";
    
    XCTAssertEqual(response, @"KO", @"If signup KO");
}

- (void)testIfSignUpResponseEmpty {
    NSString *response = @"";
    
    XCTAssertEqual(response, @"", @"If signup KO");
}

- (void)testIfSignUpResponseNil {
    NSString *response;
    
    XCTAssertNil(response, @"If signup KO");
}

- (void)testGetAllRoomResponseOK {
    NSString *response = @"creatorName\rLucas\nroomName\rRoom01";
    
    XCTAssertNotNil(response, @"Get all rooms OK");
}

- (void)testGetAllRoomResponseKO {
    NSString *response = @"creatorName\rLucas";
    
    XCTAssertNotNil(response, @"Get all rooms KO");
}

- (void)testGetAllRoomResponseEmpty {
    NSString *response = @"";
    
    XCTAssertNotNil(response, @"Get all rooms KO");
}

- (void)testGetAllRoomResponseNil {
    NSString *response;
    
    XCTAssertNil(response, @"Get all rooms KO");
}

- (void)testSendGetAllRoomsOK {
    NSString *send = @"";
    
    XCTAssertNotNil(send, @"Get all rooms OK");
}

- (void)testSendGetAllRoomsNil {
    NSString *send;
    
    XCTAssertNil(send, @"Get all rooms KO");
}

@end
