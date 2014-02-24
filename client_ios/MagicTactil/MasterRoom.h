//
//  MasterRoom.h
//  MagicTactil
//
//  Created by cedric on 20/08/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

/* Imports */
#import                                                             <UIKit/UIKit.h>
#import                                                             "AppDelegate.h"
#import                                                             "RoomObject.h"
#import                                                             "GameBoard.h"
#import                                                             "JDStatusBarNotification.h"

@interface MasterRoom : UIViewController
{
    AppDelegate                                                     *appDelegate;
    UIStoryboard                                                    *sbIpad;
    GameBoard                                                       *gameBoard;
    BOOL                                                            sendMsg;
}

/* Actions */
- (IBAction)clickReturn:(UIButton *)sender;
- (IBAction)deleteRoom:(UIButton *)sender;
- (IBAction)clickLaunchGame:(UIButton *)sender;
- (IBAction)clickSendMessage:(UIButton *)sender;
- (IBAction)closeKeyboard:(UITextField *)sender;
- (IBAction)editingBegin:(UITextField *)sender;

/* Properties */
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextView *chatArea;
@property (weak, nonatomic) IBOutlet UITextField *messageArea;
@property (weak, nonatomic) IBOutlet UIButton *buttonSend;
@property (weak, nonatomic) IBOutlet UIButton *buttonGame;
@property (weak, nonatomic) IBOutlet UIButton *buttonDelete;

/* Methods */
- (void)initObjects;
- (void)translate;
- (void)sendLeaveRoom;
- (void)checkLeaveRoomResponse:(NSNotification *)notification;
- (void)sendDeleteRoom;
- (void)checkDeleteRoomResponse:(NSNotification *)notification;
- (void)sendBroadcastMessageRoom;
- (void)checkBroadcastMessageResponse:(NSNotification *)notification;
- (void)checkPlayerJoin:(NSNotification *)notification;
- (void)storeNewPlayer:(NSString*)request;
- (void)checkPlayerLeave:(NSNotification *)notification;
- (void)deletePlayer:(NSString*)request;

@end
