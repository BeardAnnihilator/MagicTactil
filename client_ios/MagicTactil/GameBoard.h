//
//  GameBoard.h
//  MagicTactil
//
//  Created by cedric on 22/08/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

/* Imports */
#import                                                             <UIKit/UIKit.h>
#import                                                             <AVFoundation/AVFoundation.h>
#import                                                             <QuartzCore/QuartzCore.h>
#import                                                             <AudioToolbox/AudioToolbox.h>
#import                                                             "UIImageView+WebCache.h"
#import                                                             "UIButton+WebCache.h"
#import                                                             "DeckObject.h"
#import                                                             "CardObject.h"
#import                                                             "AppDelegate.h"
#import                                                             "ButtonCard.h"
#import                                                             "RoomObject.h"


@interface GameBoard : UIViewController
{
    AppDelegate                                                     *appDelegate;
    NSMutableArray                                                  *listDeck;
    NSMutableArray                                                  *listHand;
    NSMutableArray                                                  *listCardsOpponent;
    ButtonCard                                                      *currentCardOpponent;
    
    areaType                                                        cardIntersection;
    
    int                                                             cardsInDeck;
    int                                                             cardsInGraveyard;
    int                                                             cardsInExiled;
}

/* Actions */
- (IBAction)clickDeck:(UIButton *)sender;
- (IBAction)changePoints:(UIStepper *)sender;
- (IBAction)clickLoose:(UIButton *)sender;

/* Properties */
@property (weak, nonatomic) IBOutlet UIScrollView *handZone;
@property (weak, nonatomic) IBOutlet UIView *deckZone;
@property (weak, nonatomic) IBOutlet UIView *graveyardZone;
@property (weak, nonatomic) IBOutlet UIView *exiledZone;
@property (weak, nonatomic) IBOutlet UIScrollView *playerZone;
@property (weak, nonatomic) IBOutlet UIScrollView *opponentZone;
@property (readwrite, nonatomic) AVAudioPlayer  *audioPlayer;
@property (weak, nonatomic) IBOutlet UILabel *labelMyPseudo;
@property (weak, nonatomic) IBOutlet UILabel *labelOpponent;
@property (weak, nonatomic) IBOutlet UILabel *labelCardsInDeck;
@property (weak, nonatomic) IBOutlet UILabel *labelCardsInGraveyard;
@property (weak, nonatomic) IBOutlet UILabel *labelCardsInExiled;
@property (weak, nonatomic) IBOutlet UILabel *labelPoints;
@property (weak, nonatomic) IBOutlet UILabel *labelPointsOpponent;
@property (weak, nonatomic) IBOutlet UILabel *playerLabel;
@property (weak, nonatomic) IBOutlet UILabel *opponentLabel;
@property (weak, nonatomic) IBOutlet UILabel *handLabel;
@property (weak, nonatomic) IBOutlet UILabel *exiledLabel;
@property (weak, nonatomic) IBOutlet UILabel *graveyardLabel;
@property (weak, nonatomic) IBOutlet UILabel *deckLabel;

/* Methods */
- (void)initObjects;
- (void)translate;
- (void)initHand;
- (void)initPlayersNames;
- (void)initCountersCards;
- (void)checkIntersection:(ButtonCard*)sender withEvent:(UIEvent*)event;
- (void)handleIntersection:(ButtonCard*)sender withEvent:(UIEvent*)event;
- (void)handleIntersectionHand:(ButtonCard*)sender withEvent:(UIEvent*)event;
- (void)handleIntersectionGraveyard:(ButtonCard*)sender withEvent:(UIEvent*)event;
- (void)handleIntersectionExiled:(ButtonCard*)sender withEvent:(UIEvent*)event;
- (void)handleIntersectionGame:(ButtonCard*)sender withEvent:(UIEvent*)event;
- (void)handleIntersectionDeck:(ButtonCard*)sender withEvent:(UIEvent*)event;
- (void)handleIntersectionNill:(ButtonCard*)sender withEvent:(UIEvent*)event;
- (void)handleLongTap:(UIGestureRecognizer*)sender;
- (void)initAudioPlayer;
- (void)sendMoveCard:(NSString*)request;
- (void)checkMoveCard:(NSNotification *)notification;
- (void)getCurrentCardOpponent:(NSString*)request;
- (void)getCurrentCardOpponentOnTap:(NSString*)request;
- (void)handleCurrentCard;
- (void)sendTapHorizontalCard:(NSString*)request;
- (void)checkTapHorizontalCard:(NSNotification *)notification;
- (void)sendTapVerticalCard:(NSString*)request;
- (void)checkTapVerticalCard:(NSNotification *)notification;
- (void)sendUpdatePoints:(NSString*)request;
- (void)checkupdatePoints:(NSNotification *)notification;
- (void)sendLoose:(NSString*)request;
- (void)checkLoose:(NSNotification *)notification;
- (void)cleanGameBoard;

@end
