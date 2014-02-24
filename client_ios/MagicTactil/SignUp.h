//
//  SignUp.h
//  MagicTactil
//
//  Created by Ekhoo on 12/02/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Packet.h"

#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)

@interface SignUp : UIViewController
{
    AppDelegate                         *appDelegate;
    NSTimer                             *facebookTimer;
}

/* IBOutlets */
@property (weak, nonatomic) IBOutlet UIImageView *checkIphone_01;
@property (weak, nonatomic) IBOutlet UIImageView *checkIphone_02;
@property (weak, nonatomic) IBOutlet UIImageView *checkIphone_03;
@property (weak, nonatomic) IBOutlet UIImageView *checkIphone_04;
@property (weak, nonatomic) IBOutlet UIImageView *checkIphone_05;
@property (weak, nonatomic) IBOutlet UIImageView *checkIpad_01;
@property (weak, nonatomic) IBOutlet UIImageView *checkIpad_02;
@property (weak, nonatomic) IBOutlet UIImageView *checkIpad_03;
@property (weak, nonatomic) IBOutlet UIImageView *checkIpad_04;
@property (weak, nonatomic) IBOutlet UIImageView *checkIpad_05;

@property (weak, nonatomic) IBOutlet UITextField *firstNameIphone;
@property (weak, nonatomic) IBOutlet UITextField *lastNameIphone;
@property (weak, nonatomic) IBOutlet UITextField *userNameIphone;
@property (weak, nonatomic) IBOutlet UITextField *passwordIphone;
@property (weak, nonatomic) IBOutlet UITextField *emailIphone;

@property (weak, nonatomic) IBOutlet UITextField *firstNameIpad;
@property (weak, nonatomic) IBOutlet UITextField *lastNameIpad;
@property (weak, nonatomic) IBOutlet UITextField *userNameIpad;
@property (weak, nonatomic) IBOutlet UITextField *passwordIpad;
@property (weak, nonatomic) IBOutlet UITextField *emailIpad;

@property (weak, nonatomic) IBOutlet UILabel *startPseudo;
@property (weak, nonatomic) IBOutlet UILabel *starMdp;
@property (weak, nonatomic) IBOutlet UILabel *startEmail;
@property (weak, nonatomic) IBOutlet UIButton *buttonFb;
@property (weak, nonatomic) IBOutlet UIButton *buttonSignUp;
@property (weak, nonatomic) IBOutlet UILabel *navBarLabel;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UIButton *buttonBack;
@property (weak, nonatomic) IBOutlet UILabel *labelInscription;
@property (weak, nonatomic) IBOutlet UIButton *bouttonInscription;

/* IBActions */
- (IBAction)clickReturnIphone:(id)sender;
- (IBAction)clickFacebookConnectIphone:(id)sender;
- (IBAction)closeKeyboardIphone:(id)sender;
- (IBAction)checkTextFieldIphone:(id)sender;
- (IBAction)clickSignUpIphone:(id)sender;
- (IBAction)clickReturnIpad:(id)sender;
- (IBAction)clickSignUpIpad:(UIButton *)sender;

/* Methodes Classiques */
- (void)initObjects;
- (void)translate;
- (void)showAlertView:(NSString*)title withMessage:(NSString*)message;
- (void)checkFacebookSession;
- (void)fillFacebookInformationsIphone;
- (BOOL)checkSignUpTextFieldIphone;
- (BOOL)checkSignUpTextFieldIpad;
- (void)sendSignUpRequestIphone;
- (void)checkSignUpResponse:(NSNotification*)notification;
- (void)updaUserInformations;
- (void)handle4;
- (void)handle3_5;
- (void)sendSignInRequest;
- (void)checkSignInResponse:(NSNotification*)notification;
- (BOOL)checkFields;

@end
