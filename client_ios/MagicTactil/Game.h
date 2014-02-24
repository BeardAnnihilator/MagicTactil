//
//  Game.h
//  MagicTactil
//
//  Created by Ekhoo on 12/02/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

/* Imports */
#import                                                             <UIKit/UIKit.h>
#import                                                             "CreateRoom.h"
#import                                                             "JoinRoom.h"
#import                                                             "AppDelegate.h"
#import                                                             "Deck.h"

@interface Game : UIViewController
{
    UIStoryboard                                                    *sbIpad;
    CreateRoom                                                      *createRoomIpad;
    JoinRoom                                                        *joinRoomIpad;
    AppDelegate                                                     *appDelegate;
    Deck                                                            *deck;
}

/* Actions */
- (IBAction)clickCreateRoom:(UIButton *)sender;
- (IBAction)clickJoinRoom:(UIButton *)sender;
- (IBAction)clickDeck:(UIButton *)sender;

/* Properties */
@property (weak, nonatomic) IBOutlet UILabel *labelGame;
@property (weak, nonatomic) IBOutlet UIButton *buttonCreateGame;
@property (weak, nonatomic) IBOutlet UIButton *buttonJoinGame;
@property (weak, nonatomic) IBOutlet UIButton *buttonDeck;

/* Methods */
- (void)initObjects;
- (void)translate;

@end
