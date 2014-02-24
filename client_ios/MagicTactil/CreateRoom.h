//
//  CreateRoom.h
//  MagicTactil
//
//  Created by cedric on 13/06/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

/* Imports */
#import                                                             <UIKit/UIKit.h>
#import                                                             "AppDelegate.h"
#import                                                             "RoomObject.h"
#import                                                             "MasterRoom.h"

@interface CreateRoom : UIViewController
{
    UIStoryboard                                                    *sbIpad;
    AppDelegate                                                     *appDelegate;
    MasterRoom                                                            *room;
}

/* Actions */
- (IBAction)clickReturn:(id)sender;
- (IBAction)closeKeyboard:(id)sender;
- (IBAction)clickCreateRoom:(id)sender;


/* Properties */
@property (weak, nonatomic) IBOutlet UITextField *roomName;
@property (weak, nonatomic) IBOutlet UISegmentedControl *format;
@property (weak, nonatomic) IBOutlet UISegmentedControl *state;
@property (weak, nonatomic) IBOutlet UILabel *labelCreate;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelFormat;
@property (weak, nonatomic) IBOutlet UILabel *labelType;
@property (weak, nonatomic) IBOutlet UIButton *buttonCreate;

/* Methods */
- (void)initObjects;
- (void)translate;
- (void)sendAddRoom;
- (void)checkAddRoomResponse:(NSNotification *)notification;
- (void)sendGetPlayers;
- (void)checkGetPlayersResponse:(NSNotification *)notification;
- (void)storeAllPlayers:(NSString *)list;

@end
