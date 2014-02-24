//
//  DetailFriend.h
//  MagicTactil
//
//  Created by cedric on 10/06/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

/* imports */
#import                                                                 <UIKit/UIKit.h>
#import                                                                 "AppDelegate.h"
#import                                                                 "FriendObject.h"

#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad

@interface DetailFriend : UIViewController
{
    AppDelegate                                                         *app;
}

/* Actions */
- (IBAction)clickReturn:(UIButton *)sender;
- (IBAction)clickDelete:(id)sender;
- (IBAction)clickSendMessage:(UIButton *)sender;
- (IBAction)closeKeyboard:(id)sender;
- (IBAction)beginEditing:(UITextField *)sender;

/* Properties */
@property (weak, nonatomic) IBOutlet UILabel *pseudo;
@property (weak, nonatomic) IBOutlet UILabel *pseudoIpad;
@property (weak, nonatomic) IBOutlet UITextView *chatArea;
@property (weak, nonatomic) IBOutlet UITextField *messageArea;
@property (weak, nonatomic) IBOutlet UIButton *buttonDelete;
@property (weak, nonatomic) IBOutlet UIButton *buttonSend;

/* Methods */
- (void)initObjects;
- (void)translate;
- (void)sendDeleteFriend;
- (void)checkDeleteFriendResponse:(NSNotification *)notification;
- (void)sendPrivateMessageRoom;
- (void)checkReceiveMessage:(NSNotification *)notification;

@end
