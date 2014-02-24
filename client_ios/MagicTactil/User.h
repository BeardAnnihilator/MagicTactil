//
//  User.h
//  MagicTactil
//
//  Created by Ekhoo on 13/02/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
{
    
}
/* IBOutlets */
@property (strong, nonatomic) NSString                       *firstName;
@property (strong, nonatomic) NSString                       *lastName;
@property (strong, nonatomic) NSString                       *userName;
@property (strong, nonatomic) NSString                       *email;
@property (strong, nonatomic) NSString                       *gender;
@property (strong, nonatomic) NSString                       *phone;
@property (strong, nonatomic) NSString                       *location;
@property (strong, nonatomic) NSString                       *birthday;
@property (strong, nonatomic) NSString                       *password;

@property (strong, nonatomic) NSString                       *facebookId;

@property (strong, nonatomic) NSString                       *auth_firstName;
@property (strong, nonatomic) NSString                       *auth_lastName;
@property (strong, nonatomic) NSString                       *auth_userName;
@property (strong, nonatomic) NSString                       *auth_email;
@property (strong, nonatomic) NSString                       *auth_gender;
@property (strong, nonatomic) NSString                       *auth_phone;
@property (strong, nonatomic) NSString                       *auth_location;
@property (strong, nonatomic) NSString                       *auth_birthday;
@property (strong, nonatomic) NSString                       *auth_password;

/* IBActions */
/* Methodes Classiques */

@end
