//
//  ButtonCard.m
//  MagicTactil
//
//  Created by cedric on 23/08/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

#import "ButtonCard.h"

@implementation ButtonCard

/**
 *  Initialise la vue
 *
 *  @param frame la taille de la vue
 *
 *  @return la vue
 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

/**
 *  Initialise le boutton
 */
- (void)initButtonCard
{
    self.oldPosition = DECK;
    
    self.drag = NO;
    self.isSided = NO;
    self.isZoomed = NO;
    self.isAnimating = NO;
    
    self.isInHand = NO;
    self.isInGame = NO;
    self.isInGraveyard = NO;
    self.isInView = NO;
    self.isExiled = NO;
    self.isInDeck = YES;
}

/**
 *  Réinitialise le boutton
 */
- (void)resetArea
{
    self.isInHand = NO;
    self.isInGame = NO;
    self.isInGraveyard = NO;
    self.isInView = NO;
    self.isExiled = NO;
    self.isInDeck = NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
