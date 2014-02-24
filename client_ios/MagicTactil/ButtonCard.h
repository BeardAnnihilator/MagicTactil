//
//  ButtonCard.h
//  MagicTactil
//
//  Created by cedric on 23/08/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

/* Imports */
#import                                                             <UIKit/UIKit.h>

typedef enum areaType : NSUInteger
{
    HAND,
    DECK,
    VIEW,
    GAME,
    GRAVEYARD,
    EXILED,
    NILL
}                       areaType;

@interface ButtonCard : UIButton
{
}

/* Actions */

/* Properties */
@property (readwrite, nonatomic) BOOL isInHand;
@property (readwrite, nonatomic) BOOL isInView;
@property (readwrite, nonatomic) BOOL isInGame;
@property (readwrite, nonatomic) BOOL isInGraveyard;
@property (readwrite, nonatomic) BOOL isExiled;
@property (readwrite, nonatomic) BOOL isInDeck;
@property (readwrite, nonatomic) areaType oldPosition;
@property (readwrite, nonatomic) int oldX;
@property (readwrite, nonatomic) int oldY;
@property (readwrite, nonatomic) BOOL drag;
@property (readwrite, nonatomic) BOOL isSided;
@property (readwrite, nonatomic) BOOL isZoomed;
@property (readwrite, nonatomic) BOOL isAnimating;

@property (readwrite, nonatomic) int idCard;
@property (readwrite, nonatomic) NSString *url;
@property (readwrite, nonatomic) NSString *src;
@property (readwrite, nonatomic) NSString *dest;
@property (readwrite, nonatomic) int    pourcentX;
@property (readwrite, nonatomic) int    pourcentY;
@property (readwrite, nonatomic) NSString *clientName;
@property (readwrite, nonatomic) NSString *roomName;
@property (readwrite, nonatomic) NSString *idGame;

/* Methods */
- (void)initButtonCard;
- (void)resetArea;

@end
