//
//  AddEvent.h
//  MagicTactil
//
//  Created by cedric on 16/04/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

/* Imports */
#import                                     <UIKit/UIKit.h>
#import                                     "AppDelegate.h"

#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)
#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad

@interface AddEvent :                       UIViewController
{
    AppDelegate                              *app;
}

/* Actions */
- (IBAction)clickReturn:(id)sender;
- (IBAction)clickAddIphone:(id)sender;
- (IBAction)closeKeyboard:(id)sender;
- (IBAction)clickDeleteIphone:(UIButton *)sender;
- (IBAction)clickSignIn:(UIButton *)sender;
- (IBAction)clickSignOut:(UIButton *)sender;

/* Properties */
@property (weak, nonatomic) IBOutlet UITextField *nameIphone;
@property (weak, nonatomic) IBOutlet UITextView *descriptionIphone;
@property (weak, nonatomic) IBOutlet UITextField *dateIphone;
@property (weak, nonatomic) IBOutlet UITextField *adressIphone;
@property (weak, nonatomic) IBOutlet UIButton *buttonAddIphone;
@property (weak, nonatomic) IBOutlet UIButton *buttonDeleteIphone;
@property (weak, nonatomic) IBOutlet UIButton *buttonSigninIphone;
@property (weak, nonatomic) IBOutlet UIButton *buttonSignOutIphone;
@property (weak, nonatomic) IBOutlet UILabel *navBarLabel;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UIButton *buttonBack;
@property (weak, nonatomic) IBOutlet UIButton *titleName;
@property (weak, nonatomic) IBOutlet UIButton *titleDescription;
@property (weak, nonatomic) IBOutlet UIButton *titleDate;
@property (weak, nonatomic) IBOutlet UIButton *titleAddress;

@property (weak, nonatomic) IBOutlet UITextField *nameIpad;
@property (weak, nonatomic) IBOutlet UITextView *descriptionIpad;
@property (weak, nonatomic) IBOutlet UITextField *dateIpad;
@property (weak, nonatomic) IBOutlet UITextField *addressipad;
@property (weak, nonatomic) IBOutlet UIButton *buttonAddIpad;
@property (weak, nonatomic) IBOutlet UIButton *buttonDeleteIpad;
@property (weak, nonatomic) IBOutlet UIButton *buttonSignUpIpad;
@property (weak, nonatomic) IBOutlet UIButton *buttonSignOutIpad;
@property (weak, nonatomic) IBOutlet UILabel *labelCreate;
@property (weak, nonatomic) IBOutlet UIButton *labelName;
@property (weak, nonatomic) IBOutlet UIButton *labelDescription;
@property (weak, nonatomic) IBOutlet UIButton *labelDate;
@property (weak, nonatomic) IBOutlet UIButton *labelAddress;


/* Méthodes */
- (void)initObjects;
- (void)translate;
- (void)checkCreateEvent;
- (void)checkAddEventResponse:(NSNotification*)notification;
- (void)sendAddEventRequest;
- (void)checkEditEventResponse:(NSNotification*)notification;
- (void)sendEditEventRequest;
- (void)checkDeleteEventResponse:(NSNotification*)notification;
- (void)sendDeleteEventRequest;
- (void)checkSignInEventResponse:(NSNotification*)notification;
- (void)sendSignInEventRequest;
- (void)checkSignOutEventResponse:(NSNotification*)notification;
- (void)sendSignOutEventRequest;
- (void)handle4;
- (void)handle3_5;
- (BOOL)checkFields;

@end
