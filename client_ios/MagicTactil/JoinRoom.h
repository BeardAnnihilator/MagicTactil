//
//  JoinRoom.h
//  MagicTactil
//
//  Created by cedric on 13/06/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

/* Imports */
#import                                                             <UIKit/UIKit.h>
#import                                                             "AppDelegate.h"
#import                                                             "RoomObject.h"
#import                                                             "Room.h"

@interface JoinRoom : UIViewController <UITableViewDelegate>
{
    AppDelegate                                                     *appDelegate;
    UIStoryboard                                                    *sbIpad;
    Room                                                            *room;
}

/* Actions */
- (IBAction)clickReturn:(UIButton *)sender;

/* Properties */
@property (weak, nonatomic) IBOutlet UITextField *textFieldNameRoom;
@property (weak, nonatomic) IBOutlet UITableView *tableViewIpad;

/* Methods */
- (void)initObjects;
- (void)sendGetAllRooms;
- (void)checkGetAllRoomsResponse:(NSNotification *)notification;
- (void)sendJoinRoom;
- (void)checkJoinRoomResponse:(NSNotification *)notification;
- (void)sendGetPlayers;
- (void)checkGetPlayersResponse:(NSNotification *)notification;
- (void)storeAllRooms:(NSString*)list;
- (void)storeAllPlayers:(NSString*)list;

@end
