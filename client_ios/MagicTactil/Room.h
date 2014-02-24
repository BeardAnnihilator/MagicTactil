//
//  Room.h
//  MagicTactil
//
//  Created by cedric on 13/06/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

/* Imports */
#import                                                             <UIKit/UIKit.h>
#import                                                             "AppDelegate.h"
#import                                                             "RoomObject.h"
#import                                                             "GameBoard.h"
#import                                                             "JDStatusBarNotification.h"

@interface Room : UIViewController
{
    AppDelegate                                                     *appDelegate;
    BOOL                                                            sendMsg;
    UIStoryboard                                                    *sbIpad;
    GameBoard                                                       *gameBoard;
}

/* Actions */
- (IBAction)clickReturn:(UIButton *)sender;
- (IBAction)clickSend:(UIButton *)sender;
- (IBAction)closeKeyboard:(UITextField *)sender;
- (IBAction)editingBegin:(UITextField *)sender;
- (IBAction)clickLaunchGame:(UIButton *)sender;

/* Properties */
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *messageArea;
@property (weak, nonatomic) IBOutlet UITextView *chatArea;
@property (weak, nonatomic) IBOutlet UILabel *labelRoom;
@property (weak, nonatomic) IBOutlet UIButton *buttonSend;
@property (weak, nonatomic) IBOutlet UIButton *buttonGame;

/* Methods */
- (void)initObjects;
- (void)translate;
- (void)sendLeaveRoom;
- (void)checkLeaveRoomResponse:(NSNotification *)notification;
- (void)sendBroadcastMessageRoom;
- (void)checkBroadcastMessageResponse:(NSNotification *)notification;
- (void)checkPlayerJoin:(NSNotification *)notification;
- (void)storeNewPlayer:(NSString*)request;
- (void)checkPlayerLeave:(NSNotification *)notification;
- (void)deletePlayer:(NSString*)request;
- (void)checkRoomDestroyed:(NSNotification *)notification;

@end
