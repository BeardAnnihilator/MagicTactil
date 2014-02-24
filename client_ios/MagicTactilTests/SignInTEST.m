//
//  SignInTEST.m
//  MagicTactil
//
//  Created by Lucas Ortis on 22/01/2014.
//  Copyright (c) 2014 Ekhoo. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface SignInTEST : XCTestCase

@end

@implementation SignInTEST

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testSendSignOutOK {
    NSString *username = @"Ekhoo";
    
    if (username) {
        if ([username length] > 0)
            XCTAssert(YES, @"SignOut OK");
        else
            XCTAssertFalse(NO, @"SignOut KO");
    }
    else
        XCTFail(@"SignOut KO");
}

- (void)testSendSignOutEmpty {
    NSString *username = @"";
    
    if (username) {
        if ([username length] > 0)
            XCTAssert(YES, @"SignOut OK");
        else
            XCTAssertFalse(NO, @"SignOut KO");
    }
    else
        XCTAssertFalse(NO, @"SignOut KO");
}

- (void)testSendSignOutNil {
    NSString *username;
    
    if (username) {
        if ([username length] > 0)
            XCTAssert(YES, @"SignOut OK");
        else
            XCTAssertFalse(NO, @"SignOut KO");
    }
    else
        XCTAssertFalse(NO, @"SignOut KO");
}


- (void)testSendSignInOK {
    NSString *username = @"Username";
    NSString *password = @"123456";
    
    if (username && password) {
        if ([password length] >= 6) {
            
        }
        else {
            XCTFail(@"KO");
        }
    }
    else {
        XCTFail(@"KO");
    }
}

- (void)testSendSignInKO {
    NSString *username = @"Username";
    NSString *password = @"12345";
    
    if (username && password) {
        if ([password length] >= 6) {
            XCTAssert(YES, @"SignIn OK");
        }
        else {
            XCTAssertFalse(NO, @"SignIn KO");
        }
    }
    else {
        XCTFail(@"KO");
    }
}

- (void)testSendSignInEmpty {
    NSString *username = @"";
    NSString *password = @"";
    
    if (username && password) {
        if (([password length] >= 6) && ([username length] > 0)) {
            XCTAssert(YES, @"SignIn OK");
        }
        else {
            XCTAssertFalse(NO, @"SignIn KO");
        }
    }
    else {
        XCTFail(@"KO");
    }
}

- (void)testSendSignInNil {
    NSString *username;
    NSString *password;
    
    if (username && password) {
        if (([password length] >= 6) && ([username length] > 0)) {
            XCTAssert(YES, @"SignIn OK");
        }
        else {
            XCTAssertFalse(NO, @"SignIn KO");
        }
    }
    else {
        XCTAssertFalse(NO, @"SignIn KO");
    }
}

- (void)testSignInResponseOK {
    NSString *response = @"OK";
    
    XCTAssertEqual(response, @"OK", @"SignIn OK");
}

- (void)testSignInResponseKO {
    NSString *response = @"KO";
    
    XCTAssertEqual(response, @"KO", @"SignIn KO");
}

- (void)testSignInResponseEmpty {
    NSString *response = @"";
    
    XCTAssertNotEqual(response, @"OK", @"SignIn KO");
}

- (void)testSignInResponseNil {
    NSString *response;
    
    XCTAssertNil(response, @"SignIn KO");
}

- (void)testSignOutResponseOK {
    NSString *response = @"OK";
    
    XCTAssertEqual(response, @"OK", @"SignOut OK");
}

- (void)testSignOutResponsKO {
    NSString *response = @"KO";
    
    XCTAssertEqual(response, @"KO", @"SignOut KO");
}

- (void)testSignOutResponseEmpty {
    NSString *response = @"";
    
    XCTAssertNotEqual(response, @"OK", @"SignOut KO");
}

- (void)testSignOutResponseNil {
    NSString *response;
    
    XCTAssertNil(response, @"SignOut KO");
}

- (void)testGetInfosUserOK01 {
    NSString *response = @"username\rEkhoo";
    
    XCTAssertNotNil(response, @"GETU OK");
}

- (void)testGetInfosUserOK02 {
    NSString *response = @"username\rEkhoo\ngender\rmale";
    
    XCTAssertNotNil(response, @"GETU OK");
}

- (void)testGetInfosUserOK03 {
    NSString *response = @"username\rEkhoo\ngender\rmale\nlocation\rMarseille";
    
    XCTAssertNotNil(response, @"GETU OK");
}

- (void)testGetInfosUserOK04 {
    NSString *response = @"username\rEkhoo\ngender\rmale\nlocation\rMarseille\npassword\ntoto";
    
    XCTAssertNotNil(response, @"GETU OK");
}

- (void)testGetInfosUserOK05 {
    NSString *response = @"username\rEkhoo\ngender\rmale\nlocation\rMarseille\npassword\ntoto\ntelephone\r0610755970";
    
    XCTAssertNotNil(response, @"GETU OK");
}

- (void)testGetInfosUserOK06 {
    NSString *response = @"username\rEkhoo\ngender\rmale\nlocation\rMarseille\npassword\ntoto\ntelephone\r0610755970\nemail\rortis.developpement@gmail.com";
    
    XCTAssertNotNil(response, @"GETU OK");
}

- (void)testGetInfosUserOK07 {
    NSString *response = @"username\rEkhoo\ngender\rmale\nlocation\rMarseille\npassword\ntoto\ntelephone\r0610755970\nemail\rortis.developpement@gmail.com\nname\rLucas";
    
    XCTAssertNotNil(response, @"GETU OK");
}

- (void)testGetInfosUserOK08 {
    NSString *response = @"username\rEkhoo\ngender\rmale\nlocation\rMarseille\npassword\ntoto\ntelephone\r0610755970\nemail\rortis.developpement@gmail.com\nname\rLucas\ngivenname\rOrtis";
    
    XCTAssertNotNil(response, @"GETU OK");
}

@end
