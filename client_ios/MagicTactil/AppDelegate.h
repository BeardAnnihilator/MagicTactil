//
//  AppDelegate.h
//  MagicTactil
//
//  Created by Ekhoo on 12/02/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "User.h"
#import "Network.h"
#import "Packet.h"
#import "EventObject.h"
#import "FriendObject.h"
#import "JDStatusBarNotification.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
}
/* IBOutlets */
@property (strong, nonatomic) UIWindow                      *window;
@property (strong, nonatomic) User                          *user;
@property (strong, nonatomic) Network                       *network;
@property (strong, nonatomic) NSMutableArray                *listEvents;
@property (strong, nonatomic) NSMutableArray                *listFriends;
@property (strong, nonatomic) NSMutableArray                *blackList;
@property (strong, nonatomic) NSMutableArray                *listRoom;
@property (strong, nonatomic) NSMutableArray                *listPlayers;
@property (strong, nonatomic) NSMutableArray                *listDecks;
@property (strong, nonatomic) NSArray                       *listCards;
@property (strong, nonatomic) EventObject                   *currentEvent;
@property (readwrite, nonatomic) int                        selectedEvent;
@property (readwrite, nonatomic) int                        selectedFriend;
@property (readwrite, nonatomic) int                        selectedFriendBL;
@property (readwrite, nonatomic) int                        selectedRoom;
@property (readwrite, nonatomic) int                        selectedDeck;
@property (readwrite, nonatomic) int                        selectedCard;
@property (readwrite, nonatomic) int                        addEditCard;
@property (readwrite, nonatomic) BOOL                       createEvent;
@property (readwrite, nonatomic) BOOL                       isSignup;
@property (readwrite, nonatomic) BOOL                       isMaster;
@property (readwrite, nonatomic) BOOL                       cardsAreLoaded;

/* IBActions */

/* Methodes Classiques */
- (void)openFacebookSession;
- (void)closeFacebookSession;
- (void)showAlertView:(NSString*)title withMessage:(NSString*)message;
- (void)initObjects;
- (void)initUser;
- (void)checkPrivateMessageResponse:(NSNotification *)notification;
- (void)handleMessage:(NSString*)username withMessage:(NSString*)message;
- (void)initNotificationsStyle;

@end
