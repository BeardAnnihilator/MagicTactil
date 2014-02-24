//
//  Friends.h
//  MagicTactil
//
//  Created by cedric on 10/06/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

/* Import */
#import                                                             <UIKit/UIKit.h>
#import                                                             "AppDelegate.h"
#import                                                             "FriendObject.h"
#import                                                             "DetailFriend.h"

#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)
#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad

@interface Friends : UIViewController <UITableViewDelegate>
{
    AppDelegate                                                     *app;
    
    UIStoryboard                                                    *sbIphone;
    UIStoryboard                                                    *sbIpad;
    
    DetailFriend                                                    *detailFriend;
    DetailFriend                                                    *detailFriendIpad;
}

/* Actions */
- (IBAction)clickReturn:(UIButton *)sender;
- (IBAction)clickAddFriend:(id)sender;
- (IBAction)closeKeyboard:(UITextField *)sender;

/* Properties */
@property (weak, nonatomic) IBOutlet UITableView *tableViewIphone;
@property (weak, nonatomic) IBOutlet UITextField *textFieldUserName;
@property (weak, nonatomic) IBOutlet UITableView *tableViewIpad;
@property (weak, nonatomic) IBOutlet UITextField *textFieldIpad;
@property (weak, nonatomic) IBOutlet UIButton *buttonAdd;

/* Methods */
- (void)initObjects;
- (void)translate;
- (void)sendGetAllFriends;
- (void)checkGetAllFriendsResponse:(NSNotification *)notification;
- (void)sendAddFriends;
- (void)checkAddFriendsResponse:(NSNotification *)notification;
- (void)storeAllFriends:(NSString*)list;
- (void)handle4;
- (void)handle3_5;
- (BOOL)checkFields;

@end
