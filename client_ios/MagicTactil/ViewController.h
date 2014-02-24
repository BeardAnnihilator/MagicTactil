//
//  ViewController.h
//  MagicTactil
//
//  Created by Ekhoo on 12/02/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignIn.h"
#import "SignUp.h"
#import "AppDelegate.h"

#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)

@interface ViewController : UIViewController
{
    AppDelegate                             *appDelegate;
    UIStoryboard                            *sbIphone;
    UIStoryboard                            *sbIpad;
    SignIn                                  *signInIphone;
    SignUp                                  *signUpIphone;
    SignIn                                  *signInIpad;
    SignUp                                  *signUpIpad;
}
/* IBOutlets */
@property (weak, nonatomic) IBOutlet UIButton *buttonStateIphone;
@property (weak, nonatomic) IBOutlet UILabel *navBarLabel;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UIButton *buttonSignUp;
@property (weak, nonatomic) IBOutlet UIButton *buttonSignIn;
@property (weak, nonatomic) IBOutlet UIButton *labelState;
@property (weak, nonatomic) IBOutlet UIButton *buttonStateIpad;
@property (weak, nonatomic) IBOutlet UILabel *labelHome;
@property (weak, nonatomic) IBOutlet UIButton *bouttonInscription;
@property (weak, nonatomic) IBOutlet UIButton *bouttonConnexion;




/* IBActions */
- (IBAction)clickSignUpIphone:(id)sender;
- (IBAction)clickSignInIphone:(id)sender;
- (IBAction)clickSignUpIpad:(id)sender;
- (IBAction)clickSignInIpad:(id)sender;

/* Methodes Classique */
- (void)setTabBarItemColor;
- (void)initObjects;
- (void)updateLabelAuthentificationIphone;
- (void)handle3_5;
- (void)handle4;
- (void)translate;

@end
