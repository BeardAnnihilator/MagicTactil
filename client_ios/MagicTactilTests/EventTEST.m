//
//  EventTEST.m
//  MagicTactil
//
//  Created by Lucas Ortis on 22/01/2014.
//  Copyright (c) 2014 Ekhoo. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface EventTEST : XCTestCase

@end

@implementation EventTEST

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testAddEventResponseOK {
    NSString *response = @"OK";
    
    XCTAssertEqual(response, @"OK", @"Add event OK");
}

- (void)testAddEventResponseKO {
    NSString *response = @"KO";
    
    XCTAssertEqual(@"KO", response, @"Add event KO");
}

- (void)testAddEventResponseEmpty {
    NSString *response = @"";
    
    XCTAssertNotNil(response, @"Add event KO");
}

- (void)testAddEventResponseNil {
    NSString *response;
    
    XCTAssertNil(response, @"Add event KO");
}

- (void)testSendAddEventOK {
    NSString *send = @"creatorName\rLucas\ntitle\nEvent01\ndescription\rEvenement01\ndate\nlocation\rMarseille";
    
    XCTAssertNotNil(send, @"Add event OK");
}

- (void)testSendAddEventKO01 {
    NSString *send = @"creatorName\rLucas\ntitle\nEvent01\ndescription\rEvenement01\ndate";
    
    XCTAssertNotNil(send, @"Add event KO");
}

- (void)testSendAddEventKO02 {
    NSString *send = @"creatorName\rLucas\ntitle\nEvent01\ndescription\rEvenement01";
    
    XCTAssertNotNil(send, @"Add event KO");
}

- (void)testSendAddEventKO03 {
    NSString *send = @"creatorName\rLucas\ntitle\nEvent01";
    
    XCTAssertNotNil(send, @"Add event KO");
}

- (void)testSendAddEventKO04 {
    NSString *send = @"creatorName\rLucas";
    
    XCTAssertNotNil(send, @"Add event KO");
}

- (void)testSendAddEventEmpty {
    NSString *send = @"";
    
    XCTAssertNotNil(send, @"Add event KO");
}

- (void)testSendAddEventNil {
    NSString *send;
    
    XCTAssertNil(send, @"Add event KO");
}

- (void)testSendGetEventOK {
    NSString *send = @"nameEvent\rEvent01";
    
    XCTAssertNotNil(send, @"Send get all events OK");
}

- (void)testSendGetEventEmpty {
    NSString *send = @"";
    
    XCTAssertNotNil(send, @"Send get event KO");
}

- (void)testSendGetEventNil {
    NSString *send;
    
    XCTAssertNil(send, @"Send get event KO");
}

- (void)testSendGetAllEventOK {
    NSString *send = @"";
    
    XCTAssertNotNil(send, @"Send get all events OK");
}

- (void)testSendGetAllEventsNil {
    NSString *send;
    
    XCTAssertNil(send, @"Send get all events OK");
}

- (void)testGetAllEventsResponseOK {
    NSString *response = @"Event01\nEvent02\nEvent03";
    
    XCTAssertNotNil(response, @"Get all events OK");
}

- (void)testGetAllEventsResponseEmpty {
    NSString *response = @"";
    
    XCTAssertNotNil(response, @"Get all events OK");
}

- (void)testGetAllEventsResponseNil {
    NSString *response;
    
    XCTAssertNil(response, @"Get all events KO");
}

- (void)testGetEventOK {
    NSString *response = @"creatorName\rLucas\ntitle\rEvent01\ndescription\révènement\ndate\r28/03/1992/nlocation\rMarseille";
    
    XCTAssertNotNil(response, @"Get event OK");
}

- (void)testGetEventEmpty {
    NSString *response = @"";
    
    XCTAssertNotNil(response, @"Get event OK");
}

- (void)testGetEventNil {
    NSString *response;
    
    XCTAssertNil(response, @"Get event OK");
}

@end
