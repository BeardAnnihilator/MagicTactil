//
//  SignUpTEST.m
//  MagicTactil
//
//  Created by Lucas Ortis on 22/01/2014.
//  Copyright (c) 2014 Ekhoo. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface SignUpTEST : XCTestCase

@end

@implementation SignUpTEST

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testSignUpResponseOK {
    NSString *response = @"OK";
    
    XCTAssertEqual(response, @"OK", @"SignUp OK");
}

- (void)testSignUpResponseKO {
    NSString *response = @"KO";
    
    XCTAssertEqual(response, @"KO", @"SignUp KO");
}

- (void)testSignUpResponseEmpty {
    NSString *response = @"";
    
    XCTAssertNotEqual(response, @"OK", @"SignUp KO");
}

- (void)testSignUpResponseNil {
    NSString *response;
    
    XCTAssertNil(response, @"SignUp KO");
}

- (void)testSendSignUpOK01 {
    NSString *send = @"username\rEkhoo\nemail\rortis.developpement\rpassword\rtoto";
    
    XCTAssertNotNil(send, @"SignUp OK");
}

- (void)testSendSignUpOK02 {
    NSString *send = @"username\rEkhoo\nemail\rortis.developpement\rpassword\rtoto\ngender\rmale";
    
    XCTAssertNotNil(send, @"SignUp OK");
}

- (void)testSendSignUpOK03 {
    NSString *send = @"username\rEkhoo\nemail\rortis.developpement\rpassword\rtoto\ngender\rmale\ntelephone\r0610755970";
    
    XCTAssertNotNil(send, @"SignUp OK");
}

- (void)testSendSignUpOK04 {
    NSString *send = @"username\rEkhoo\nemail\rortis.developpement\rpassword\rtoto\ngender\rmale\ntelephone\r0610755970\nlocation\rMarseille";
    
    XCTAssertNotNil(send, @"SignUp OK");
}

- (void)testSendSignUpOK05 {
    NSString *send = @"username\rEkhoo\nemail\rortis.developpement\rpassword\rtoto\ngender\rmale\ntelephone\r0610755970\nlocation\rMarseille\nbirthday\r28/03/1992";
    
    XCTAssertNotNil(send, @"SignUp OK");
}

- (void)testSendSignUpOK06 {
    NSString *send = @"username\rEkhoo\nemail\rortis.developpement\rpassword\rtoto\ngender\rmale\ntelephone\r0610755970\nlocation\rMarseille\nbirthday\r28/03/1992\ngivenname\rOrtis";
    
    XCTAssertNotNil(send, @"SignUp OK");
}

- (void)testSendSignUpOK07 {
    NSString *send = @"username\rEkhoo\nemail\rortis.developpement\rpassword\rtoto\ngender\rmale\ntelephone\r0610755970\nlocation\rMarseille\nbirthday\r28/03/1992\ngivenname\rLucas\nname\rLucas";
    
    XCTAssertNotNil(send, @"SignUp OK");
}

- (void)testSendSignUpKO01 {
    NSString *send = @"username\rEkhoo\nemail\rortis.developpement";
    
    XCTAssertNotNil(send, @"SignUp KO");
}

- (void)testSendSignUpKO02 {
    NSString *send = @"username\rEkhoo";
    
    XCTAssertNotNil(send, @"SignUp KO");
}

- (void)testSendSignUpEmpty {
    NSString *send = @"";
    
    XCTAssertEqual(send, @"", @"SignOut KO");
}

- (void)testSendSignUpNil {
    NSString *send;
    
    XCTAssertNil(send, @"SignOut KO");
}

@end
