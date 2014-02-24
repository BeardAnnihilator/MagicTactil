//
//  Social.h
//  MagicTactil
//
//  Created by Ekhoo on 12/02/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

/* Imports */
#import                                 <UIKit/UIKit.h>
#import                                 "Events.h"
#import                                 "Friends.h"
#import                                 "BlackList.h"

#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)
#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad

@interface Social :                     UIViewController
{
    UIStoryboard                        *sb;
    UIStoryboard                        *sbIpad;
    Events                              *eventIphone;
    Friends                             *friends;
    BlackList                           *bl;
    Events                              *eventIpad;
    Friends                             *friendsIpad;
    BlackList                           *blIpad;
}

/* Actions */
- (IBAction)clickEventsIphone:(id)sender;
- (IBAction)clickFriendsIphone:(UIButton *)sender;
- (IBAction)clickBL:(UIButton *)sender;


/* Properties */
@property (weak, nonatomic) IBOutlet UILabel *navBarLabel;
@property (weak, nonatomic) IBOutlet UIButton *buttonEvent;
@property (weak, nonatomic) IBOutlet UIButton *buttonFriend;
@property (weak, nonatomic) IBOutlet UIButton *buttonBL;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelSocial;
@property (weak, nonatomic) IBOutlet UIButton *bouttonEvenement;
@property (weak, nonatomic) IBOutlet UIButton *bouttonAmis;
@property (weak, nonatomic) IBOutlet UIButton *bouttonBL;


/* Méthodes */
- (void)initObjects;
- (void)translate;
- (void)handle3_5;
- (void)handle4;

@end
