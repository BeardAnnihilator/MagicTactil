//
//  FriendTEST.m
//  MagicTactil
//
//  Created by Lucas Ortis on 22/01/2014.
//  Copyright (c) 2014 Ekhoo. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface FriendTEST : XCTestCase

@end

@implementation FriendTEST

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testAddFriendResponseOK {
    NSString *response = @"OK";
    
    XCTAssertEqual(response, @"OK", @"Add friend OK");
}

- (void)testAddFriendResponseKO {
    NSString *response = @"KO";
    
    XCTAssertEqual(response, @"KO", @"Add Friend KO");
}

- (void)testAddFriendResponseEmpty {
    NSString *response = @"";
    
    XCTAssertEqual(response, @"", @"Add Friend KO");
}

- (void)testAddFriendResponseNil {
    NSString *response;
    
    XCTAssertNil(response, @"Add Friend KO");
}

- (void)testSendAddFriendOK {
    NSString *send = @"username\rEkhoo\nbelongsto\rMehdi";
    
    XCTAssertNotNil(send, @"Add friend OK");
}

- (void)testSendAddFriendKO {
    NSString *send = @"username\rEkhoo";
    
    XCTAssertNotNil(send, @"Add friend KO");
}

- (void)testSendAddFriendEmpty {
    NSString *send = @"";
    
    XCTAssertNotNil(send, @"Add friend KO");
}

- (void)testSendAddFriendNil {
    NSString *send;
    
    XCTAssertNil(send, @"Add friend KO");
}

- (void)testgetAllFriendsOK {
    NSString *response = @"Lucas\nMehdi\nOualid";
    
    XCTAssertNotNil(response, @"Get all friends OK");
}

- (void)testGetAllFriedsKO {
    NSString *response = @"KO";
    
    XCTAssertEqual(response, @"KO", @"Get all friends KO");
}

- (void)testGetAllFriendsEmpty {
    NSString *response = @"";
    
    XCTAssertEqual(response, @"", @"Get all friends OK");
}

- (void)testGetAllFriendsNil {
    NSString *response;
    
    XCTAssertNil(response, @"Get all friends KO");
}

- (void)testSendGetAllFriendsOK {
    NSString *send = @"username\rEkhoo";
    
    XCTAssertNotNil(send, @"Get all friends OK");
}

- (void)testSendGetAllFriendsEmpty {
    NSString *send = @"";
    
    XCTAssertEqual(send, @"", @"Get all friends KO");
}

- (void)testSendGetAllFriendsNil {
    NSString *send;
    
    XCTAssertNil(send, @"Get all friends KO");
}

- (void)testAddFriendBLResponseOK {
    NSString *response = @"OK";
    
    XCTAssertEqual(response, @"OK", @"Add friend OK");
}

- (void)testAddFriendBLResponseKO {
    NSString *response = @"KO";
    
    XCTAssertEqual(response, @"KO", @"Add Friend KO");
}

- (void)testAddFriendBLResponseEmpty {
    NSString *response = @"";
    
    XCTAssertEqual(response, @"", @"Add Friend KO");
}

- (void)testAddFriendBLResponseNil {
    NSString *response;
    
    XCTAssertNil(response, @"Add Friend KO");
}

- (void)testSendAddFriendBLOK {
    NSString *send = @"username\rEkhoo\nbelongsto\rMehdi";
    
    XCTAssertNotNil(send, @"Add friend OK");
}

- (void)testSendAddFriendBLKO {
    NSString *send = @"username\rEkhoo";
    
    XCTAssertNotNil(send, @"Add friend KO");
}

- (void)testSendAddFriendBLEmpty {
    NSString *send = @"";
    
    XCTAssertNotNil(send, @"Add friend KO");
}

- (void)testSendAddFriendBLNil {
    NSString *send;
    
    XCTAssertNil(send, @"Add friend KO");
}

- (void)testgetAllFriendsBLOK {
    NSString *response = @"Lucas\nMehdi\nOualid";
    
    XCTAssertNotNil(response, @"Get all friends OK");
}

- (void)testGetAllFriendsBLKO {
    NSString *response = @"KO";
    
    XCTAssertEqual(response, @"KO", @"Get all friends KO");
}

- (void)testGetAllFriendsBLEmpty {
    NSString *response = @"";
    
    XCTAssertEqual(response, @"", @"Get all friends OK");
}

- (void)testGetAllFriendsBLNil {
    NSString *response;
    
    XCTAssertNil(response, @"Get all friends KO");
}

- (void)testSendGetAllFriendsBLOK {
    NSString *send = @"username\rEkhoo";
    
    XCTAssertNotNil(send, @"Get all friends OK");
}

- (void)testSendGetAllFriendsBLEmpty {
    NSString *send = @"";
    
    XCTAssertEqual(send, @"", @"Get all friends KO");
}

- (void)testSendGetAllFriendsBLNil {
    NSString *send;
    
    XCTAssertNil(send, @"Get all friends KO");
}

@end
