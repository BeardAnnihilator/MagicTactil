//
//  BlackList.h
//  MagicTactil
//
//  Created by cedric on 10/06/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

/* imports */
#import                                                             <UIKit/UIKit.h>
#import                                                             "AppDelegate.h"
#import                                                             "FriendObject.h"

#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)
#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad

@interface BlackList : UIViewController <UITableViewDelegate>
{
    AppDelegate                                                     *app;
}

/* Actions */
- (IBAction)clickReturn:(UIButton *)sender;
- (IBAction)clickAddBL:(id)sender;
- (IBAction)closeKeyboard:(UITextField *)sender;
- (IBAction)deleteUserFromBlackList:(UIButton *)sender;

/* Properties */
@property (weak, nonatomic) IBOutlet UITextField *textFieldUserName;
@property (weak, nonatomic) IBOutlet UITableView *tableViewIphone;
@property (weak, nonatomic) IBOutlet UITableView *tableViewIpad;
@property (weak, nonatomic) IBOutlet UITextField *textFieldIpad;
@property (weak, nonatomic) IBOutlet UIButton *buttonDelete;
@property (weak, nonatomic) IBOutlet UIButton *buttonAdd;

/* Methods */
- (void)initObjects;
- (void)translate;
- (void)sendBlockFriend;
- (void)checkBlockFriendResponse:(NSNotification *)notification;
- (void)sendGetBlackListFriend;
- (void)checkGetBlackListFriendResponse:(NSNotification *)notification;
- (void)sendDeleteUserFromBlackListFriend;
- (void)checkDeleteUserFromBlackListFriendResponse:(NSNotification *)notification;
- (void)storeBlackList:(NSString*)list;
- (void)handle4;
- (void)handle3_5;

@end
