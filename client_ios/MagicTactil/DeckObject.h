//
//  DeckObject.h
//  MagicTactil
//
//  Created by cedric on 21/08/13.
//  Copyright (c) 2013 Ekhoo. All rights reserved.
//

/* Imports */
#import                                                             <Foundation/Foundation.h>

@interface DeckObject : NSObject
{
    
}

/* Properties */
@property (readwrite, nonatomic) NSString                           *deckName;
@property (readwrite, nonatomic) NSString                           *isReal;
@property (readwrite, nonatomic) NSString                           *idDeck;
@property (strong, nonatomic) NSMutableArray                        *listCards;

- (id)init;

@end
