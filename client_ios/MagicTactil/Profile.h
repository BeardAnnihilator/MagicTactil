//
//  Profile.h
//  MagicTactil
//
//  Created by Ekhoo on 12/02/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)
#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad

@interface Profile : UIViewController
{
    AppDelegate                         *app;
}
/* IBOutlets */
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *pseudo;
@property (weak, nonatomic) IBOutlet UITextField *prenom;
@property (weak, nonatomic) IBOutlet UITextField *nom;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *telephone;
@property (weak, nonatomic) IBOutlet UITextField *adresse;
@property (weak, nonatomic) IBOutlet UITextField *mdp;

@property (weak, nonatomic) IBOutlet UITextField *userNameIpad;
@property (weak, nonatomic) IBOutlet UITextField *firstNameIpad;
@property (weak, nonatomic) IBOutlet UITextField *lastNameIpad;
@property (weak, nonatomic) IBOutlet UITextField *emailIpad;
@property (weak, nonatomic) IBOutlet UITextField *phoneIpad;
@property (weak, nonatomic) IBOutlet UITextField *addressIPad;
@property (weak, nonatomic) IBOutlet UITextField *passwordIpad;


@property (weak, nonatomic) IBOutlet UILabel *navBarlabel;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelProfile;
@property (weak, nonatomic) IBOutlet UIButton *buttonUpdate;

/* IBActions */
- (IBAction)closeKeyboardIphone:(id)sender;
- (IBAction)clickUpdate:(id)sender;


/* Methodes Classiques */
- (void)initObjects;
- (void)translate;
- (void)updateInformations;
- (void)sendSetInfoUserRequest;
- (void)checkSetInfoUserResponse:(NSNotification*)notification;
- (void)handle3_5;
- (void)handle4;

@end
