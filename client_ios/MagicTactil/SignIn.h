//
//  SignIn.h
//  MagicTactil
//
//  Created by Ekhoo on 12/02/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface SignIn : UIViewController
{
    AppDelegate                     *appDelegate;
    NSTimer                         *facebookTimer;
}
/* IBOutlets */
@property (weak, nonatomic) IBOutlet UITextField *userNameIphone;
@property (weak, nonatomic) IBOutlet UITextField *passwordIphone;
@property (weak, nonatomic) IBOutlet UITextField *userNameIpad;
@property (weak, nonatomic) IBOutlet UITextField *passwordIpad;

@property (weak, nonatomic) IBOutlet UIImageView *checkIphone_01;
@property (weak, nonatomic) IBOutlet UIImageView *checkIphone_02;
@property (weak, nonatomic) IBOutlet UIImageView *checkIpad_01;
@property (weak, nonatomic) IBOutlet UIImageView *checkIpad_02;
@property (weak, nonatomic) IBOutlet UIButton *bouttonConnexion;
@property (weak, nonatomic) IBOutlet UIButton *bouttonDeconnexion;


/* IBActions */
- (IBAction)clickReturnIphone:(id)sender;
- (IBAction)clickFacebookConnectIphone:(id)sender;
- (IBAction)clickSignInIphone:(id)sender;
- (IBAction)closeKeyboardIphone:(id)sender;
- (IBAction)checktextFieldIphone:(id)sender;
- (IBAction)clickReturnIpad:(id)sender;
- (IBAction)clickSignOutIphone:(id)sender;

/* Methodes Classiques */
- (void)initObjects;
- (void)translate;
- (void)showAlertView:(NSString*)title withMessage:(NSString*)message;
- (void)checkFacebookSession;
- (BOOL)checkSignInTextFieldIphone;
- (void)sendSignInRequest;
- (void)sendSignOutRequest;
- (void)sendGetInfoUserRequest;
- (void)checkSignInResponse:(NSNotification*)notification;
- (void)checkSignOutResponse:(NSNotification*)notification;
- (void)checkGetInfoUserResponse:(NSNotification*)notification;
- (void)storeUserInformations:(NSString*)response;
- (void)updateUserInformations;
- (BOOL)checkFields;
- (IBAction)clickSignInIpad:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *labelConnexion;

@end
